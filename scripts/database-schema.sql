-- TaskFlow Database Schema
-- MongoDB Collections Structure (represented as SQL for documentation)

-- Users Collection
CREATE TABLE users (
  _id ObjectId PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  avatar_url VARCHAR(500),
  role ENUM('admin', 'manager', 'member') DEFAULT 'member',
  is_active BOOLEAN DEFAULT true,
  last_login TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Projects Collection
CREATE TABLE projects (
  _id ObjectId PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  status ENUM('planning', 'in_progress', 'review', 'completed', 'cancelled') DEFAULT 'planning',
  priority ENUM('low', 'medium', 'high', 'urgent') DEFAULT 'medium',
  start_date DATE,
  due_date DATE,
  progress INTEGER DEFAULT 0,
  owner_id ObjectId REFERENCES users(_id),
  team_members ARRAY[ObjectId] REFERENCES users(_id),
  tags ARRAY[VARCHAR(50)],
  budget DECIMAL(10,2),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tasks Collection
CREATE TABLE tasks (
  _id ObjectId PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  status ENUM('todo', 'in_progress', 'review', 'completed', 'cancelled') DEFAULT 'todo',
  priority ENUM('low', 'medium', 'high', 'urgent') DEFAULT 'medium',
  project_id ObjectId REFERENCES projects(_id),
  assigned_to ObjectId REFERENCES users(_id),
  created_by ObjectId REFERENCES users(_id),
  due_date TIMESTAMP,
  estimated_hours INTEGER,
  actual_hours INTEGER,
  tags ARRAY[VARCHAR(50)],
  dependencies ARRAY[ObjectId] REFERENCES tasks(_id),
  attachments ARRAY[{
    filename VARCHAR(255),
    url VARCHAR(500),
    size INTEGER,
    type VARCHAR(100)
  }],
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Comments Collection
CREATE TABLE comments (
  _id ObjectId PRIMARY KEY,
  content TEXT NOT NULL,
  author_id ObjectId REFERENCES users(_id),
  task_id ObjectId REFERENCES tasks(_id),
  project_id ObjectId REFERENCES projects(_id),
  parent_comment_id ObjectId REFERENCES comments(_id),
  mentions ARRAY[ObjectId] REFERENCES users(_id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Time Tracking Collection
CREATE TABLE time_entries (
  _id ObjectId PRIMARY KEY,
  user_id ObjectId REFERENCES users(_id),
  task_id ObjectId REFERENCES tasks(_id),
  project_id ObjectId REFERENCES projects(_id),
  description TEXT,
  start_time TIMESTAMP NOT NULL,
  end_time TIMESTAMP,
  duration INTEGER, -- in minutes
  is_billable BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Notifications Collection
CREATE TABLE notifications (
  _id ObjectId PRIMARY KEY,
  recipient_id ObjectId REFERENCES users(_id),
  sender_id ObjectId REFERENCES users(_id),
  type ENUM('task_assigned', 'task_completed', 'project_updated', 'comment_added', 'mention'),
  title VARCHAR(255) NOT NULL,
  message TEXT,
  related_id ObjectId, -- Can reference tasks, projects, etc.
  is_read BOOLEAN DEFAULT false,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Activity Log Collection
CREATE TABLE activity_logs (
  _id ObjectId PRIMARY KEY,
  user_id ObjectId REFERENCES users(_id),
  action VARCHAR(100) NOT NULL,
  resource_type VARCHAR(50) NOT NULL,
  resource_id ObjectId NOT NULL,
  details JSONB,
  ip_address VARCHAR(45),
  user_agent TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- File Uploads Collection
CREATE TABLE file_uploads (
  _id ObjectId PRIMARY KEY,
  filename VARCHAR(255) NOT NULL,
  original_name VARCHAR(255) NOT NULL,
  mime_type VARCHAR(100) NOT NULL,
  size INTEGER NOT NULL,
  url VARCHAR(500) NOT NULL,
  uploaded_by ObjectId REFERENCES users(_id),
  project_id ObjectId REFERENCES projects(_id),
  task_id ObjectId REFERENCES tasks(_id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for better performance
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_projects_owner ON projects(owner_id);
CREATE INDEX idx_projects_status ON projects(status);
CREATE INDEX idx_tasks_project ON tasks(project_id);
CREATE INDEX idx_tasks_assigned ON tasks(assigned_to);
CREATE INDEX idx_tasks_status ON tasks(status);
CREATE INDEX idx_comments_task ON comments(task_id);
CREATE INDEX idx_notifications_recipient ON notifications(recipient_id);
CREATE INDEX idx_activity_logs_user ON activity_logs(user_id);
CREATE INDEX idx_time_entries_user ON time_entries(user_id);
