# Milestone 1: Use Cases and Database Requirements  (3 points)

The goal of this milestone is to create a detailed technical document that outlines the initial design and structure 
of your database system. In this milestone, we will focus on understanding the client's or user's needs. 
These needs will be turned into use cases that engineers can work with, which will then help define 
the database requirements. Keep in mind that this document will be read by both technical 
and non-technical team members, such as CEOs, CTOs, Project Managers, Founders, Engineers, and Testers.

In this milestone, extensive research is expected. It is essential for students to thoroughly research their chosen 
database topic to create good use cases that will define the services your database system will provide to the end user. 
See also the examples provided in class for guidance.

## Milestone 1: Table of Contents

1. [Section I: Cover Page](head1)
2. [Section II: Table of Contents](#head2)
3. [Section III: Project Description](#head3)
4. [Section IV: Functional Database Requirements](#head4)
5. [Section V: Non-Functional Database Requirements](#head5)
6. [Grading Rubrics](#head6)
7. [Submission Guidelines](#head7)

---

## <a id="head1"></a> Section I: Cover Page 

Your document's cover page should include the title of your project (e.g., Library Management System), your name, 
student ID, GitHub username, and a version history table like the example shown below.

| Milestone | Date Submitted |
|----------|----------------|
| M1       | MM/DD/YYYY     |

---

## <a id="head2"></a> Section II: Table of Contents 

A technical document like this one is read by both technical and non-technical people, such as CEOs, founders, and 
engineers. Some readers may want to quickly access specific sections of this milestone and skip others. 
Including a table of contents with clickable links and page numbers will help them navigate the document more easily. 

Below you can find a snapshot example:

```
               Table of Contents
             
1. Cover page                                 page 1 
2. Table of Contents                          page 2 
3. Project Description                        page 3
4. Functional Requirements                    pages 4-8
5. Non-Functional Requirements                pages 8-12
```
---

## <a id="head3"></a> Section III: Project Description (1 point)

In this section, you will create a comprehensive description of your database system project idea. 
Keep in mind that this is a high-level overview, as the full scope of your database system is not yet defined. 
Use the following guidelines to write your product description in paragraph form.

+ Describe the motivations for creating this database system and the problems you aim to solve (high level only). 

+ Provide a high-level, non-technical description of your database system.

+ Describe the unique features (high level only) you plan to implement in your database system based on your research. 
  Include features that exist in other similar database systems that you will improve in your system.

+ Name at least two existing software tools or products currently on the market that would benefit from using your 
  database system. Explain in detail why they would benefit.

+ Create at least three use cases that define the most important services your database will provide for different 
  users and situations. 

---

## <a id="head4"></a> Section IV: Functional Database Requirements (1 point)

Functional requirements focus on the services provided to meet the needs of the database users. 

These are the hard constraints students must meet in this section:
+ Students MUST provide at least 20 entities. 
+ Every entity must contain at least 3 functional requirements. 
+ All the functional requirements must be grouped by the entity that performs the action
+ Students must cover in their functional requirements the following entity relationships:
  + Many-to-Many 
  + One-to-One 
  + Many-to-One 
  + One-to-Many 
  + ISA 
  + Aggregation 
  + Recursive

The following are examples of functional database requirements for a library database management system.

    1. User 
        1.1 A user shall create at most one account
        1.2 A user shall have a unique tracking id
        1.3 A user, without an account, shall have no specific role assigned in this system.
    
    2. Registered User
        2.1 A registered user is also a user
        2.2 A registered user has one account
        2.3 A registered user shall be able to check out multiple books at a time
        2.4 A registered user shall have at least one role in the system
        2.5 A registered user shall have a unique user id
        2.6 A registered user shall have at most one unique email 
        2.7 A registered user shall have a first name
        2.8 A registered user shall have a last name
        2.9 A registered user shall have a full name.
        2.10 A registered user shall have a phone number
        2.11 A registered user shall have only one address
        2.12 A registered user shall have an age

    3. Account 
        3.1 An account shall be owned by only and only one user.
        3.2 An account shall have an account id
        3.3 An account shall have a creation date 
        3.4 An account shall have a state to define whether the account has been validated or not
  
    4. Book 
        4.1 A book shall have a unique ISBN 
        4.2 A book shall have a title
        4.3 A book shall have an author
    
    5. Role
        5.1 A role shall be linked to many users.  
        5.2 A role shall have a unique id.
        5.3 A role shall have a type (admin, librarian manager, librarian or customer)

    6. Address
        6.1 An address shall be shared my many users 
        6.2 An address shall have a unique address id  
        6.3 An address shall have a street 
        6.4 An address shall have an apartment or house number 
        6.5 An address shall have an assigned zip code
        6.6 An address shall belong to a city 
        6.7 An address shall belong to a state 
        6.8 An address shall belong to a country

---

## <a id="head5"></a> Section V: Non-functional Database Requirements (1 point)

Non-functional database requirements focus on the constraints and properties of the database system. These requirements 
are grouped by categories (for more details, refer to your class notes and slides).

Students MUST provide at least three non-functional requirements for each of the following categories:
 
 + Performance
 + Security
 + Scalability 
 + Capability
 + Environmental
 + Coding Standard
 + Storage 
 + Privacy. 

The following are some examples of non-functional requirements for the categories of Performance, Storage and Security

     1. Performance 
         1.1 The database system shall support concurrent transactions. 
         
     2. Storage 
         2.1 The database system shall assign 10 MB of memory per table.
         2.2 The database system should support persistent storage
         
     3. Security
         3.1 Only encrypted passwords shall be supported by the database system 
         3.2 All the values inserted into the database shall be consistent with their attribute's datatype and domain. 
         3.2 The database shall be automatically backed up everyday at 11:59 pm. 

---

# <a id="head6"></a> Grading Rubrics 

The following grading rubrics will be used by the TA and the instructor to evaluate the work submitted by students in 
this milestone:

1. ***Completion of Sections***
    
   + All sections of this milestone must be fully completed. Incomplete work or assignments that do not strictly 
     follow the submission guidelines will receive a non-passing grade for this milestone. No exceptions.
   
2. ***AI Detection***

   + Work flagged by our AI detection tools will receive a temporary grade of zero until the issue is resolved. 
   If compelling evidence indicates that the work was created by AI tools like ChatGPT, we will follow university 
   policies regarding academic dishonesty.

3. ***Final Grades***

   + Once a grade is assigned to a milestone, it will not be changed unless the TA or the instructor made an error 
     during the grading process. Read the syllabus policies regarding grade appeal for more details.

4. ***Late Submissions***

   + Late submissions will be subject to penalties. A 10\% deduction will be applied for each day that the 
     assignment is overdue, up to a maximum of three days. After three days, the assignment will be considered as not 
     submitted and will be graded as such.

## Detailed Section Grading

Our TAs will use these grading rubrics to grade your milestone.

### Sections I and II

+ Sections I and II must be fully completed. If not, the student will receive a friendly reminder to correct it for the 
  next milestone.

### Section III (1 point)

+ (-1 point) is deducted for no work or poor work
+ (-0.1 points) will be deducted if the project description does not clearly state the motivations for creating the project based 
  on your research.
+ (-0.1 points) will be deducted if the project description does not include a high-level, non-technical description 
  of your database system.
+ (-0.1 points) will be deducted if the project description does not clearly describe the unique features (high level only).
+ (-0.1 points) will be deducted if the project description does not identify at least two existing software tools or products in the 
  market that would benefit from using your database system.
+ (-0.2 points) will be deducted for each missing use case or for any use case that does not follow the format of the 
   examples presented during lectures for this topic
   
### Section IV (1 point)

+ (-1 point) is deducted for incomplete submissions or for work that is clearly of poor quality.
+ (-0.4 points) are deducted if this section contains fewer than 20 entities or if any entity has fewer 
  than 3 functional requirements.
+ (-0.1 points) are deducted (per functional requirement) if:
   + Any of your functional requirements are not grouped by entities 
   + Any of your functional requirements is missing a cardinality. The only exceptions to this rule are:
      + Functional requirements representing ISA 
      + Functional requirements with Aggregation relationships
      + Functional requirements that contain attributes
+ (-0.4 points) are deducted if any of the required relationships is not represented in your functional requirements
  (i.e., none of your functional requirements implemented a many-to-many relationship)

### Section V (1 point)

+ (-1 point) is deducted for incomplete submissions or for work that is clearly of poor quality.
+ (-0.5 points) are deducted if: 
   + Your non-functional requirements are not grouped by category or any of the mandatory 
   categories expected for this section is missing 
   + Any category contains fewer than three non-functional requirements.

> **Grading rubrics are applied consistently to ensure fairness for all students. Every student's work is evaluated 
according to the same criteria outlined in the rubrics. This approach helps maintain objectivity and transparency 
in the grading process.**

---

# <a id="head7"></a> Submission Guidelines

Please carefully follow these submission guidelines for this milestone: 
 
   * ***PDF Submission:*** Upload a PDF file named m1.pdf into this directory with your work for Milestone 1. 
     Only PDF files will be considered for grading. Submissions in any other format will not be graded. 

   * ***On Canvas:*** Use the assignment submission link to provide a URL that links directly to the Milestone 1 folder 
     in your repository.

> **These submission guidelines are essential to ensure fair and consistent grading for everyone. It is crucial that 
your submission strictly follows these instructions. Failure to comply with these guidelines may result in a significant
deduction of points.** 
   
---

🎉 Congrats on completing the first milestone! You're officially 20% closer to database greatness! 🚀🎓 Keep up the awesome work! 💪

   
