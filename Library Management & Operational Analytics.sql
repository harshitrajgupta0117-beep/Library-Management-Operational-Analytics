--1) How many books do we have in each category?

select category,
	count(*) as total_books 
from books
group  by
	category
order by
	total_books desc;


--2) What is the total salary paid to employees at each branch?

SELECT 
	B.branch_id,
	B.branch_address,
	SUM(E.salary) AS TOTAL_SALARY 
FROM 
	employee AS E
JOIN 
	branch AS B ON E.branch_id = B.branch_id  
GROUP BY  
	B.branch_id,B.branch_address
ORDER BY
	TOTAL_SALARY DESC;


--3) List all members who registered in the last 12 months (This shows growth).
SELECT 
    member_id, 
    member_name, 
    reg_date
FROM 
    members
WHERE 
    reg_date >= CURRENT_DATE - INTERVAL '12 months';


--4) Create a report showing the Branch_ID, Manager_Name ,and the Branch_Address. ).

SELECT 
    B.branch_id, 
    B.branch_address, 
    E.emp_name AS manager_name  -- Selecting the Name, not just the ID
FROM 
    branch AS B
JOIN 
    employee AS E ON B.manager_id = E.emp_id; -- Matching the Manager to their Employee record


--5)Rental Revenue: Calculate the total potential revenue if every book currently "available"  was rented out once.
SELECT 
	SUM(rental_price) as Total_potential_revenue
FROM 
	books
where 
	status = 'yes';
	
--6)Position Density: Which job positions are the most common in the library system, and what is the average salary for each?
SELECT
	position,
	ROUND(AVG(salary),2) as AVERAGE_SALARY,
	COUNT(emp_id) as employee_count
FROM 
	employee
GROUP  BY position;



--7) Identify books that have been out for more than 30 days. List the member's name and the book title.

select 
	I.issued_book_name AS ISSUED_BOOK,
	M.member_name AS MEMBER_NAME,
	I.issued_date as issue_date_of_book
FROM 
	issue_status AS I
JOIN
	members AS M ON I.issued_member_id = M.member_id
WHERE 
	issued_date >= CURRENT_DATE - INTERVAL '30 DAYS'
ORDER  BY
	I.issued_date DESC;

--8)Which employee has issued the highest number of books? (Shows who is the most productive staff member).

SELECT 
	E.emp_name as NAME,
	E.emp_id,
	COUNT(I.issued_id) AS NO_OF_ISSUE
FROM 
	issue_status AS I 
JOIN 
	employee AS E 
ON 
	E.emp_id = I.issued_emp_id
GROUP BY 
	E.emp_id,E.emp_name
ORDER BY 
	NO_OF_ISSUE DESC
LIMIT 1;


--9) Which branch has the highest turnover of books (most rentals)?

select 
	E.branch_id,
	B.branch_address,
	count(I.issued_id) as total_rentals
FROM
	issue_status AS I
JOIN employee AS E
 	ON I.issued_emp_id = E.emp_id
JOIN branch AS B
	ON B.branch_id =  E.branch_id
GROUP BY 
	E.branch_id,B.branch_address
ORDER BY 
	total_rentals DESC
LIMIT 1;


--10) Show the number of new member registrations month-over-month. Is our membership base growing?

SELECT 
    TO_CHAR(reg_date, 'YYYY-MM') AS reg_month,
    COUNT(member_id) AS new_members
FROM 
    members
GROUP BY 
    reg_month
ORDER BY 
    reg_month ASC;	


--11)Find the names of members who have rented a 'Classic' category book more than once.
SELECT 
	M.member_id,
	M.member_name AS NAME,
	B.category,
	COUNT(I.issued_id) AS NO_OF_ORDERS
FROM 
 	members as M
JOIN 
	issue_status as I
ON 
	I.issued_member_id = M.member_id
JOIN 
	books as B
ON 
	B.isbn = I.issued_book_isbn
GROUP BY category,member_id
HAVING category = 'Classic' 
AND COUNT(I.issued_id) > 1;





