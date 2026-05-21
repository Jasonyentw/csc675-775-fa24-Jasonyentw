-- This file provides a SQL based solution to the following database
-- business requirements for the FinancialTrackingToolDB database
USE FinancialTrackingToolDB;
-- /*
--      Business Requirements #1
--      ----------------------------------------------------
--      Purpose: Generate Transaction Reports
--      
--      Description: Through the report, users can view transactions within a selected time period, 
-- 				  including details such as the date, category, amount, month, total expenses and income. 
--      
--      Challenge:   Since transactions are divided into payment and Income types, 
--                   it is necessary to first differentiate between them, 
--                   then calculate their respective averages and totals. 
--                   Finally, a dynamic report should be generated to display the details.
--      
--      Implementation Plan:
--         1. Create a view with PaymentTransaction and Incometransaction.
--         2. Create a function to calculate transaction total.
--         3. Create a procedure to generate dynamic reports according to user's input.
--         4. Provide exmaple usage.
-- 	
--   
-- */
--  

DELIMITER $$

-- 1
CREATE VIEW Transactions AS
-- combin income and expense transactions
SELECT 
    ptran.date AS TransactionDate,
    'Expense' AS TransactionType,
    pcat.type_name AS Category,
    ptran.amount AS Amount,
    ptran.store_name AS Description,
    ptran.Expense_id AS ExpenseID,
    NULL AS IncomeID
FROM `Payment Transaction` ptran
JOIN PaymentCategory pcat ON ptran.PaymentCategory_id = pcat.PaymentCategory_id

UNION ALL

SELECT 
    itran.date AS TransactionDate,
    'Income' AS TransactionType,
    ecat.type_name AS Category,
    itran.amount AS Amount,
    itran.source_name AS Description,
    NULL AS ExpenseID,
    itran.Income_id AS IncomeID
FROM `IncomeTransaction` itran
JOIN EarningCategory ecat ON itran.EarningCategory_EarningCategory_id = ecat.EarningCategory_id;

$$

-- 2
CREATE FUNCTION GetTotalTransactions(
    p_user_id INT,
    p_category_name VARCHAR(255),
    p_start_date DATE,
    p_end_date DATE
) 
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(10, 2);
	-- calculate the sum of each category 
    SELECT SUM(tran.Amount) INTO v_total
    FROM Transactions tran
    JOIN Account a ON (tran.ExpenseID = a.Expense_id OR tran.IncomeID = a.Income_id)
    JOIN RegisteredUser ru ON ru.account_id = a.account_id
    WHERE ru.user_id = p_user_id
	AND tran.Category = p_category_name  
	AND tran.TransactionDate BETWEEN p_start_date AND p_end_date;

    RETURN IFNULL(v_total, 0);
END$$

-- 3
CREATE PROCEDURE GenerateTransactionReport(
    IN p_start_date DATE,
    IN p_end_date DATE,
    IN p_user_id INT
)
BEGIN

-- Show all transactions
    SELECT
		tran.TransactionType,
        tran.TransactionDate,
        tran.Category,
        tran.Amount,
        tran.Description
    FROM Transactions tran
    JOIN Account a ON (tran.ExpenseID = a.Expense_id OR tran.IncomeID = a.income_id)
    JOIN RegisteredUser ru ON a.account_id = ru.account_id
    WHERE tran.TransactionDate BETWEEN p_start_date AND p_end_date
    AND ru.user_id = p_user_id
    ORDER BY tran.TransactionType ASC, tran.TransactionDate ASC;
    
-- Show each Category total
    SELECT
		tran.Category,
        GetTotalTransactions(p_user_id, tran.Category, p_start_date, p_end_date) AS TotalAmount
	FROM Transactions tran
    JOIN Account a ON (tran.ExpenseID = a.Expense_id OR tran.IncomeID = a.income_id)
    JOIN RegisteredUser ru ON a.account_id = ru.account_id
    WHERE tran.TransactionDate BETWEEN p_start_date AND p_end_date
	AND ru.user_id = p_user_id
    GROUP BY tran.Category;
END$$

DELIMITER ;

-- 4
CALL GenerateTransactionReport('2024-10-01', '2024-10-31', 1);


/*
     Business Requirements #2
     ----------------------------------------------------
     Purpose: Customize the Category and manage the Transactions
     
     Description: The system allows users to modify the detail of the payment Category and 
				  also accesiable to edit the transactions including date, source, amount,
                  not and relate to the category type.
     
     Challenge:   Ensuring that no duplicate label happens in the Category table and also the color 
				  When users are adding the new category. And when the category get removed, the transactions
                  must be updated dynamically and be set to default. Dinamically generate new id for category
                  instead of using AUTO_INCREMENT.
				  
     
     Implementation Plan:
        1. Create a trigger to check the uniqueness
        2. Create a stored procedure to add a new category
        3. Create a stored rocedure to remove the category
        4. Create a stored procedure to update the transactions
        5. Provide example usage
  
*/

