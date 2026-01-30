# Library-Management-Operational-Analytics
Objective: To monitor library growth, employee productivity, and inventory profitability using a relational database schema.

**Business Problems Solved**

Inventory Management: Identified which book categories dominate the collection and which are underrepresented.

Financial Overhead: Calculated branch-level salary expenses to monitor operational costs.

Growth Tracking: Analyzed member registration trends to identify periods of stagnation (e.g., the 2023 growth gap).

Employee Performance: Spotted top-performing staff based on transaction volume (book issuances)

**Database Schema**

--CREATE TABLE Books

DROP TABLE IF EXISTS books;
CREATE TABLE books
(
	isbn varchar(50) primary key,
	book_title varchar(50),
	category varchar(100),
	rental_price numeric(10,2),
	status varchar(50),
	author varchar(100),
	publisher varchar (100)
	)

--CREATE TABLE  Branch
DROP TABLE IF EXISTS branch;
CREATE TABLE branch
(
	branch_id varchar(20) PRIMARY KEY,
	manager_id varchar(50),
	branch_address varchar(40),
	contact_no varchar(20)
	)

--CREATE TABLE EMPLOYEE
DROP TABLE  IF EXISTS employee;
CREATE  TABLE employee
(
	emp_id varchar(50) primary key,
	emp_name varchar(25),
	position varchar(20),
	salary numeric(10),
	branch_id varchar(25) --FK
	);

--CREATE  TABLE ISSUED_STATUS
DROP TABLE  IF EXISTS issued_status;
CREATE TABLE  issue_status
(
	issued_id varchar(20) primary key,
	issued_member_id varchar(15), --FK
	issued_book_name varchar(100),
	issued_date date,
	issued_book_isbn varchar(30), --FK
	issued_emp_id varchar(15) --FK
	);

--CREATE TABLE MEMEBERS;
DROP TABLE  IF EXISTS memebers;
CREATE TABLE members
(
	member_id varchar(10) PRIMARY KEY,
	member_name varchar(20),
	member_address varchar(30),
	reg_date date
	);

--CREATE TABLE RETURN_STATUS
DROP TABLE IF EXISTS return_status;
CREATE TABLE return_status
(
	return_id varchar(15) PRIMARY KEY,
	issued_id varchar(20),
	return_book_name varchar(10),
	return_date date,
	return_book_isbn varchar(50)
	);

--FOREIGN KEY
	ALTER TABLE issue_status
	ADD CONSTRAINT fk_members
	FOREIGN KEY  (issued_member_id)
	REFERENCES members(member_id);


ALTER TABLE issue_status
	ADD CONSTRAINT fk_books
	FOREIGN KEY  (issued_book_isbn)
	REFERENCES books(isbn);


ALTER TABLE issue_status
	ADD CONSTRAINT fk_employee
	FOREIGN KEY  (issued_emp_id)
	REFERENCES employee(emp_id);

ALTER TABLE employee
	ADD CONSTRAINT fk_branch
	FOREIGN KEY  (branch_id)
	REFERENCES branch(branch_id);

ALTER TABLE return_status
	ADD CONSTRAINT fk_issued_status
	FOREIGN KEY  (issued_id)
	REFERENCES issue_status(issued_id);

  Key Technical Skills Demonstrated
Multi-Table Joins: Connecting members, issued_status, and books to track user behavior.

Aggregations: Using SUM, COUNT, and AVG with GROUP BY and HAVING filters.

Date Manipulation: Using INTERVAL and TO_CHAR for time-series growth analysis.

Data Cleaning: Handling formatting and rounding for professional financial reporting.

Top Insights Discovered
The Growth Gap: Member registrations halted completely in 2023. Recommendation: Launch a marketing campaign targeting lapsed members.

Revenue Concentration: 60% of potential revenue is tied to 'Classic' and 'History' categories.

High-Cost Branches: Branch B001 has the highest salary overhead, requiring a review of staff-to-member ratios
