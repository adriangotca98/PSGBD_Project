create or replace procedure get_players(v_name in varchar2) as
    type vector is varray(41000) of varchar2(100);
    players_list vector:=vector();
    v_i int;
    name1 varchar2(1000);
begin
    players_list.extend(40990);
    name1:='%'||v_name||'%';
    select first_name||' '||last_name||'||'||ID_PLAYER bulk collect into players_list from player where first_name||' '||last_name like name1;
    if players_list.COUNT<>0 then
        for v_i in players_list.first..players_list.last loop
            dbms_output.put_line(players_list(v_i));
        end loop;
    end if;
end;