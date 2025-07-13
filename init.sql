-- Create the main complaints table
CREATE TABLE IF NOT EXISTS rail_sathi_railsathicomplain (
    complain_id SERIAL PRIMARY KEY,
    pnr_number VARCHAR(20),
    is_pnr_validated VARCHAR(20) DEFAULT 'not-attempted',
    name VARCHAR(100),
    mobile_number VARCHAR(15),
    complain_type VARCHAR(50),
    complain_description TEXT,
    complain_date DATE,
    complain_status VARCHAR(20) DEFAULT 'pending',
    train_id INTEGER,
    train_number VARCHAR(20),
    train_name VARCHAR(100),
    coach VARCHAR(10),
    berth_no INTEGER,
    train_no INTEGER,
    train_depot VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(100)
);

-- Create the media files table
CREATE TABLE IF NOT EXISTS rail_sathi_railsathicomplainmedia (
    id SERIAL PRIMARY KEY,
    complain_id INTEGER REFERENCES rail_sathi_railsathicomplain(complain_id) ON DELETE CASCADE,
    media_type VARCHAR(10),
    media_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(100)
);

-- Create user management tables
CREATE TABLE IF NOT EXISTS user_onboarding_roles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS user_onboarding_user (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    depo VARCHAR(100),
    user_type_id INTEGER REFERENCES user_onboarding_roles(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create train access table
CREATE TABLE IF NOT EXISTS trains_trainaccess (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES user_onboarding_user(id),
    train_details JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create train details table
CREATE TABLE IF NOT EXISTS trains_traindetails (
    id SERIAL PRIMARY KEY,
    train_no VARCHAR(20) UNIQUE NOT NULL,
    train_name VARCHAR(100),
    depot VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create station tables
CREATE TABLE IF NOT EXISTS station_Depot (
    id SERIAL PRIMARY KEY,
    depot_code VARCHAR(20) UNIQUE NOT NULL,
    depot_name VARCHAR(100),
    division_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS station_division (
    id SERIAL PRIMARY KEY,
    division_id VARCHAR(20) UNIQUE NOT NULL,
    division_code VARCHAR(20),
    division_name VARCHAR(100),
    zone_id INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS station_zone (
    id SERIAL PRIMARY KEY,
    zone_id VARCHAR(20) UNIQUE NOT NULL,
    zone_code VARCHAR(20),
    zone_name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert some sample data
INSERT INTO user_onboarding_roles (name) VALUES 
('war room user'),
('s2 admin'),
('railway admin')
ON CONFLICT DO NOTHING;

-- Insert sample users
INSERT INTO user_onboarding_user (email, first_name, last_name, depo, user_type_id) VALUES 
('admin@example.com', 'Admin', 'User', 'Sample Depot', 1),
('user@example.com', 'Test', 'User', 'Test Depot', 2)
ON CONFLICT DO NOTHING;

-- Insert sample train details
INSERT INTO trains_traindetails (train_no, train_name, depot) VALUES 
('12345', 'Sample Train', 'Sample Depot'),
('67890', 'Test Train', 'Test Depot')
ON CONFLICT DO NOTHING;

-- Insert sample complaints
INSERT INTO rail_sathi_railsathicomplain (
    pnr_number, name, mobile_number, complain_type, complain_description, 
    complain_status, train_number, train_name, created_by
) VALUES 
('PNR123456', 'John Doe', '9876543210', 'Cleanliness', 'Train was not clean', 'pending', '12345', 'Sample Train', 'John Doe'),
('PNR789012', 'Jane Smith', '9876543211', 'Food', 'Food quality was poor', 'pending', '67890', 'Test Train', 'Jane Smith')
ON CONFLICT DO NOTHING;