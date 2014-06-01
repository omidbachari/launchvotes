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
INSERT INTO users (name) VALUES ('Alek Grinberg');
INSERT INTO users (name) VALUES ('Colin Scott');
INSERT INTO users (name) VALUES ('David Guerette');
INSERT INTO users (name) VALUES ('Griff Hall');
INSERT INTO users (name) VALUES ('Kurt Michael Henry');
INSERT INTO users (name) VALUES ('Nick Terrafranca');
INSERT INTO users (name) VALUES ('Pete Dunbar');
INSERT INTO users (name) VALUES ('Rachael Serur');
INSERT INTO users (name) VALUES ('Sam Gladstone');
INSERT INTO users (name) VALUES ('Adam Andrewjeski');
INSERT INTO users (name) VALUES ('Alla Hoffman');
INSERT INTO users (name) VALUES ('Azi Hussain');
INSERT INTO users (name) VALUES ('Chris S');
INSERT INTO users (name) VALUES ('Chris Barnett');
INSERT INTO users (name) VALUES ('Christopher Finlayson');
INSERT INTO users (name) VALUES ('Craig McGinley');
INSERT INTO users (name) VALUES ('Dan Kleinman');
INSERT INTO users (name) VALUES ('David Godwin');
INSERT INTO users (name) VALUES ('David Pointeau');
INSERT INTO users (name) VALUES ('Fahad Mukunzi');
INSERT INTO users (name) VALUES ('Helen Swanson');
INSERT INTO users (name) VALUES ('Jacinda Zhong');
INSERT INTO users (name) VALUES ('John Keith');
INSERT INTO users (name) VALUES ('Katie Blair');
INSERT INTO users (name) VALUES ('Lawrence C');
INSERT INTO users (name) VALUES ('Nick Lee');
INSERT INTO users (name) VALUES ('Patrick');
INSERT INTO users (name) VALUES ('Rory Quinlan');
INSERT INTO users (name) VALUES ('Rory Team');
INSERT INTO users (name) VALUES ('Simon Skates');
INSERT INTO users (name) VALUES ('Ted Kwasnik');
INSERT INTO users (name) VALUES ('Zachary Adams');

INSERT INTO nominations (content, created_at, nominee_id) VALUES ('Worst Face', now(), 1);

INSERT INTO nominations (content, created_at, nominee_id) VALUES ('Best Hairdo', now(),3);
