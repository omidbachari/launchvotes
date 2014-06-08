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


-- INSERT INTO users (name, pic_url) VALUES ('Alex Morgan', 'https://s3.amazonaws.com/Launchers/Alex-Morgan.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Omid Bachari', 'https://s3.amazonaws.com/Launchers/Omid-Bachari.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Carol Jones', 'https://s3.amazonaws.com/Launchers/Carol-Jones.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Caleb Thill', 'https://s3.amazonaws.com/Launchers/Caleb-Thill.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Dan Murphy', 'https://s3.amazonaws.com/Launchers/Dan-Murphy.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Alek Grinberg', 'https://s3.amazonaws.com/Launchers/Alek-Grinberg.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Colin Scott', 'https://s3.amazonaws.com/Launchers/Colin-Scott.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Griff Hall', 'https://s3.amazonaws.com/Launchers/Griff-Hall.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('David Guerette', 'https://s3.amazonaws.com/Launchers/David-Guerette.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Kurt Michael Henry', 'https://s3.amazonaws.com/Launchers/Kurt-Henry.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Nick Terrafranca', 'https://s3.amazonaws.com/Launchers/Nick-Terrafranca.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Pete Dunbar', 'https://s3.amazonaws.com/Launchers/Pete-Dunbar.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Rachael Serur', 'https://s3.amazonaws.com/Launchers/Rachael-Serur.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Sam Gladstone', 'https://s3.amazonaws.com/Launchers/Sam-Gladstone.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Adam Andrewjeski', 'https://s3.amazonaws.com/Launchers/Adam-Andrewjeski.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Alla Hoffman', 'https://s3.amazonaws.com/Launchers/Alla-Hoffman.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Azi Hussain', 'https://s3.amazonaws.com/Launchers/Azi-Hussain.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Chris Saltys', 'https://s3.amazonaws.com/Launchers/Chris-Saltys.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Chris Barnett', 'https://s3.amazonaws.com/Launchers/Chris-Barnett.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Christopher Finlayson', 'https://s3.amazonaws.com/Launchers/Chris-Finlayson.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Craig McGinley', 'https://s3.amazonaws.com/Launchers/Craig+McGinley.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Dan Kleinman', 'https://s3.amazonaws.com/Launchers/Dan-Kleiman.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('David Goodwin', 'https://s3.amazonaws.com/Launchers/David-Goodwin.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('David Pointeau', 'https://s3.amazonaws.com/Launchers/David-Pointeau.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Fahad Mukunzi', 'https://s3.amazonaws.com/Launchers/Fahad-Mukunzi.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Helen Swanson', 'https://s3.amazonaws.com/Launchers/Helen-Swanson.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Jacinda Zhong', 'https://s3.amazonaws.com/Launchers/Jacinda-Zhong.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('John Keith', 'https://s3.amazonaws.com/Launchers/John-Keith.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Katie Blair', 'https://s3.amazonaws.com/Launchers/Katie-Blair.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Lawrence Chang', 'https://s3.amazonaws.com/Launchers/Lawrence-Chang.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Nick Lee', 'https://s3.amazonaws.com/Launchers/Nick-Lee.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Patrick Arthur', 'https://s3.amazonaws.com/Launchers/Pat-Arthur.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Rory Quinlan', 'https://s3.amazonaws.com/Launchers/Rory-Quinlan.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Rory Team', 'https://s3.amazonaws.com/Launchers/Rory-Team.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Simon Skates', 'https://s3.amazonaws.com/Launchers/Simon-Skates.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Ted Kwasnik', 'https://s3.amazonaws.com/Launchers/Ted-Kwasnik.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Zachary Adams', 'https://s3.amazonaws.com/Launchers/Zach-Adams.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Brian Cox', 'https://s3.amazonaws.com/Launchers/Brian-Cox.jpg');
-- INSERT INTO users (name, pic_url) VALUES ('Kevin Jain', 'https://s3.amazonaws.com/Launchers/Kevin-Jain.jpg');

