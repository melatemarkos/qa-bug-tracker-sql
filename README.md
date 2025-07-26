# 🛠️ QA Automation & Bug Tracking SQL Database 🐞

This project is a relational SQL database schema designed to support a **Quality Assurance (QA) automation and bug tracking system**. It models core entities such as users, projects, test cases, and bugs to streamline **test execution, issue tracking**, and **reporting workflows**.


## 🧱 Schema Overview

### Tables

- **users** 👥  
  Stores information about QA engineers and developers.  
  **Columns:** `user_id`, `name`, `role`, `email`

- **projects** 📁  
  Contains details about software projects under test.  
  **Columns:** `project_id`, `name`, `start_date`

- **test_case** ✅  
  Represents test cases linked to projects, including execution results.  
  **Columns:** `test_id`, `project_id`, `title`, `expected_result`, `executed_by`, `pass_fail`

- **bugs** 🐛  
  Captures bug reports, their status, priority, and reporter info.  
  **Columns:** `bug_id`, `title`, `description`, `status`, `priority`, `reported_by`, `date_reported`, `user_id`, `project_id`


## 📊 Sample Data

The database is seeded with realistic QA scenario data:

- 👨‍💻 10+ users with QA and dev roles
- 🧩 11 projects including Login Module, E-commerce Platform, Mobile App Revamp, etc.
- 🧪 Test cases per project, including edge cases (e.g. no assigned user/project)
- 🐞 Multiple bugs, with different priority levels and linked to users/projects


## 🔍 Views & Insights

### ✅ Custom Views Created:

- `v_projects_without_testcases` – Projects with **no test cases** (coverage gaps)
- `v_high_priority_open_bugs` – All **high-priority, unresolved bugs**
- `v_failed_test_cases` – All **test cases that failed**
- `v_invalid_testcase_links` – Test cases with **missing user or project association**

You can find them in the [`views_and_queries.sql`](your_file_link_here) file.

## 🧰 Tech Stack

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)
![pgAdmin](https://img.shields.io/badge/pgAdmin-00599C?style=for-the-badge&logo=postgresql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-FFCA28?style=for-the-badge&logo=sqlite&logoColor=black)
![Git](https://img.shields.io/badge/Git-E44C30?style=for-the-badge&logo=git&logoColor=white)


## 📈 Example Queries

### 🔎 Get all test cases for a project with status and executor:

```sql
SELECT tc.test_id, tc.title, u.name AS executed_by, tc.pass_fail
FROM test_case tc
JOIN users u ON tc.executed_by = u.user_id
WHERE tc.project_id = 1;
