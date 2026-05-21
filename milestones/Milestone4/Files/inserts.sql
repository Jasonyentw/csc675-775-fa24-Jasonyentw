-- This file inserts sample data to populate FinancialTrackingToolDB database
USE FinancialTrackingToolDB;

-- Insert into PaymentCategory
INSERT INTO `PaymentCategory` (`PaymentCategory_id`, `type_name`, `color_code`) VALUES
(0, 'Default', '#000000'),
(1, 'Groceries', '#FF5733'),
(2, 'Entertainment', '#33FF57'),
(3, 'Transportation', '#3357FF'),
(4, 'Utilities', '#FF33A6');

-- Insert into Expense
INSERT INTO `Expense` (`Expense_id`) VALUES
(1),
(2),
(3),
(4);

-- Insert into Payment Transaction
INSERT INTO `Payment Transaction` (`Payment_Transaction_id`, `amount`, `store_name`, `date`, `note`, `PaymentCategory_id`, `Expense_id`) VALUES
(1, 100, 'SuperMart', '2024-10-01', 'Grocery shopping', 1, 1),
(2, 50, 'Cinema', '2024-10-05', 'Movie night', 2, 1),
(3, 30, 'Bus Ticket', '2024-10-10', 'Transportation', 3, 1),
(4, 150, 'Electricity Bill', '2024-11-15', 'Monthly utilities', 4, 1);


-- Insert into EarningCategory
INSERT INTO `EarningCategory` (`EarningCategory_id`, `type_name`, `color_code`) VALUES
(1, 'Salary', '#FFD700'),
(2, 'Freelance', '#FF6347'),
(3, 'Stocks', '#FFFFFF');

-- Insert into Income
INSERT INTO `Income` (`Income_id`) VALUES
(1),
(2),
(3);

-- Insert into IncomeTransaction
INSERT INTO `IncomeTransaction` (`Income_Transaction_id`, `amount`, `source_name`, `date`, `note`, `EarningCategory_EarningCategory_id`, `Income_id`) VALUES
(1, 2000, 'Company A', '2024-10-01', 'Monthly salary', 1, 1),
(2, 500, 'Freelance Project', '2024-10-10', 'Web development', 2, 1),
(3, 1000, 'Stocks', '2024-10-20', 'Investment', 3, 1);

-- Insert into Budget
INSERT INTO `Budget` (`Budget_id`, `amount`, `PaymentCategory_id`) VALUES
(1, 300, 1),
(2, 100, 2),
(3, 50, 3),
(4, 200, 4);

-- Insert into Saving
INSERT INTO `Saving` (`Saving_id`, `amount`, `target_goal_note`) VALUES
(1, 500, 'Vacation fund'),
(2, 200, 'Emergency fund'),
(3, 600, 'Food fund');
-- Insert into Account
INSERT INTO `Account` (`account_id`, `creation_date`, `Role_type`, `Expense_id`, `income_id`, `Budget_id`, `Saving_id`) VALUES
(1, '2024-10-01', 0x02, 1, 1, 1, 1),
(2, '2024-10-05', 0x01, 2, 2, 2, 2),
(3, '2024-10-07', 0x03, 3, 3, 3, 3);

-- Insert into User
INSERT INTO `User` (`user_id`, `user_name`, `user_password`) VALUES
(1, 'john_doe', 'password123'),
(2, 'jane_smith', 'mypassword'),
(3, 'jose_lin', 'my[assword');

-- Insert into RegisteredUser
INSERT INTO `RegisteredUser` (`email`, `user_id`, `account_id`) VALUES
('john.doe@example.com', 1, 1),
('jane.smith@example.com', 2, 2),
('jose@exmaple.com', 3, 3);

-- Insert into Chart
INSERT INTO `Chart` (`Chart_id`, `type`) VALUES
(1, 'Bar Chart'),
(2, 'Pie Chart'),
(3, 'Bar Chart');

-- Insert into VisualizePreference
INSERT INTO `VisualizePreference` (`Visualize_Preference_id`, `start_date`, `end_date`) VALUES
(1, '2024-10-01', '2024-10-31'),
(2, '2024-11-01', '2024-11-30'),
(3, '2024-09-01', '2024-09-30');


-- Insert into Dashboard
INSERT INTO `Dashboard` (`Dashboard_id`, `account_id`) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Insert into Visualize
INSERT INTO `Visualize` (`Visualize_id`, `Dashboard_id`, `Visualize_Preference_id`, `Chart_id`) VALUES
(1, 1, 1, 1),
(2, 2, 2, 2),
(3, 3, 3, 3);

-- Insert into HistoricalComparingPreference
INSERT INTO `HistoricalComparingPreference` (`HistoricalComparingPreference_id`, `start_date`, `end_date`) VALUES
(1, '2024-10-01', '2024-10-31'),
(2, '2024-11-01', '2024-11-30'),
(3, '2024-09-01', '2024-09-30');

-- Insert into HistoricalComparing
INSERT INTO `HistoricalComparing` (`HistoricalComparing_id`, `HistoricalComparingPreference_id`, `Dashboard_id`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);

-- Insert into BudgetComparingPreference
INSERT INTO `BudgetComparingPreference` (`BudgetComparingPreference_id`, `start_date`, `end_date`) VALUES
(1, '2024-10-01', '2024-10-31'),
(2, '2024-09-01', '2024-09-30'),
(3, '2024-11-01', '2024-11-30');

-- Insert into BudgetComparing
INSERT INTO `BudgetComparing` (`BudgetComparing_id`, `BudgetComparingPreference_id`, `Dashboard_id`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);

-- Insert into Notification
INSERT INTO `Notification` (`Notification_id`, `user_id`, `alert_message`) VALUES
(1, 1, 'Reminder to pay your electricity bill'),
(2, 2, 'Reminder to pay your electricity bill'),
(3, 2, 'New budget comparison available');

-- Insert into Report
INSERT INTO `Report` (`Report_id`, `report_date`, `account_id`, `month`) VALUES
(1, '2024-10-31', 1, 'October'),
(2, '2024-11-30', 2, 'November'),
(3, '2024-10-29', 2, 'October');

-- Insert into summarize
INSERT INTO `summarize` (`Report_id`, `summary_id`) VALUES
(1, 1),
(2, 2),
(3, 3);
