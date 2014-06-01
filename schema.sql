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


INSERT INTO users (name) VALUES ('Alex Morgan');
INSERT INTO users (name) VALUES ('Omid Bachari');
INSERT INTO users (name) VALUES ('Carol Jones');
INSERT INTO users (name) VALUES ('Caleb Thill');
INSERT INTO users (name) VALUES ('Dan Murphy');

INSERT INTO nominations (content, created_at, nominee_id) VALUES ('Worst Face', now(), 1);
