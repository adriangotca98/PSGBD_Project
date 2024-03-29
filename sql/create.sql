create or replace procedure create_table_index as

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE stadium CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE team CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE player CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE referee CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE match CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE goal CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE CARDS CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE FIRST11 CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE PLAY CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'DROP TABLE SUBSTITUTION CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE 'CREATE TABLE stadium
    (
        id_stadium    INT          NOT NULL PRIMARY KEY,
        name          VARCHAR2(50) NOT NULL,
        city          VARCHAR2(20) NOT NULL,
        founding_date DATE,
        capacity      INT
    )';
    EXECUTE IMMEDIATE 'CREATE TABLE team
    (
        id_team       INT          NOT NULL PRIMARY KEY,
        name          VARCHAR2(50) NOT NULL,
        id_stadium    INT          NOT NULL,
        founding_date DATE,
        budget INT,
        CONSTRAINT team_fk_id_stadium FOREIGN KEY (id_stadium) REFERENCES stadium (id_stadium)
    )';
    EXECUTE IMMEDIATE ' CREATE TABLE player
    (
        id_player     INT          NOT NULL PRIMARY KEY,
        id_team       INT,
        first_name    VARCHAR2(50) NOT NULL,
        last_name     VARCHAR2(50) NOT NULL,
        nationality   VARCHAR2(50),
        date_of_birth DATE,
        position      VARCHAR(10)  NOT NULL,
        value         INT,
        CONSTRAINT player_fk_id_team FOREIGN KEY (id_team) REFERENCES team (id_team)
    )';
    EXECUTE IMMEDIATE 'CREATE TABLE referee
    (
        id_referee INT          NOT NULL PRIMARY KEY,
        first_name VARCHAR(50)  NOT NULL,
        last_name  VARCHAR2(50) NOT NULL
    )';
    EXECUTE IMMEDIATE 'CREATE TABLE match
    (
        id_match INT NOT NULL PRIMARY KEY,
        id_referee INT NOT NULL,
        match_time DATE NOT NULL,
        attendance INT NOT NULL,
        CONSTRAINT match_fk_id_referee FOREIGN KEY (id_referee) REFERENCES referee (id_referee)
    )';
    EXECUTE IMMEDIATE 'CREATE TABLE goal
    (
        id_goal    INT  NOT NULL PRIMARY KEY,
        id_match   INT  NOT NULL,
        goal_time  INT NOT NULL,
        id_player  INT  NOT NULL,
        id_player_assist  INT,
        type VARCHAR2(55),
        CONSTRAINT GOAL_FK_ID_MATCH FOREIGN KEY (ID_MATCH) REFERENCES MATCH(ID_MATCH),
        CONSTRAINT GOAL_FK_ID_PLAYER FOREIGN KEY (ID_PLAYER) REFERENCES PLAYER(ID_PLAYER),
        CONSTRAINT GOAL_FK_ID_PLAYER_ASSIST FOREIGN KEY (ID_PLAYER_ASSIST) REFERENCES PLAYER(ID_PLAYER)
    )';
    EXECUTE IMMEDIATE 'CREATE TABLE CARDS
    (
        ID_CARD INT NOT NULL PRIMARY KEY,
        ID_PLAYER INT NOT NULL,
        ID_MATCH INT NOT NULL,
        CARD_TIME INT NOT NULL,
        CONSTRAINT CARDS_fk_id_MATCH FOREIGN KEY (id_MATCH) REFERENCES MATCH(id_MATCH),
        CONSTRAINT CARDS_FK_ID_PLAYER FOREIGN KEY (ID_PLAYER) REFERENCES PLAYER(ID_PLAYER)
    )';
    EXECUTE IMMEDIATE 'CREATE TABLE FIRST11
    (
        ID_FIRST11 INT NOT NULL PRIMARY KEY,
        ID_PLAYER INT NOT NULL,
        ID_MATCH INT NOT NULL,
        CONSTRAINT FIRST11_FK_ID_PLAYER FOREIGN KEY (ID_PLAYER) REFERENCES PLAYER(ID_PLAYER),
        CONSTRAINT FIRST11_FK_ID_MATCH FOREIGN KEY (ID_MATCH) REFERENCES MATCH(ID_MATCH)
    )';
    EXECUTE IMMEDIATE 'CREATE TABLE SUBSTITUTION
    (
        ID_SUBSTITUTION INT NOT NULL PRIMARY KEY,
        ID_PLAYER1 INT NOT NULL,
        ID_PLAYER2 INT NOT NULL,
        ID_MATCH INT NOT NULL,
        SUBSTITUTION_TIME INT NOT NULL,
        CONSTRAINT SUBSTITUTION_FK_ID_PLAYER1 FOREIGN KEY (ID_PLAYER1) REFERENCES PLAYER(ID_PLAYER),
        CONSTRAINT SUBSTITUTION_FK_ID_PLAYER2 FOREIGN KEY (ID_PLAYER2) REFERENCES PLAYER(ID_PLAYER),
        CONSTRAINT SUBSTITUTION_FK_ID_MATCH FOREIGN KEY (ID_MATCH) REFERENCES MATCH(ID_MATCH)
    )';
    EXECUTE IMMEDIATE 'CREATE TABLE PLAY
    (
        ID_PLAY INT NOT NULL PRIMARY KEY,
        ID_MATCH INT NOT NULL,
        ID_TEAM INT NOT NULL,
        HOME INT NOT NULL,
        CONSTRAINT PLAY_FK_ID_MATCH FOREIGN KEY (ID_MATCH) REFERENCES MATCH(ID_MATCH),
        CONSTRAINT PLAY_fk_id_team FOREIGN KEY (id_team) REFERENCES team (id_team)
    )';
    EXECUTE IMMEDIATE 'CREATE INDEX idx_first11_id_match
    ON first11(id_match);';
    EXECUTE IMMEDIATE 'create index idx_team_position
    on player(id_team,position)';
    EXECUTE IMMEDIATE 'CREATE INDEX idx_team
    ON PLAYER(id_team)';
    EXECUTE IMMEDIATE 'CREATE INDEX idx_substitution_id_match
    ON SUBSTITUTION(id_match)';
    EXECUTE IMMEDIATE 'CREATE INDEX idx_substitution_player1_match
    ON SUBSTITUTION(id_player1, id_match)';
    --below query needs to be executed!!!!
    EXECUTE IMMEDIATE 'CREATE INDEX idx_substitution_player2_match
    ON SUBSTITUTION(id_player2, id_match)';
    EXECUTE IMMEDIATE 'CREATE INDEX idx_goal_id_match
    ON GOAL(id_match)';
    --below query needs to be executed!!!!
    EXECUTE IMMEDIATE 'CREATE INDEX idx_goal_player
    ON GOAL(id_player)';
    --below query needs to be executed!!!!
    EXECUTE IMMEDIATE 'CREATE INDEX idx_goal_player_assist
    ON GOAL(id_player_assist)';
    EXECUTE IMMEDIATE 'CREATE INDEX idx_cards_id_match
    ON CARDS(id_match);';
END;