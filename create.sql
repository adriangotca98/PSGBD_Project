DROP TABLE stadium CASCADE CONSTRAINTS;
DROP TABLE team CASCADE CONSTRAINTS;
DROP TABLE player CASCADE CONSTRAINTS;
DROP TABLE referee CASCADE CONSTRAINTS;
DROP TABLE match CASCADE CONSTRAINTS;
DROP TABLE goal CASCADE CONSTRAINTS;
CREATE TABLE stadium (
  id_stadium    INT          NOT NULL PRIMARY KEY,
  name          VARCHAR2(50) NOT NULL,
  city          VARCHAR2(20) NOT NULL,
  founding_date DATE,
  capacity      INT
);
CREATE TABLE team (
  id_team       INT          NOT NULL PRIMARY KEY,
  name          VARCHAR2(50) NOT NULL,
  id_stadium    INT          NOT NULL,
  founding_date DATE,
  CONSTRAINT fk_id_stadium FOREIGN KEY (id_stadium) REFERENCES stadium(id_stadium)
);
CREATE TABLE player (
  id_player     INT          NOT NULL PRIMARY KEY,
  id_team       INT,
  first_name    VARCHAR2(50) NOT NULL,
  last_name     VARCHAR2(50) NOT NULL,
  nationality   VARCHAR2(50),
  date_of_birth DATE,
  position      VARCHAR(10) NOT NULL,
  CONSTRAINT fk_id_team FOREIGN KEY (id_team) REFERENCES team(id_team)
);
CREATE TABLE referee (
  id_referee INT          NOT NULL PRIMARY KEY,
  first_name VARCHAR(50)  NOT NULL,
  last_name  VARCHAR2(50) NOT NULL
);
CREATE TABLE match (
  match_time DATE NOT NULL,
  id_team1   INT  NOT NULL,
  id_team2   INT  NOT NULL,
  id_referee INT,
  attendance INT,
  CONSTRAINT fk_id_team1 FOREIGN KEY (id_team1) REFERENCES team (id_team),
  CONSTRAINT fk_id_team2 FOREIGN KEY (id_team2) REFERENCES team (id_team),
  CONSTRAINT fk_id_referee FOREIGN KEY (id_referee) REFERENCES referee (id_referee),
  CONSTRAINT pk_match PRIMARY KEY (match_time, id_team1)
);
CREATE TABLE goal (
  id_goal INT NOT NULL PRIMARY KEY,
  id_team1 INT NOT NULL,
  match_time DATE NOT NULL,
  id_player INT NOT NULL,
  CONSTRAINT fk_match FOREIGN KEY (match_time, id_team1) REFERENCES match (match_time, id_team1),
  CONSTRAINT fk_id_player FOREIGN KEY (id_player) REFERENCES player (id_player)
);