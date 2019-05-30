create or replace procedure get_team_info(id int) as
    type vector is varray(1000) of varchar2(100);
    players vector:=vector();
begin
    select first_name||' '||last_name bulk collect into players from player where id_team=id;
    DBMS_OUTPUT.put_line(players.count);
    for i in players.first..players.last loop
        dbms_output.put_line(players(i));
    end loop;
end;