DELIMITER $$


-- 1
CREATE TRIGGER before_payment_category_insert
BEFORE INSERT ON PaymentCategory
FOR EACH ROW
BEGIN
	-- Check the duplication
    DECLARE duplicate_category INT;
    SELECT COUNT(*) INTO duplicate_category
    FROM PaymentCategory
    WHERE type_name = NEW.type_name OR color_code = NEW.color_code;

    IF duplicate_category > 0 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Duplicate type_name or color_code is not allowed.';
    END IF;
END$$

-- 2 
CREATE PROCEDURE AddPaymentCategory(
    IN p_type_name VARCHAR(45),
    IN p_color_code VARCHAR(45)
)
BEGIN
	DECLARE new_id INT;
    -- Generate new id and insert an new category label
	SELECT IFNULL(MAX(PaymentCategory_id), 0) + 1 INTO new_id -- Reference from ChatGPT
	FROM PaymentCategory;
    INSERT INTO PaymentCategory (PaymentCategory_id, type_name, color_code)
    SELECT new_id, p_type_name, p_color_code
    FROM dual
    WHERE NOT EXISTS (
        SELECT 1
        FROM PaymentCategory
        WHERE type_name = p_type_name OR color_code = p_color_code
    );

    IF ROW_COUNT() = 0 THEN
        SELECT 'Failed: Duplicate label or color code exists.' AS Message;
    ELSE
        SELECT 'Success: Category added.' AS Message;
    END IF;
END$$

-- 3
CREATE PROCEDURE RemovePaymentCategory(
    IN p_category_id INT
)
BEGIN
    DECLARE default_category_id INT;
    SET default_category_id = 0; 
	-- Add the default
    IF NOT EXISTS (SELECT 1 FROM PaymentCategory WHERE PaymentCategory_id = default_category_id) THEN
        INSERT INTO PaymentCategory (PaymentCategory_id, type_name, color_code)
        VALUES (default_category_id, 'Default', '#FFFFFF');
    END IF;

    -- update all relationship to be default
    UPDATE `Payment Transaction`
    SET PaymentCategory_id = default_category_id
    WHERE PaymentCategory_id = p_category_id;

    UPDATE `Budget` 
    SET PaymentCategory_id = default_category_id
    WHERE PaymentCategory_id = p_category_id;

    -- remove the label
    DELETE FROM PaymentCategory
    WHERE PaymentCategory_id = p_category_id;

    IF ROW_COUNT() = 0 THEN
        SELECT 'Failed: Category not found.' AS Message;
    ELSE
        SELECT 'Success: Category removed.' AS Message;
    END IF;
END$$

-- 4
CREATE PROCEDURE UpdateTransaction(
    IN p_transaction_id INT,
    IN p_new_date DATE,
    IN p_new_source VARCHAR(45),
    IN p_new_amount DECIMAL(10,2),
    IN p_new_note VARCHAR(45),
    IN p_new_category_id INT
)
BEGIN
    UPDATE `Payment Transaction`
    SET date = p_new_date,
        store_name = p_new_source,
        amount = p_new_amount,
        note = p_new_note,
        PaymentCategory_id = p_new_category_id
    WHERE Payment_Transaction_id = p_transaction_id;

    IF ROW_COUNT() = 0 THEN
        SELECT 'Failed: Transaction not found or invalid category.' AS Message;
    ELSE
        SELECT 'Success: Transaction updated.' AS Message;
    END IF;
END$$

DELIMITER ;

-- 5

CALL AddPaymentCategory('Travel', '#00FF00');
CALL RemovePaymentCategory(2);
CALL UpdateTransaction(3, '2024-11-01', 'Metro Tickets', 20.00, 'Updated Note', 1);


/*
     Business Requirements #3
     ----------------------------------------------------
     Purpose: Perform historical comparisons of the transactions across different time periods.
     
     Description:  The system allows users to customize the time perid which can be date, month or year,
				   displaying the personal finance change during the customized time. And also, show the
                   spend or income on the certain category.
				   
     
     Challenge:   Fetch the certain period of the transactions data via a user's id and calculate them 
				  by suming up and getting average. Addtionally, analyze the comparsion by displaying
				  the result of the calculation.
     
     Implementation Plan:
        1. Create a view for ExpenseTransaction 
        2. Create a function for sum up total
        3. Create a function for calculating average
        4. Create a stored procedure for historical comparison
        5. Provide example usage
  
*/  

DELIMITER $$
-- 1
CREATE VIEW ExpenseTransactions AS
SELECT 
	-- Combine the category and transaction
    ptran.date AS TransactionDate,
    pcat.type_name AS Category,
    ptran.amount AS Amount,
    ptran.Expense_id AS Expense_id
