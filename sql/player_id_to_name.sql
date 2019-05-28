create or replace function id_to_name(id int)
return varchar2 is
  type vector is varray (2) of int;
  type strvector is varray (2) of varchar2(50);
  v_team vector := vector();
  team_name strvector := strvector();
  answer strvector := strvector();
begin
  select id_team bulk collect into v_team from player where id_player = id;
  select name bulk collect into team_name from team where id_team = v_team(1);
  select first_name || ' ' || last_name || ' (' || team_name(1) || ')' bulk collect into answer from player where id_player = id;
  return answer(1);
end;