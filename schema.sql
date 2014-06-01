CREATE TABLE users (
  id serial PRIMARY KEY,
  name varchar(300) NOT NULL,
  pic_url varchar(1000)
);

CREATE TABLE nominations (
  id serial,
  content varchar(1000) NOT NULL,
  created_at timestamp NOT NULL,
  nominee_id integer NOT NULL REFERENCES users(id)
);

