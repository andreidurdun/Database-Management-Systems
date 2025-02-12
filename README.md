# Design and Implementation of a Relational Database for a Travel Agency


## Project Description
The goal of this project is to design and implement a relational database system tailored for a travel agency, utilizing Oracle Database. The database is structured to efficiently manage various aspects of the agency's operations, including customer reservations, travel packages, accommodations, payments, and employee management. By leveraging advanced database management techniques, this system ensures seamless integration of data, facilitating smooth business processes and enhancing customer satisfaction.

The project follows a structured approach, beginning with the creation of an Entity-Relationship Diagram (ERD) that defines the fundamental entities and their relationships. A conceptual model is then developed based on the ERD, incorporating all necessary attributes to ensure data consistency and integrity. The implementation phase involves defining tables with appropriate constraints, populating them with meaningful data, and developing complex functionalities through stored procedures, functions, and triggers.

## Technologies Used

- **Database:** Oracle Database 21c
- **Development Tools:** SQL Developer, ERD Tools (Draw.io)

## Implementation in Oracle
The database implementation includes the definition of tables with primary and foreign key constraints to maintain data integrity. Each independent entity is populated with at least ten records. The implementation phase ensures the system is ready for real-world operations by integrating efficient data storage and retrieval mechanisms.

## Advanced Functionalities
To enhance the database's capabilities, various advanced functionalities are implemented:
- **Stored Procedures and Functions:**
  - A collection-based stored subprogram that processes data using all three types of collections.
  - A cursor-based stored subprogram utilizing two different types of cursors, with one parameterized cursor dependent on another.
  - A stored function integrating three tables into a single SQL command, with exception handling.
  - A stored procedure that processes five tables in a single SQL command while handling custom-defined exceptions.

- **Triggers:**
  - A command-level LMD trigger to automate business rules.
  - A row-level LMD trigger ensuring data consistency at an individual row level.
  - An LDD trigger that monitors and logs structural changes to the database.

## Package Development
To further enhance system efficiency and modularity, a package is developed that includes:
- At least two complex data types
- At least two functions
- At least two procedures

## Conclusion
This project aims to provide a comprehensive database solution for a travel agency, automating reservation management, payment processing, and customer interactions. The implemented system will improve operational efficiency, ensure data consistency, and enhance overall service quality, ultimately contributing to a better experience for both customers and agency staff.
