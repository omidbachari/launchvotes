CREATE TABLE users (
  uid varchar(50) PRIMARY KEY,
  email varchar(100),
  name varchar(300) NOT NULL,
  pic_url varchar(1000)
);

-- uid,email,pic_url,name
CREATE TABLE nominations (
  id serial,
  content varchar(1000) NOT NULL,
  votes integer,
  created_at timestamp NOT NULL,
  nominee_id varchar(50) NOT NULL REFERENCES users(uid)
);

-- CREATE TABLE votes (
--   nominee_id varchar95o
-- )
