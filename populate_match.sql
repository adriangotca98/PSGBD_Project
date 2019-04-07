CREATE OR REPLACE PROCEDURE POPULATE_MATCH_AND_PLAY AS
    TYPE vector IS TABLE OF INT;
    previous_round vector;
    this_round vector;
    id_referee INT;
    id_match   INT;
    id_play    INT;
    match_time DATE;
    counter    INT;
    attendance INT;
BEGIN
    id_match:=1;
    id_play:=1;
    select id_team bulk collect into this_round from studenti order by id_team;
    for i in this_round.first..this_round.second loop
        insert into play values (id_play,id_match,i);
        id_play:=id_play+1;
        i:=i+1;
        insert into play values (id_play,id_match,i);
        id_play:=id_play+1;
    end loop;
    for id_team1 in
END;