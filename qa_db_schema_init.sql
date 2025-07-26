-- ============================================
-- PURPOSE: Initial schema, sample data, and setup for QA tracking database
-- AUTHOR: Melate Markos
-- CREATED: 07/22/2025
-- DESCRIPTION:
--   Defines tables, inserts seed data, and adds test coverage to simulate a QA tracking and automation environment.
-- ============================================

-- ========== TABLE CREATION ========== --

CREATE TABLE bugs (
  bug_id SERIAL PRIMARY KEY,
  title VARCHAR(225),
  description TEXT,
  status VARCHAR(50),
  priority VARCHAR(50),
  reported_by VARCHAR(100),
  date_reported DATE,
  user_id INTEGER REFERENCES users(user_id)
);

CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  role VARCHAR(50),
  email VARCHAR(50)
);

CREATE TABLE projects (
  project_id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  start_date DATE
);

CREATE TABLE test_case (
  test_id SERIAL PRIMARY KEY,
  project_id INTEGER REFERENCES projects(project_id),
  title VARCHAR(225),
  expected_result TEXT,
  executed_by INTEGER REFERENCES users(user_id),
  pass_fail BOOLEAN
);

-- ========== SAMPLE DATA: USERS & PROJECTS ========== --

INSERT INTO users (name, role, email) VALUES
  ('Melate Markos', 'QA Engineer', 'mmarkos@example.com'),
  ('John Dev', 'Developer', 'jdev@example.com'),
  ('Sophia Lee', 'QA Analyst', 'sophia.lee@example.com'),
  ('David Kim', 'Frontend Developer', 'david.kim@example.com'),
  ('Aisha Patel', 'Backend Developer', 'aisha.patel@example.com'),
  ('Carlos Ramirez', 'QA Lead', 'carlos.ramirez@example.com'),
  ('Emily Nguyen', 'Project Manager', 'emily.nguyen@example.com'),
  ('James Wilson', 'Software Developer', 'james.wilson@example.com'),
  ('Nina Brown', 'QA Engineer', 'nina.brown@example.com'),
  ('Liam Johnson', 'DevOps Engineer', 'liam.johnson@example.com');

INSERT INTO projects (name, start_date) VALUES
  ('Login Module', '2024-01-02'),
  ('User Authentication Module', '2024-01-15'),
  ('E-commerce Platform', '2024-02-10'),
  ('Mobile App Revamp', '2024-03-05'),
  ('Payment Gateway Integration', '2024-04-01'),
  ('Customer Support Portal', '2024-04-20'),
  ('Inventory Management System', '2024-05-10'),
  ('Website Redesign', '2024-06-01'),
  ('Reporting Dashboard', '2024-06-15'),
  ('API Development', '2024-07-01'),
  ('Security Enhancements', '2024-07-20');

-- ========== SAMPLE DATA: TEST CASES ========== --

