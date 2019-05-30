create or replace procedure get_player_info(id int) as
    nume player.first_name%TYPE;
    prenume player.last_name%TYPE;
    first11_appeareances int;
    pozitie player.position%TYPE;
begin
    select first_name, last_name, POSITION into nume, prenume, pozitie from player where id_player=id;
    dbms_output.put_line(nume||' '||prenume);
    dbms_output.put_line(pozitie);
    dbms_output.put_line(get_team(id));
    dbms_output.put_line(get_goals_number(id));
    dbms_output.put_line(get_assists_number(id));
    --dbms_output.put_line(get_minutes(id));
    select count(*) into first11_appeareances from first11 where id_player=id;
    dbms_output.put_line(first11_appeareances);
end;