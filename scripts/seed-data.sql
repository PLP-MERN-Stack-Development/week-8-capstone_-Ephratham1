-- Seed Data for TaskFlow Application
-- Sample data to populate the database

-- Insert sample users
INSERT INTO users (_id, name, email, password, role, created_at) VALUES
(ObjectId(), 'John Doe', 'john@taskflow.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj/VcSAg/9qm', 'admin', NOW()),
(ObjectId(), 'Jane Smith', 'jane@taskflow.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj/VcSAg/9qm', 'manager', NOW()),
(ObjectId(), 'Mike Johnson', 'mike@taskflow.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj/VcSAg/9qm', 'member', NOW()),
(ObjectId(), 'Sarah Wilson', 'sarah@taskflow.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj/VcSAg/9qm', 'member', NOW()),
(ObjectId(), 'Demo User', 'demo@taskflow.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj/VcSAg/9qm', 'member', NOW());

-- Insert sample projects
INSERT INTO projects (_id, name, description, status, priority, start_date, due_date, progress, owner_id, team_members, created_at) VALUES
(ObjectId(), 'Website Redesign', 'Complete overhaul of company website with modern design and improved UX', 'in_progress', 'high', '2024-01-01', '2024-02-15', 75, (SELECT _id FROM users WHERE email = 'john@taskflow.com'), [(SELECT _id FROM users WHERE email = 'jane@taskflow.com'), (SELECT _id FROM users WHERE email = 'mike@taskflow.com')], NOW()),
(ObjectId(), 'Mobile App Development', 'Native iOS and Android app for customer engagement and service delivery', 'in_progress', 'medium', '2024-01-15', '2024-03-01', 45, (SELECT _id FROM users WHERE email = 'jane@taskflow.com'), [(SELECT _id FROM users WHERE email = 'sarah@taskflow.com'), (SELECT _id FROM users WHERE email = 'demo@taskflow.com')], NOW()),
(ObjectId(), 'Marketing Campaign Q1', 'Digital marketing campaign across all channels for Q1 product launch', 'review', 'high', '2024-01-01', '2024-01-30', 90, (SELECT _id FROM users WHERE email = 'sarah@taskflow.com'), [(SELECT _id FROM users WHERE email = 'mike@taskflow.com')], NOW()),
(ObjectId(), 'Database Migration', 'Migrate legacy database to cloud infrastructure with improved performance', 'completed', 'medium', '2023-12-01', '2024-01-15', 100, (SELECT _id FROM users WHERE email = 'mike@taskflow.com'), [(SELECT _id FROM users WHERE email = 'john@taskflow.com')], NOW());

-- Insert sample tasks
INSERT INTO tasks (_id, title, description, status, priority, project_id, assigned_to, created_by, due_date, estimated_hours, created_at) VALUES
(ObjectId(), 'Design Homepage Mockup', 'Create wireframes and high-fidelity mockups for the new homepage design', 'completed', 'high', (SELECT _id FROM projects WHERE name = 'Website Redesign'), (SELECT _id FROM users WHERE email = 'jane@taskflow.com'), (SELECT _id FROM users WHERE email = 'john@taskflow.com'), '2024-01-20', 16, NOW()),
(ObjectId(), 'Implement Responsive Navigation', 'Code the responsive navigation menu with mobile-first approach', 'in_progress', 'high', (SELECT _id FROM projects WHERE name = 'Website Redesign'), (SELECT _id FROM users WHERE email = 'mike@taskflow.com'), (SELECT _id FROM users WHERE email = 'john@taskflow.com'), '2024-02-05', 12, NOW()),
(ObjectId(), 'User Authentication System', 'Implement secure login and registration functionality', 'to
'User Authentication System',
'Implement secure login and registration functionality',
'todo',
'medium',
(SELECT _id FROM projects WHERE name = 'Mobile App Development'),
(SELECT _id FROM users WHERE email = 'sarah@taskflow.com'),
(SELECT _id FROM users WHERE email = 'jane@taskflow.com'),
'2024-02-20',
20,
NOW()),
(ObjectId(),
'API Integration',
'Connect mobile app with backend REST API endpoints',
'todo',
'high',
(SELECT _id FROM projects WHERE name = 'Mobile App Development'),
(SELECT _id FROM users WHERE email = 'demo@taskflow.com'),
(SELECT _id FROM users WHERE email = 'jane@taskflow.com'),
'2024-02-25',
24,
NOW()),
(ObjectId(),
'Social Media Content Creation',
'Develop engaging content for Instagram, Twitter, and LinkedIn',
'completed',
'medium',
(SELECT _id FROM projects WHERE name = 'Marketing Campaign Q1'),
(SELECT _id FROM users WHERE email = 'mike@taskflow.com'),
(SELECT _id FROM users WHERE email = 'sarah@taskflow.com'),
'2024-01-25',
8,
NOW()),
(ObjectId(),
'Performance Testing',
'Conduct load testing and optimize database queries',
'completed',
'high',
(SELECT _id FROM projects WHERE name = 'Database Migration'),
(SELECT _id FROM users WHERE email = 'john@taskflow.com'),
(SELECT _id FROM users WHERE email = 'mike@taskflow.com'),
'2024-01-10',
16,
NOW());