FROM `Payment Transaction` ptran
JOIN PaymentCategory pcat ON ptran.PaymentCategory_id = pcat.PaymentCategory_id$$

-- 2
CREATE FUNCTION GetTotalExpenses(
    p_user_id INT,
    p_start_date DATE,
    p_end_date DATE
)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
	-- Sum up the total
    DECLARE v_total DECIMAL(10, 2);

    SELECT SUM(extran.Amount) INTO v_total
    FROM ExpenseTransactions extran
    JOIN Account a ON a.Expense_id = extran.Expense_id
    JOIN RegisteredUser ru ON ru.account_id = a.account_id
    WHERE ru.user_id = p_user_id
	AND extran.TransactionDate BETWEEN p_start_date AND p_end_date;

    RETURN IFNULL(v_total, 0);
END$$

-- 3
CREATE FUNCTION GetAverageDailyExpenses(
    p_user_id INT,
    p_start_date DATE,
    p_end_date DATE
)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE v_average DECIMAL(10, 2);
    DECLARE v_days INT;
	-- average the amount
    SELECT DATEDIFF(p_end_date, p_start_date) + 1 INTO v_days;

    SELECT SUM(extran.Amount) / v_days INTO v_average
    FROM ExpenseTransactions extran
    JOIN Account a ON a.Expense_id = extran.Expense_id
    JOIN RegisteredUser ru ON ru.account_id = a.account_id
    WHERE ru.user_id = p_user_id
	AND extran.TransactionDate BETWEEN p_start_date AND p_end_date;

    RETURN IFNULL(v_average, 0);
END$$

-- 4
CREATE PROCEDURE CompareExpenses(
    IN p_user_id INT,
    IN p_start_date1 DATE,
    IN p_end_date1 DATE,
    IN p_start_date2 DATE,
    IN p_end_date2 DATE
)
BEGIN
	-- Display all the category expense
    SELECT 
        extran.Category,
        SUM(CASE WHEN extran.TransactionDate BETWEEN p_start_date1 AND p_end_date1 THEN extran.Amount ELSE 0 END) AS Period_1_Total,
        SUM(CASE WHEN extran.TransactionDate BETWEEN p_start_date2 AND p_end_date2 THEN extran.Amount ELSE 0 END) AS Period_2_Total,
        AVG(CASE WHEN extran.TransactionDate BETWEEN p_start_date1 AND p_end_date1 THEN extran.Amount ELSE 0 END) AS Period_1_Average,
        AVG(CASE WHEN extran.TransactionDate BETWEEN p_start_date2 AND p_end_date2 THEN extran.Amount ELSE 0 END) AS Period_2_Average
    FROM ExpenseTransactions extran
    JOIN Account a ON a.Expense_id = extran.Expense_id
    JOIN RegisteredUser ru ON ru.account_id = a.account_id
    WHERE ru.user_id = p_user_id
    GROUP BY extran.Category;
    
    -- Display overall totals for both periods
    SELECT 
        GetTotalExpenses(p_user_id, p_start_date1, p_end_date1) AS Period_1_TotalExpenses,
        GetTotalExpenses(p_user_id, p_start_date2, p_end_date2) AS Period_2_TotalExpenses,
        GetAverageDailyExpenses(p_user_id, p_start_date1, p_end_date1) AS Period_1_AverageDailyExpenses,
        GetAverageDailyExpenses(p_user_id, p_start_date2, p_end_date2) AS Period_2_AverageDailyExpenses;
END$$

DELIMITER ;

-- 5
CALL CompareExpenses(
    1, 
    '2024-10-01', 
    '2024-10-31', 
    '2024-11-01', 
    '2024-11-30'
);


/*
     Business Requirements #4
     ----------------------------------------------------
     Purpose: Role-based access control to the data
     
     Description:  The system basd on the role-based access control will 
				   restrict access to certain features. As a admin, it can
                   access all the data and browse each account's information.
     
     Challenge:   In my database, the Role types are stored as binary number but
				  the system will only exist three Role type (Admin, Manager and User). 
                  Thus, the binary number will be checked the validation.
     
     Implementation Plan:
        1. Create a function for checking Validation of Role-type
        2. Create a stored procedure to access certain feature
        3. Create a stored procedure to update the Role-type
        4. Provide example usage

  
*/
DELIMITER $$
-- 1
CREATE FUNCTION ValidateRoleType(
    p_account_id INT,
    p_required_role BINARY(15)
) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE v_role BINARY(15);
    
    -- Check the validation and access of the Role Type
    SELECT Role_type INTO v_role
    FROM Account
    WHERE account_id = p_account_id;

    IF v_role < 0x01 OR v_role > 0x03 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Invalid Role Type';
	END IF;
    
    RETURN v_role = p_required_role;
