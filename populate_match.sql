SET SERVEROUTPUT ON;
DECLARE
    TYPE varr IS VARRAY(1000) OF varchar2(255);
    cursor id1 is select id_team from team;
    cursor id2 is select id_team from team;
    id_referee int;
    match_time date;
    counter int;
begin
    for id_team1 in id1 loop
        counter:=0;
        for id_team2 in id2 loop
            if id_team1.id_team<>id_team2.id_team then
                counter := counter + 7;
                id_referee:=dbms_random.value(1,100);
                match_time:=TO_DATE('01-01-1990','MM-DD-YYYY')+counter+TRUNC(DBMS_RANDOM.VALUE(0, 23)/24);
                insert into match values(match_time,id_team1.id_team,id_team2.id_team,id_referee,null);
            end if;
        end loop;
    end loop;
end;