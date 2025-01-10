-- Drop database if exists
DROP DATABASE IF EXISTS mydbname;

-- Drop user if exists
DROP USER IF EXISTS myuser;

-- Create database
CREATE DATABASE mydbname;

-- Create user with password
CREATE USER myuser WITH PASSWORD 'mypassword';

-- Connect to the database
\c mydbname

-- Grant all privileges on all tables (current and future)
GRANT ALL PRIVILEGES ON DATABASE mydbname TO myuser;
ALTER DATABASE mydbname OWNER TO myuser;

-- Create schema and grant permissions
CREATE SCHEMA IF NOT EXISTS public;
ALTER SCHEMA public OWNER TO myuser;
GRANT ALL ON SCHEMA public TO myuser;
GRANT ALL ON ALL TABLES IN SCHEMA public TO myuser;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO myuser;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA public TO myuser;

-- Allow user to create new tables
ALTER USER myuser CREATEDB;

-- Set default privileges for future objects
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO myuser;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO myuser;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON FUNCTIONS TO myuser;