END$$

-- 2
CREATE PROCEDURE AccessFeature(
    IN p_account_id INT
)
BEGIN
    DECLARE has_access BOOLEAN;
    
    -- Validate if the user is a Manager (0x02) or higher
    SET has_access = ValidateRoleType(p_account_id, 0x02);

    IF NOT has_access THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Access Denied: Insufficient Role Permissions.';
    END IF;

    -- Access transactions
    SELECT 
		ptran.date AS Date,
        ptran.store_name AS Vendor,
        ptran.amount AS Amount,
        ptran.note AS Description
    FROM `Payment Transaction` ptran
    JOIN Expense ON Expense.Expense_id = ptran.expense_id
    JOIN Account ON Account.account_id = Expense.Expense_id
    WHERE account_id = p_account_id;
    
END$$

-- 3
CREATE PROCEDURE UpdateRoleType(
	IN p_account_id INT,
    IN p_new_role BINARY(15)
)
BEGIN
	-- update an new role
	DECLARE v_old_role BINARY(15);
    SELECT Role_type INTO v_old_role
    FROM Account
    WHERE account_id = p_account_id;
    
    IF v_old_role != p_new_role THEN
		UPDATE Account
        SET Role_type = p_new_role
        WHERE account_id = p_account_id;
		
    END IF;
END$$

DELIMITER ;
-- 4
CALL AccessFeature(1);
CALL UpdateRoleType(1, 0x03);

/*
     Business Requirements #5
     ----------------------------------------------------
     Purpose: Visualize finacial data
     
     Description:  The system allows users to select the type of visualization with date ranges
                   from the preference, and the specific category.
     
     Challenge:  There are many types of chats for visualization and the data addressing are 
				 various depend on the chart type. In this business requirement, addressing the
                 data for pie and bart graph will be the core problem.
     
     Implementation Plan:
        1. Create a stored procedure to generate Visualization
        2. Create a stored procedure to update Preference
        3. Provide example of usage
  
*/

DELIMITER $$

-- 1
CREATE PROCEDURE GenerateVisualization(
	IN p_visualize_id INT
)
BEGIN
	DECLARE v_start_date DATE;
    DECLARE v_end_date DATE;
    DECLARE v_chart_type VARCHAR(45);
    
    -- Fetch preference
    SELECT 
		vp.start_date,
        vp.end_date,
        Chart.type 
	INTO 
		v_start_date,
        v_end_date,
        v_chart_type
    FROM VisualizePreference vp
    JOIN Visualize ON Visualize.Visualize_Preference_id = vp.Visualize_Preference_id
    JOIN Chart ON Chart.Chart_id = Visualize.Chart_id
    WHERE Visualize.Visualize_id = p_visualize_id;
    
    -- Pie
    IF v_chart_type = 'Pie Chart' THEN
		SELECT
			v_chart_type AS ChartType,
			pcat.type_name AS Category,
            ROUND(
				SUM(ptran.amount) * 100 / (SELECT SUM(amount) 
                FROM `Payment Transaction` WHERE date BETWEEN v_start_date AND v_end_date), 
                2
			) 
			AS Percentage
		FROM `Payment Transaction` ptran
        JOIN PaymentCategory pcat ON pcat.PaymentCategory_id = ptran.PaymentCategory_id
        WHERE ptran.date BETWEEN v_start_date AND v_end_date
        GROUP BY pcat.type_name;
    
    -- Bar
    ELSEIF v_chart_type = 'Bar Chart' THEN
		SELECT
			v_chart_type AS ChartType,
			pcat.type_name AS Category,
            SUM(ptran.amount) AS TotalAmount
		FROM `Payment Transaction` ptran
        JOIN PaymentCategory pcat ON pcat.PaymentCategory_id = ptran.PaymentCategory_id
        WHERE ptran.date BETWEEN v_start_date AND v_end_date
        GROUP BY pcat.type_name;
    END IF;
END$$

-- 2
CREATE PROCEDURE UpdateVisualizePreference(
    IN p_account_id INT,
    IN p_start_date DATE,
    IN p_end_date DATE,
    IN p_chart_type VARCHAR(45)
)
BEGIN
    DECLARE v_preference_id INT;

    -- Insert into VisualizePreference
    INSERT INTO VisualizePreference (start_date, end_date)
    VALUES (p_start_date, p_end_date);

    SET v_preference_id = LAST_INSERT_ID();

    SELECT * FROM VisualizePreference
	WHERE Visualize_Preference_id = v_preference_id;
    
END$$

DELIMITER ;

-- 3
CALL GenerateVisualization(1);
CALL UpdateVisualizePreference(1, '2024-10-01', '2024-10-31', 'Bar Chart');

