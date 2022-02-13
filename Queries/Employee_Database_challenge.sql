-- Deliverable 1: The Number of Retiring Employees by Title
SELECT 	e.emp_no,
		e.first_name, 
		e.last_name,
		t.title, 
		t.from_date, 
		t.to_date

INTO retirement_titles
FROM employees as e
	LEFT JOIN title as t
		ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Unique titles
SELECT DISTINCT ON (e.emp_no) e.emp_no,
					e.first_name, 
					e.last_name,
					t.title, 
					t.from_date, 
					t.to_date
-- INTO unique_titles
FROM employees as e
	LEFT JOIN title as t
		ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
 AND  (t.to_date = '9999-01-01')
ORDER BY e.emp_no ASC, t.to_date DESC;


-- number of employees by their most recent job title who are about to retire.
SELECT COUNT(ut.emp_no)		as number_of_emp, 
			 ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.emp_no) DESC;

-- Deliverable 2: The Employees Eligible for the Mentorship Program
SELECT 	DISTINCT ON (e.emp_no) e.emp_no,
		e.first_name, 
		e.last_name,
		e.birth_date,
		de.from_date, 
		de.to_date,
		t.title
INTO mentorship_eligibilty
FROM employees as e
	LEFT JOIN dept_emp as de
		ON (e.emp_no = de.emp_no)
	LEFT JOIN title as t
		ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
 AND  (t.to_date = '9999-01-01')
ORDER BY e.emp_no;

-- Find percentage per title - retiring table
SELECT  title, 
		number_of_emp  / (SELECT SUM(number_of_emp) FROM retiring_titles) * 100 	as Percentage 
		
FROM retiring_titles
GROUP BY title, number_of_emp
ORDER BY number_of_emp  / (SELECT SUM(number_of_emp) FROM retiring_titles) * 100
;

