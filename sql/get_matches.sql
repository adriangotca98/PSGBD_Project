create or replace function get_matches(stage int)
return number is
  type vector is varray (60000) of int;
  type strvector is varray (60000) of varchar(50);
  teams vector := vector();
  names strvector := strvector();
begin
  select id_team bulk collect into teams from play where (stage-1)*1024+1<=ID_play and ID_play<=stage*1024;
  for i in 1..teams.COUNT loop
    select name bulk collect into names from team where id_team = teams(i);
    DBMS_OUTPUT.put_line(names(1));
  end loop;
  return teams.count;
end;