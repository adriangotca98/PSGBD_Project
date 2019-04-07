create procedure create_tables_indexes as
begin
    execute immediate 'drop table stadium cascade constraints';
    execute immediate 'drop table team cascade constraints';
    execute immediate 'drop table player cascade constraints';
    execute immediate 'drop table referee cascade constraints';
    execute immediate 'drop table match cascade constraints';
    execute immediate 'drop table goal cascade constraints';
    execute immediate 'create table stadium
    (
        id_stadium    int          not null primary key,
        name          varchar2(50) not null,
        city          varchar2(20) not null,
        founding_date date,
        capacity      int
    )';
    execute immediate 'create table team
    (
        id_team       int          not null primary key,
        name          varchar2(50) not null,
        id_stadium    int          not null,
        founding_date date,
        constraint fk_id_stadium foreign key (id_stadium) references stadium (id_stadium)
    )';
    execute immediate ' create table player
    (
        id_player     int          not null primary key,
        id_team       int,
        first_name    varchar2(50) not null,
        last_name     varchar2(50) not null,
        nationality   varchar2(50),
        date_of_birth date,
        position      varchar(10)  not null,
        constraint fk_id_team foreign key (id_team) references team (id_team)
    )';
    execute immediate 'create table referee
    (
        id_referee int          not null primary key,
        first_name varchar(50)  not null,
        last_name  varchar2(50) not null
    )';
    execute immediate 'create table match
    (
        match_time date not null,
        id_team1   int  not null,
        id_team2   int  not null,
        id_referee int,
        attendance int,
        constraint fk_id_team1 foreign key (id_team1) references team (id_team),
        constraint fk_id_team2 foreign key (id_team2) references team (id_team),
        constraint fk_id_referee foreign key (id_referee) references referee (id_referee),
        constraint pk_match primary key (match_time, id_team1)
    )';
    execute immediate 'create table goal
    (
        id_goal    int  not null primary key,
        id_team1   int  not null,
        match_time date not null,
        id_player  int  not null,
        constraint fk_match foreign key (match_time, id_team1) references match (match_time, id_team1),
        constraint fk_id_player foreign key (id_player) references player (id_player)
    )';
    execute immediate 'create index idx_team
    on player(id_team)';
end;
/

