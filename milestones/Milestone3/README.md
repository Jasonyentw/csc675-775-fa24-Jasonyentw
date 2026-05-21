# Milestone 3: Database Architecture and Modeling (10 points)

In this milestone, students will build the database architecture and create a database model of their tables based on 
the ERD and entity descriptions from Milestone 2.

## Milestone 3: Table of Contents

1. [Section VIII: Enhanced Entity-Relationship (EER) Diagram ](#head1)
2. [Section IX: Normalization Techniques Used](#head2)
3. [Grading Rubrics](#head3)
4. [Submission Guidelines](#head4)

### Important Notes
   - Your final version of this milestone must include your work in M1, M2 and M3.
   - Update your history table with M2. Sort the table in descending order, the newest milestone first.
   - Sections VI and VII may be implemented concurrently.


## <a id="head1"></a> Section VIII: Enhanced Entity-Relationship (EER) Diagram  (EER) (9 points)

**Note: This section must be completed using MySQLWorkbench.**

Create an Enhanced Entity-Relationship (EER) Diagram of your database system based on the final version of your 
ERD and entity descriptions. Your EER must clearly display the following components:

  + Primary Keys (PK), Foreign Keys (FK), and Unique Keys (if any)
  + All table attributes and their data types
  + NOT NULL constraints on attributes (if any)
  + Identifying and non-identifying relationships, represented by solid and dashed lines, respectively
  + All relationships between entities and their cardinalities, including those with zero occurrences
  + Apply all the normalization techniques learned in class if applicable.

Once the EER is completed, please do the following:
  + Save your database model as `eer.mwb` and upload this file to the "files" folder in this directory.  
  + Export your EER to any of the following formats (PDF, PNG, JPG, etc.) and embed it in Section VIII of the PDF file. 
  Screenshots of your EER are also acceptable, as long as the image is clear and of high quality.
  + If your EER is too large to fit on one page, try designing it in landscape mode. 

**Important: If your EER is not readable, no credit will be given for this section.**

The following is an example of an EER based on the ERD provided as an example in Milestone 2.

<img src="../res/example_eer.png" alt="ERD"/>

--- 

## <a id="head2"></a> Section IX: Normalization Techniques Used (1 point)

Normalization in databases is the process of organizing the structure of a relational database in such a way that 
reduces redundancy and dependency, improves data integrity, and optimizes query performance. The goal of normalization 
is to break down a database into smaller, related tables and define relationships between them to minimize duplication
of data and to ensure data consistency.

Explain in detail which normalization techniques and levels of normalization you applied while creating your
EER. Describe how these techniques helped organize your data, reduce redundancy, and ensure data integrity 
in your database design.

> **Note: Section IX is the final section of the technical documentation (PDF file) for your database.**

--- 

# <a id="head3"></a> Grading Rubrics

The following grading rubrics will be used by the TA and the instructor to evaluate the work submitted by students in this milestone:

1. **Completion of Sections**
   - All sections of this milestone must be fully completed. Incomplete work or assignments that do not strictly follow the submission guidelines will receive a non-passing grade for this milestone. No exceptions.

2. **AI Detection**
   - Work flagged by our AI detection tools will receive a temporary grade of zero until the issue is resolved. If compelling evidence indicates that the work was created by AI tools like ChatGPT, we will follow university policies regarding academic dishonesty.

3. **Final Grades**
   - Once a grade is assigned to a milestone, it will not be changed unless the TA or instructor made an error during the grading process. Please refer to the syllabus for details on grade appeals.

4. **Late Submissions**
   - Late submissions will incur penalties. A 10% deduction will be applied for each day the assignment is overdue, up to a maximum of three days. After three days, the assignment will be considered as not submitted and will be graded as such.

### Detailed Section Grading

Our TAs will use the following rubrics to grade your milestone:

#### Section VIII (9 points)
+ (-9 points) are deducted if:
    + No work is provided, or the work submitted is of clearly poor quality.
    + What you submitted is not an EER (e.g., a UML diagram or another type of diagram).
    + Your EER is based on an ERD other than the one you created in Milestone 2.
+ (-0.5 points) are deducted for every entity set from your ERD (including associative entity sets) that was 
  not implemented in your EER
+ (-0.2 points) are deducted for any error found in the implementation of your EER. For example, a missing cardinality or 
  an entity implemented with the wrong type (strong or weak)

#### Section IX (1 point)

+ (-1 point) is deducted if no work is provided, or the work submitted is of clearly poor quality.
+ (-0.5 points) are deducted if the student has completed the work in this section, but the normalization 
  techniques explained do not match the implementation used in their EER.

> **Grading rubrics are applied consistently to ensure fairness for all students. Every student's work is evaluated
according to the same criteria outlined in the rubrics. This approach helps maintain objectivity 
and transparency in the grading process.**

---

# <a id="head4"></a> Submission Guidelines

Please carefully follow these submission guidelines for this milestone: 
 
   * ***PDF Submission:*** Upload a PDF file named `m3.pdf` into this directory containing your work for Milestone 3. 
     This file should also include your previous work from Milestones 1 and 2, as our technical documentation builds  
     incrementally from one milestone to the next. Only PDF files will be considered for grading. Submissions in any 
     other format will not be graded. 
   * ***Files Directory:*** Upload your `eer.mwb` file into this directory. Please note that if your file is not found 
     in this directory at the time of grading, it will be considered as not submitted, even if it was mistakenly 
     placed in a different directory.
   * ***On Canvas:*** Use the assignment submission link to provide a URL that links directly to the Milestone 3 folder 
     in your repository.

> ***These submission guidelines are essential to ensure fair and consistent grading for everyone. It is crucial that 
your submission strictly follows these instructions. Failure to comply with these guidelines may result in a significant
deduction of points.*** 

--- 

Way to go on crushing the EER and Normalization milestone — your database skills are off the charts! 🌟🚀













