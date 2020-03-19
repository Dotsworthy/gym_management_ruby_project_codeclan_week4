DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS sessions;
DROP TABLE IF EXISTS trainers;

CREATE TABLE members (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR (255),
  last_name VARCHAR (255),
  user_name VARCHAR (255),
  image_url VARCHAR (255)
);

CREATE TABLE trainers (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR (255),
  last_name VARCHAR (255),
  user_name VARCHAR (255),
  image_url VARCHAR (255)
);

CREATE TABLE sessions (
  id SERIAL PRIMARY KEY,
  type VARCHAR (255),
  starts_at VARCHAR (255),
  on_date DATE,
  num_of_places INT,
  led_by INT REFERENCES trainers(id) ON DELETE CASCADE
);

CREATE TABLE bookings (
  id SERIAL PRIMARY KEY,
  member_id INT REFERENCES members(id) ON DELETE CASCADE,
  session_id INT REFERENCES sessions(id) ON DELETE CASCADE
);
