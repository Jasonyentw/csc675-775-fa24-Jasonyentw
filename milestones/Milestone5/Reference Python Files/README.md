
## Files Provided: 

• database.py: this file must contain all the database logic and methods implemented to handle directly components from 
the database. For instance, the select, uptate, .... methods. In addition, it must contain all the SQL queries needed for 
this project that will be used by the models in model.py 

• interfaces.py: this file must contain all the interfaces for this project.

• models.py: All the models created in this file must implement the interface ModelInterface from interfaces.py. This file
should not contain SQL logic other than calling the implemented methods from database.py.

• main.py: This file contains the logic for the bot. Its methods should create models, take the data returned from these 
models, and send it to the Discord API, so it can be served to the user who requested it. 

• tests.py: This file is used during the development phase to test your functions without using the 
bot functionality to avoid being temporarily banned by the Discord API. You can also use this file to create unit tests 
for your code.

## Important Notes

• The files found in this folder are for your reference only. They are not meant to substitute your own code in this project. 

• SQL logic such as queries or other database methods must be implemented ONLY in database.py. main, models and 
interfaces files should not contain database implementations. 