-- Insert sample comments
INSERT INTO comments (_id, content, author_id, task_id, created_at) VALUES
(ObjectId(),
'Great work on the homepage design! The new layout looks much more modern.',
(SELECT _id FROM users WHERE email = 'john@taskflow.com'),
(SELECT _id FROM tasks WHERE title = 'Design Homepage Mockup'),
NOW()),
(ObjectId(),
'I think we should add more padding to the navigation items for better mobile experience.',
(SELECT _id FROM users WHERE email = 'sarah@taskflow.com'),
(SELECT _id FROM tasks WHERE title = 'Implement Responsive Navigation'),
NOW()),
(ObjectId(),
'The authentication flow is working well in testing. Ready for code review.',
(SELECT _id FROM users WHERE email = 'sarah@taskflow.com'),
(SELECT _id FROM tasks WHERE title = 'User Authentication System'),
NOW());

-- Insert sample time entries
INSERT INTO time_entries (_id, user_id, task_id, project_id, description, start_time, end_time, duration, created_at) VALUES
(ObjectId(),
(SELECT _id FROM users WHERE email = 'jane@taskflow.com'),
(SELECT _id FROM tasks WHERE title = 'Design Homepage Mockup'),
(SELECT _id FROM projects WHERE name = 'Website Redesign'),
'Working on wireframes and user flow',
'2024-01-18 09:00:00',
'2024-01-18 13:00:00',
240,
NOW()),
(ObjectId(),
(SELECT _id FROM users WHERE email = 'mike@taskflow.com'),
(SELECT _id FROM tasks WHERE title = 'Implement Responsive Navigation'),
(SELECT _id FROM projects WHERE name = 'Website Redesign'),
'Coding mobile navigation menu',
'2024-01-22 10:00:00',
'2024-01-22 15:30:00',
330,
NOW());

-- Insert sample notifications
INSERT INTO notifications (_id, recipient_id, sender_id, type, title, message, related_id, created_at) VALUES
(ObjectId(),
(SELECT _id FROM users WHERE email = 'mike@taskflow.com'),
(SELECT _id FROM users WHERE email = 'john@taskflow.com'),
'task_assigned',
'New Task Assigned',
'You have been assigned to work on "Implement Responsive Navigation"',
(SELECT _id FROM tasks WHERE title = 'Implement Responsive Navigation'),
NOW()),
(ObjectId(),
(SELECT _id FROM users WHERE email = 'john@taskflow.com'),
(SELECT _id FROM users WHERE email = 'jane@taskflow.com'),
'task_completed',
'Task Completed',
'Jane Smith has completed "Design Homepage Mockup"',
(SELECT _id FROM tasks WHERE title = 'Design Homepage Mockup'),
NOW());
