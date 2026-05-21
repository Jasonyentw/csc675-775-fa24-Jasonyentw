# Milestone 5: Final Project  (5 points)

In this milestone, you will create a Discord bot that acts as an interface between the database system you developed in 
this class and the end users of your application. The main goal is to transform the data (output from your business 
requirements) into knowledge that meets the user's needs.

**IMPORTANT NOTE:** Although I provide Python code for this project, I strongly advise against using it if you are not 
familiar with Python. If you are more comfortable with another programming language, use that to create your bot. 
In my experience, students who attempt this project in Python without prior knowledge of the language often struggle, 
spending too much time fixing syntax errors rather than focusing on the key aspects of this milestone.

## Milestone 4: Table of Contents

1. [Getting Started](#head1)
2. [User Interface (Bot) Setup](#head2)
3. [Hosting Your Database Remotely](#head3)
4. [Hosting Your Bot on Replit](#head4)
5. [Implementation and Testing ](#head5)
6. [Grading Rubrics](#head6)
7. [Submission Guidelines](#head7)
8. [Final Notes](#head8)

--- 

## <a id="head1"></a> Getting Started

Bots are increasingly popular and sometimes essential in modern applications because they can automate processes, 
handle data from storage systems (e.g., databases), and provide specific services to users.

This tutorial is structured to guide you through successfully completing your project, which will culminate in 
creating a fully functional Discord bot. This bot will serve as an interface to interact with the database you have 
designed, architected, and hosted throughout the course.

You are free to choose your favorite programming language for this project, provided it offers the necessary 
connectors and capabilities to connect to your remote MySQL database. I will provide some Python code to help you 
get started. However, here are useful resources for those using a different programming language:

* [How to create a Discord Bot with Java](https://medium.com/discord-bots/making-a-basic-discord-bot-with-java-834949008c2b)
* [How to create a Discord Bot with JavaScript](https://www.freecodecamp.org/news/create-a-discord-bot-with-javascript-nodejs/)

> **Important:** In this milestone, you MUST host the database system you created in previous milestones on a remote 
cloud service of your choice. In class, we will have a lecture demonstrating how to host a database in AWS using an 
RDS instance. If you do not attend this lecture, you are responsible for catching up on what you missed.


---

## <a id="head2"></a> User Interface (Bot) Setup

Let's get started by setting up your Discord server. In this section, you will create a Discord server and set up a bot to be used within it.

### Discord Account

If you do not have a Discord account yet, create one [here](https://discord.com). If you already have a Discord account, you can skip this step.

### Creating a Discord Server

We will use a Discord server as the user interface between your bot and the users.

1. Go to the [Discord home page](https://discord.com) and sign in using your Discord account if needed.
2. On the left-hand panel, click the "+" icon to add a new server.
3. You will be prompted with two options; select "Create Your Server" and provide a meaningful name for your server.
4. Create the following channels in your Discord server:
   ```
      #commands
      #testing
    ```

### Commands Channel

In the `#commands` channel, list the commands your bot needs to execute to address each of your business 
requirements. Additionally, provide real examples of how to run each command. Please note that your bot commands must 
accept user input, and you may need to modify your SQL code to prevent SQL injection attacks, as discussed in class.

For example:

   
   ```discord
      Business Requirement: Comprehensive User Profile Management with Derived Attributes
      Command: !get_user_profile <user_id: value>
      Usage Example: !get_user_profile user_id: 1
   ```

### Testing Channel

In the `#testing` channel, you will test your commands. This channel will also be used to grade your commands.

### Discord Application

A Discord application allows your bot to interact with the Discord API. Like many other APIs, you'll need to provide authentication and permissions. Applications in Discord serve as a high-level abstraction to facilitate communication between the Discord API and your bot.

1. In your [Discord Developer Portal](https://discord.com/developers/applications), click the "New Application" button to create a new application.
2. You will be prompted to enter a name for the application. Use the name "CSC675M5" for your application, and save the changes.
3. You will now see all the information about your new application.

### Discord Bot

Once your application is created, it's time to create your bot user. The bot user will react to certain events and commands triggered by the user.

1. In the left panel of your application in the [Developer Portal](https://discord.com/developers/applications), select the "Bot" tab, and click the "Add Bot" button on the right panel.
2. After the bot is successfully created, edit the name of your bot. Set the new name to "CSC675<your SFSU username>Bot", where your SFSU username is the part before the "@" in your SFSU email. For example, if your SFSU email is jortizco@sfsu.edu, you would name your bot "CSC675jortizcoBot" (without quotes).
3. Click on the "Reveal Token" link located below the username field of your bot. This token will be used later to provide authentication when the bot needs to access the Discord API of your application. We will use this token later when coding the bot.
4. Save all changes.

### Adding Your Bot to Your Server

Finally, we'll complete the setup of our application by registering our bot to our server. Note that bots use the [OAuth2 protocol](https://oauth.net/2/), and we need to set up the bot to use this protocol.

1. In your [Developer Portal](https://discord.com/developers/applications), click on your application.
2. In the left-hand panel of your application, select the "OAuth2" tab. This tool will authorize the use of Discord APIs for your bot using your application's credentials.
3. On the right panel, set the authorization method to "In-app Authorization," and then in "Scopes," check the "bot" checkbox.
4. In the "Bot Permissions" section, enable all the "Intents" permissions, then set the "Bot Permissions" to "Administrator."
5. Copy the client ID found in "Client Information."
6. Use the following link: `https://discordapp.com/oauth2/authorize?&client_id=YOUR_CLIENT_ID_HERE&scope=bot`, and replace `YOUR_CLIENT_ID_HERE` in the URL with the client ID from step 5.

## <a id="head3"></a> Hosting Your Database Remotely

For this milestone, you must host your database model remotely (localhost is not allowed). You are free to choose any hosting server to host your databases. Some examples of remote hosts where you can host a relational database for free include [AWS](https://aws.amazon.com/free/database/?trk=c0fcea17-fb6a-4c27-ad98-192318a276ff&sc_channel=ps&sc_campaign=acquisition&sc_medium=ACQ-P%7CPS-GO%7CBrand%7CDesktop%7CSU%7CDatabase%7CSolution%7CUS%7CEN%7CText&s_kwcid=AL!4422!3!548665196301!e!!g!!amazon%20relational%20db&ef_id=CjwKCAjw3K2XBhAzEiwAmmgrAoE1SvlDFAECMaxijNoBwdjfg6U6GcmNkrqIVqPruWdH2TxNSS5N9xoCJ_oQAvD_BwE:G:s&s_kwcid=AL!4422!3!548665196301!e!!g!!amazon%20relational%20db), [Google Cloud](https://cloud.google.com), and [Microsoft Azure](https://azure.microsoft.com/en-gb/free/). Note that whichever remote database host you choose, you must have permissions to run stored SQL triggers, procedures, and functions. In class, we will have a lecture demonstrating how to create a remote RDS instance in AWS.

Once your cloud instance is set up, create a database there and configure it to allow external connections. After the database is created, connect to it from MySQL Workbench and run your `databasemodel.sql` script to create the tables in your new remote database. Then, run the `inserts.sql` script from MySQL Workbench to populate your remote database with data.

After your database has been created and populated with sample data in your remote host server, make sure to record the following information provided by your database host server (you will need this later):

- The host URL
- The name of the database
- Your database username
- Your database password

> **IMPORTANT:** Please refrain from spending money to host your database remotely. Most popular cloud hosting services (except Heroku) offer free trial accounts that are free as long as you don't use any paid features or exceed resource limits. For this project, you won’t need any special features or additional resources from the remote host. Note that the university, CS department, and the course instructor are not responsible for any charges applied to your account on your remote server for this project. It is your responsibility to ensure that your remote database is not using paid features or additional resources.

---

## <a id="head4"></a> Hosting Your Bot on Replit

For this milestone, it is mandatory that you host your bot on [Replit](https://replit.com). This helps minimize system incompatibilities during the grading process. Please do not host your database directly on Replit, as it does not offer built-in support for MySQL.

The following steps will guide you to creating your bot (either manually or by importing this repository) on [Replit](https://replit.com):

1. Create a new account on [Replit](https://replit.com) (if you don't have one already).
2. Log in using the email and password from step 1.
3. Create a new Repl in your account. Note that Replit supports many programming languages. Choose the same programming language for your Repl that you used in Checkpoint VIII to implement the database, models, and tests files.
4. Name your Repl. The name of your Repl must be your SFSU username followed by "bot." For example, if your SFSU email is jortizco@sfsu.edu, then your Repl would be named "jortizcobot."
5. If everything is set up correctly, you will see your new programming environment for your Repl. Take some time to familiarize yourself with this environment.
6. Copy and paste all the files from this directory into your workspace in Replit.


### Secret Environment Variables

Your Replit app allows you to set up secret environment variables, such as tokens, database usernames, and passwords. 
We'll use this feature to configure all the environment variables related to our bot and database.

Head to the left-hand panel of your application, and click on the lock icon.  
Once there, set the following secret environment variables and their values:


```.env
DISCORD_TOKEN= dicord token of your bot
DB_HOST=       the host url where your remote database is hosted. (localhost won't work here)
DB_USER=       db username 
DB_PASSWORD=   db password
DB_NAME =      database name 
```

You can copy the Discord token from the Bot tab in your [Developer Portal](https://discord.com/developers/applications).

Note that you don't need to modify the code related to the secret environment variables in `main.py` and `database.py`. The code is already set up to read from the values assigned to these keys. For example, `host = os.environ["DB_HOST"]` will store the database host in the `host` variable.

Now, your bot is ready to be tested. Click on the "RUN" button in your application. If the app runs without errors, you should see a message in the application console stating that your bot is online and connected to your database. If your app throws errors or the bot is not online or connected to your remote database, please review the setup process to ensure no mistakes were made. If needed, don't hesitate to reach out to the instructor for help.

---

## <a id="head5"></a> Implementation and Testing 

In this section, you will implement all the backend components needed to meet your business requirements. The backend of your bot will be developed using an optimized version of the SQL code you implemented in Milestone 4 for your business requirements, along with your preferred programming language and the implementation of your ORM plan from Milestone 4. This will help optimize the performance of your database system.

> **Note: Any query created to solve your business requirements MUST be fully optimized and MUST implement SQL techniques to prevent injection attacks, as outlined in the security category of your non-functional requirements from Milestone 1.**

To complete this milestone, you will work with the `database.py`, `models.py`, and `tests.py` files. If you are using a programming language other than Python, you will need to change the file extensions and adapt the code to match your chosen language.

> **IMPORTANT: All backend implementation for this milestone MUST be done in Replit.**


### Bot Implementation

In this section, the bot interface must be connected to the backend where all the object modeling and queries were implemented. Pay special attention to error handling and command validation. Your app should function as expected, even when the user enters unexpected input. Performing input validation in both the bot interface and backend components of the app is essential to achieve a good grade on this project.

The following is a description of the code you must implement in your project.

#### Database Logic

The logic of your database (queries and methods) must be implemented in the `database.py` script or its equivalent in the programming language of your choice.

The `database.py` file is ready to be used, although it will need further implementation for more advanced features, such as running Stored SQL Functions and Procedures.

### Object-Relational Mapping (ORM)

Object-Relational Mapping (ORM) is a technique that allows developers to interact with a relational database using an object-oriented paradigm. An ORM converts data between incompatible systems (such as objects in a programming language and rows in a relational database) and provides a layer of abstraction over raw SQL queries. This makes it easier to work with databases using the programming language's syntax and constructs rather than writing SQL code directly.

Although many popular ORM tools already exist, such as SQLAlchemy for Python, in this project, you will implement your ORM plan to understand the WHAT, HOW, and most importantly, WHY ORM is a critical component in applications that interact with databases.

All your ORM implementation in this project will be performed in the `models.py` file. Models in this file are only aware of the process to call a method from `database.py`, but they are not aware of how this method is implemented. In other words, models in this file know the WHAT, but not the HOW, of how the data is manipulated in the database.

For example, to model the business requirement `Role-Based Access Control with Expiry Dates` from our LibrarySystemDB database 
we create the proper implementations as follows:


```python
# database.py
# -- snip --
class Query: 
    # all your SQL implementation goes here
    ROLE = """SELECT Role.role_id, Role.type, UserRole.expires FROM UserRole
              JOIN Role ON Role.role_id = UserRole.role_id
              JOIN RegisteredUser ON RegisteredUser.user_id = UserRole.user_id
              WHERE RegisteredUser.user_id = %s
           """
    ADDRESS = """SELECT * FROM Address WHERE address_id = %s"""
    REGISTERED_USER = """SELECT * FROM RegisteredUser WHERE user_id = %s"""
    PROCAssignUserRole = """AssignUserRole"""
    PROCAccessFeature = """AccessFeature"""
    # -- snip --
class Table:
    REGISTERED_USER = "RegisteredUser"
    ADDRESS = "Address"
    ROLE = "UserRole"

```
Next, we create the correspondent models so the bot can easily access this data.
```python

# models.py
# -- snip -- 

from database import *

class ModelInterface:
    
    def synchronize(self):
        pass

    def update(self, data):
        pass

    def delete(self, condition=None):
        pass

    def unwrap(self):
        pass

class ModelFactory: 
    """
    Makes and get all the models
    """

    @staticmethod
    def make(table_identifier, data):
        Database.insert(data, into: table)
        return Model.getBy(data.id)

    @staticmethod
    def getBy(table_identifier, entity_identifier):
        if table_identifier == Table.RegisteredUser: 
            return RegisteredUserModel(entity_identifier)
        
    @staticmethod
    def drop(model):
        # not implemented for this example
        pass
    
    @staticmethod
    def alter(model, attribute, expression):
        # not implemented for this example
        pass
        
  
class RegisteredUserModel(ModelInterface):
     # implements met
     def __init__(self, identifier):
         # -- snip -- 
         self.user_id = identifier 
         self.email = None
         self.roles = [] # to get all the roles assigned to this user 
         self.address = None 
         #  -- Implementations for all the other properties were skipped for this example
         # -- snip -- 
         self._getData()
         
         
     
     # Implementations for all the other methods in ModelInterface were skipped for this example.
     
        
     def _getData(self):
        """
        identifier: the user id (PK)
        Populates the properties from this model with the data from the entity which
        user_id matches with the identifier 
        """
        
        # maps the data that belongs to this model from the database
        user_data = Database.select(QUERY.REGISTERED_USER, values=(self.user_id))
        
       
        if not user_data: 
            # the identifier didn't match data or there was a database internal error.
            # check the logs in your console for more details
            # in either of these cases, this method will return a None instance of this object
            return None 
        
        # There is data mapped by this model. So, assign the values mapped based on all the properties of the model
        user_data_instance = user_data[0]
        self.email = user_data_instance['email']
        # assigns the model address
        address_id = user_data_instance['address']
        self.address = ModelFactory.getBy(Table.ADDRESS, values = (address_id))
        # retrieve all the roles held by this user
        roles = Database.select(Query.ROLES, values(self.user_id))
        for role_data in roles: 
            role_id = role_data['role_id']
            role = ModelFactory.getBy(Table.ROLE, values=(role_id))
            self.roles.append(role)
        #  -- Mapping implementations for all the other properties were skipped for this example\
      
     def is_admin(self):
         for role in self.roles:
             if role.type == "Admin"
                 return True
         return False
     
     def assign_role(self, user_id, role_id, expiration_date):
         data = (user_id, role_id, expiration_date)
         Database.callprocedure(Query.PROCAssignUserRole, values = data)
             
     def access_feature(self):
         data = (self.user_id, self.role.role_id)
         result = Database.callprocedure(Query.PROCAccessFeature, values=data, fetch=True)
         status = result[0]["Status"]
         if status == "Access Granted":
             return True
         return False
    
             
# -- snip -- 

# implementation of models Address and Roles were not implemented


     
```

It is crucial to notice that the ```RegisteredUserModel``` is not aware of HOW the database manipulates the data or other 
processes involving database logic such as database connections or keeping track or memory leaks created by connections 
that were not properly closed because the ```database.py``` file is already implementing and abstracting all this logic


All the models that you implement must not contain any database logic or queries in their implementation. They are only aware about the WHAT not the HOW
of the database implementation as seen in the example provided above.

### Bot Logic

The bot logic is implemented in ```main.py``` file. This file is neither aware of the WHAT and HOW methods from ```models.py```
and ```database.py``` files are implemented. That's it, the ```main.py``` file is only in charge to pass along the data returned
by a model to the Discord interface so the data can be served to the user that executed the command with the request.

The following is an example implementation of one of the command ```!assing_role user_id:12, role_id:1, expiration: 2024-08-30 12:00:00``` by our bot.

```python
#main.py
from models.py import *
# -- snip --
@bot.command(name="assign_role", description="assigns a role only if the user is an admin.")
async def _assign_role(ctx, user_id, role_id, expiration):
      user_id = user_id.split(":")[1]
      role_id = role_id.split(":")[1]
      expiration = expiration.split(":")[1]
      # creates the registered user model
      user = ModelFactory.getBy(Table.RegisterdUser, user_id)
      if user.is_admin():
          user.assing_role(user_id, role_id, expiration)
          response = f"Role: {role_id} successfully assigned to user {user_id}"
      else: 
          response = f"User {user.name} with id {user.user_id} is not an admin"
      await ctx.send(response)
# -- snip --
```
### Bot Testing

Once your bot implementation is complete, use the `#testing` channel on Discord to test your commands. Feel free 
to share your Discord server link with other students in the course so they can help test your bot commands as well.

---

# <a id="head6"></a> Grading Rubrics

The following grading rubrics will be used by the TA and the instructor to evaluate the work submitted by students in this milestone:

1. **Completion of Sections**
   - All sections of this milestone must be fully completed. Incomplete work or sections that do not strictly adhere
     to the submission guidelines may negatively impact your final grade for this milestone. No exceptions.

2. **AI Detection**
   - Work flagged by our AI detection tools will receive a temporary grade of zero until the issue is resolved. 
     If compelling evidence indicates that the work was created by AI tools like ChatGPT, we will follow university policies regarding academic dishonesty.

3. **Final Grades**
   - Once a grade is assigned to a milestone, it will not be changed unless the TA or instructor made an error during 
    the grading process. Please refer to the syllabus for details on grade appeals.

4. **Late Submissions**
   - Late submissions will incur penalties. A 10% deduction will be applied for each day the assignment is overdue, up 
   to a maximum of three days. After three days, the assignment will be considered as not submitted and will be graded as such.

5. **Links Provided** 
  - If any of the links you submit on Canvas for this milestone are broken or expired, you will receive 
    no credit for this milestone. If we can't access your work, we can't grade it.


## Detailed Section Grading

Our TAs will use the following rubrics to grade your milestone:

### Discord Server

1. **-5 points**: No work submitted or broken links.
2. **-3 points**: Expected requirements are not met for your `#commands` channel.
3. **-1 point**: For each command that is not properly implemented or returns incorrect data
4. **-0.2 points**:
   - For each command where user input is not validated.
   - For each command that returns raw data instead of meaningful information for the user.


### Replit Workspace

1. **-5 points**: If no work is submitted, there are broken links, or the bot cannot be put online.
2. **-3 points**: 
    - If the bot is online but cannot connect to your remote database instance.
    - If the ORM plan from Milestone 4 has not been implemented in your code.
3. **-0.5 points**: 
    - For each business requirement implementation that has not been optimized.

---

# <a id="head7"></a> Submission Guidelines

Please carefully follow these submission guidelines for this milestone:

   * ***Reference Python Files:*** Upon completing this milestone, upload to this directory all your files you implemented
    in Replit. Note that we will only run these files in Replit, but we need them also here for our reference
      
     Please note that if your files are not found in this directory at the time of grading, it will be considered 
     as not submitted, even if it was mistakenly placed in a different directory.

   * ***On Canvas:*** Submit the following three links:
     + Provide a link to join your Discord server, ensuring that the link does not have an expiration date.
     + Provide a link to join your Replit's workspace, make it private.
     + Provide a link pointing to this directory of your GitHub repository

> **These submission guidelines are essential to ensure fair and consistent grading for everyone. It is crucial that 
your submission strictly follows these instructions. Failure to comply with these guidelines may result in a significant
deduction of points.** 

---

# <a id="head8"></a> 🎉 Congratulations! 🎉

You’ve reached the end of the semester and completed the final assignment! I want to take a moment to congratulate 
on your hard work, dedication, and perseverance throughout this course. 

Your commitment to learning and growth has been inspiring, and I’m incredibly proud of the progress you’ve made. 
Whether you faced challenges head-on or celebrated victories along the way, you’ve shown resilience and determination. 

Thank you for all your effort and participation. I hope the skills and knowledge you’ve gained will serve 
you well in your future endeavors.

Best of luck in your exams and future courses!



















 