-- Example test cases for each project (valid entries)
INSERT INTO test_case (project_id, title, expected_result, executed_by, pass_fail) VALUES
  (1, 'Verify login with valid credentials', 'User redirected to dashboard', 3, TRUE),
  (1, 'Verify login with invalid password', 'Error message displayed', 4, TRUE),
  (1, 'Verify "Forgot Password" link works', 'Reset password email sent', 5, FALSE),
  (2, 'Verify token expiration', 'User must re-login after token expiry', 6, TRUE),
  (2, 'Verify account lockout after failed attempts', 'Account locked after 5 failed attempts', 7, TRUE),
  (2, 'Verify multi-factor authentication prompt', 'MFA required on login', 8, FALSE),
  (3, 'Verify product search returns results', 'Relevant products displayed', 9, TRUE),
  (3, 'Verify adding item to cart', 'Item appears in cart', 10, TRUE),
  (3, 'Verify checkout process completes successfully', 'Order confirmation page shown', 11, FALSE),
  (4, 'Verify app launch on iOS devices', 'App launches without crash', 12, TRUE),
  (4, 'Verify push notifications received', 'Notifications received timely', 3, TRUE),
  (4, 'Verify UI layout on various screen sizes', 'UI adjusts correctly', 4, TRUE),
  (5, 'Verify successful payment transaction', 'Payment processed and receipt generated', 5, TRUE),
  (5, 'Verify failed payment handling', 'Error message displayed for failed payment', 6, FALSE),
  (5, 'Verify refund process', 'Refund amount credited to user', 7, TRUE),
  (6, 'Verify ticket creation', 'New ticket saved and listed', 8, TRUE),
  (6, 'Verify ticket status update', 'Ticket status changes correctly', 9, TRUE),
  (6, 'Verify search tickets by keyword', 'Relevant tickets returned', 10, TRUE),
  (7, 'Verify adding new inventory item', 'Item appears in inventory list', 11, TRUE),
  (7, 'Verify stock level updates', 'Stock changes reflected after sales', 12, FALSE),
  (7, 'Verify low stock alerts', 'Alerts sent when stock below threshold', 3, TRUE),
  (8, 'Verify homepage loads', 'Homepage displays with new design', 4, TRUE),
  (8, 'Verify navigation menu links', 'All links direct to correct pages', 5, TRUE),
  (8, 'Verify contact form submission', 'Confirmation message shown', 6, TRUE),
  (9, 'Verify report generation', 'Report generated with correct data', 7, TRUE),
  (9, 'Verify filtering options', 'Reports filtered as per selection', 8, FALSE),
  (9, 'Verify export to PDF functionality', 'Report exported successfully', 9, TRUE),
  (10, 'Verify GET endpoint returns data', '200 OK with correct data', 10, TRUE),
  (10, 'Verify POST endpoint creates resource', 'Resource created with 201 status', 11, TRUE),
  (10, 'Verify DELETE endpoint removes resource', 'Resource deleted and 204 returned', 12, FALSE),
  (11, 'Verify password complexity enforcement', 'Weak passwords rejected', 3, TRUE),
  (11, 'Verify session timeout after inactivity', 'User logged out after timeout', 4, TRUE),
  (11, 'Verify encryption of sensitive data', 'Data stored encrypted in DB', 5, TRUE);

-- Edge cases: Missing user/project
INSERT INTO test_case (project_id, title, expected_result, executed_by, pass_fail) VALUES
  (2, 'Verify logout functionality logs user out', 'User is redirected to login page', NULL, TRUE),
  (NULL, 'Verify search bar returns results', 'Results are shown below the search field', 5, TRUE),
  (NULL, 'Verify system behavior on empty input', 'Form should show validation message', NULL, FALSE),
  (7, 'Verify UI loads correctly on slow networks', 'Page should render skeleton loader', NULL, TRUE);

-- ========== SAMPLE DATA: BUGS ========== --

INSERT INTO bugs (title, description, status, priority, reported_by, date_reported, user_id) VALUES
  ('Login page crash', 'App crashes when logging in with special characters', 'Open', 'High', 'Melate Markos', CURRENT_DATE, 3),
  ('Incorrect total price', 'Shopping cart total does not update after item removal', 'Open', 'Medium', 'John DevOps', CURRENT_DATE, 4),
  ('Mobile app notification delay', 'Push notifications arrive 10 minutes late', 'In Progress', 'Medium', 'QA Tester', CURRENT_DATE, 5),
  ('Payment gateway timeout', 'Transactions fail after 30 seconds timeout', 'Open', 'High', 'QA Analyst', CURRENT_DATE, 6),
  ('Support ticket duplication', 'Duplicate tickets created on form resubmission', 'Resolved', 'Low', 'QA Engineer', CURRENT_DATE, 7),
  ('Inventory stock not updated', 'Stock levels not reflecting after sales', 'In Progress', 'High', 'QA Specialist', CURRENT_DATE, 8),
  ('Homepage image broken link', 'Main banner image fails to load on homepage', 'Open', 'Low', 'QA Tester', CURRENT_DATE, 9),
  ('Dashboard report miscalculation', 'Monthly report totals do not add up correctly', 'Open', 'High', 'QA Analyst', CURRENT_DATE, 10),
  ('API POST returns 500 error', 'Server error when creating new resources via API', 'Open', 'Critical', 'Software Developer', CURRENT_DATE, 11),
  ('Weak password accepted', 'Password validation allows weak passwords', 'In Progress', 'High', 'QA Engineer', CURRENT_DATE, 12);

-- ========== VALIDATION ========== --

SELECT * FROM users;
SELECT * FROM projects;
SELECT * FROM test_case;
SELECT * FROM bugs;

-- View all table names
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public';
