DROP TABLE bookings;
DROP TABLE members;
DROP TABLE sessions;
DROP TABLE trainers;

CREATE TABLE members (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR (255),
  last_name VARCHAR (255),
  alias VARCHAR (255),
  image_url VARCHAR (255)
);

CREATE TABLE trainers (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR (255),
  last_name VARCHAR (255),
  alias VARCHAR (255),
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
