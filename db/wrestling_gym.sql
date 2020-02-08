DROP TABLE bookings;
DROP TABLE members;
DROP TABLE sessions;
-- DROP TABLE session_types;
-- DROP TABLE trainers;
-- DROP TABLE rooms;

CREATE TABLE members (
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
  duration VARCHAR (255),
  capacity INT
);

-- CREATE TABLE session_types (
--   id SERIAL PRIMARY KEY,
--   name VARCHAR (255),
--   equipment_needed VARCHAR (255)
-- );

-- CREATE TABLE trainers (
--   id SERIAL PRIMARY KEY,
--   first_name VARCHAR (255),
--   last_name VARCHAR (255),
--   specialism VARCHAR (255)
-- );

-- CREATE TABLE rooms (
--   id SERIAL PRIMARY KEY,
--   size INT,
--   equipment VARCHAR
-- );

CREATE TABLE bookings (
  id SERIAL PRIMARY KEY,
  member_id INT REFERENCES members(id) ON DELETE CASCADE,
  session_id INT REFERENCES sessions(id) ON DELETE CASCADE
  -- trainer_id INT REFERENCES trainers(id) ON DELETE CASCADE
);
