/*
Created By: Melate Markos
Create Date: 07/26/2025
Description: Creat views from 

*/

-- [View 1] Find projects with no test cases (Coverage Check)
SELECT
	p.project_id,
	p.name
FROM 
	test_case AS tc
	LEFT JOIN projects AS p
	ON p.project_id = tc.project_id
WHERE
	tc.test_id IS NULL

-- [View 2] Check for high-priority bugs
SELECT *
FROM 
	bugs AS b
WHERE
	b.priority = 'High' AND b.status = 'Open';


-- [View 3] Check for any failed test cases
SELECT *
FROM 
	test_case AS tc
WHERE 
	tc.pass_fail = FALSE;


-- [View 4] Verify each test case is linked to a real user and project
SELECT 
	tc.test_id,
	tc.title,
	u.name,
	p.name
FROM
	test_case AS tc
	LEFT JOIN users AS u 
	ON tc.executed_by = u.user_id
	LEFT JOIN projects AS p
	ON tc.project_id = p.project_id
WHERE
	u.user_id IS NULL OR p.project_id IS NULL

	