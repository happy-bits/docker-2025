\c postgres

-- Drop database if exists
DROP DATABASE IF EXISTS product_database;

-- Drop user if exists
DROP USER IF EXISTS username;

-- Create database
CREATE DATABASE product_database;

-- Create user with password
CREATE USER username WITH PASSWORD 'strong_password';

-- Connect to the database
\c product_database

-- Grant all privileges on all tables (current and future)
GRANT ALL PRIVILEGES ON DATABASE product_database TO username;
ALTER DATABASE product_database OWNER TO username;

-- Create schema and grant permissions
CREATE SCHEMA IF NOT EXISTS public;
ALTER SCHEMA public OWNER TO username;
GRANT ALL ON SCHEMA public TO username;
GRANT ALL ON ALL TABLES IN SCHEMA public TO username;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO username;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA public TO username;

-- Allow user to create new tables
ALTER USER username CREATEDB;

-- Set default privileges for future objects
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO username;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO username;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON FUNCTIONS TO username;