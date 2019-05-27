create or replace procedure populate_substitution as
  type vector is varray (100) of int;
  cursor c_play is select * from play;
  id_substitution int := 0;
begin
  for v_play in c_play loop
    declare
      playing vector := vector();
      subs vector := vector();
      players vector := vector();
      team_players vector := vector();
      sub_playing1 int;
      sub_subst1 int;
      sub_playing2 int;
      sub_subst2 int;
      sub_playing3 int;
      sub_subst3 int;
      n int := 0;
      m int := 0;
    begin
      playing.extend(100);
      subs.extend(100);
      team_players.extend(100);
      players.extend(100);

      -- selectez toti jucatorii de pe teren din acest meci
      select id_player bulk collect into players from FIRST11 where id_match=v_play.ID_MATCH;

      -- selectez toti jucatorii unei anumite echipe
      select id_player bulk collect into team_players from PLAYER where id_team=v_play.ID_TEAM;

      -- selectez toti jucatorii de pe teren ai anumite echipe
      for i in 1..team_players.count loop
        declare
          is_playing int := 0;
        begin
          for j in 1..players.count loop
            if team_players(i) = players(j) then
              is_playing := 1;
              exit;
            end if;
          end loop;
          if is_playing = 1 then
            n:=n+1;
            playing(n) := team_players(i);
          end if;
        end;
      end loop;

      -- selectez toti jucatorii ce nu sunt pe teren ai anumite echipe
      for i in 1..team_players.count loop
        declare
          is_playing int := 0;
        begin
          for j in 1..playing.count loop
            if team_players(i) = playing(j) then
              is_playing := 1;
              exit;
            end if;
          end loop;
          if is_playing = 0 then
            m:=m+1;
            subs(m) := team_players(i);
          end if;
        end;
      end loop;

      -- aleg substitutia1
      sub_playing1 := playing(trunc(dbms_random.value(1,n+1)));
      sub_subst1 := subs(trunc(dbms_random.value(1,m+1)));

      -- aleg substitutia2
      sub_playing2 := playing(trunc(dbms_random.value(1,n+1)));
      while sub_playing1 = sub_playing2 loop
        sub_playing2 := playing(trunc(dbms_random.value(1,n+1)));
      end loop;
      sub_subst2 := subs(trunc(dbms_random.value(1,m+1)));
      while sub_subst1 = sub_subst2 loop
        sub_subst2 := playing(trunc(dbms_random.value(1,n+1)));
      end loop;

      -- aleg substitutia3
      sub_playing3 := playing(trunc(dbms_random.value(1,n+1)));
      while sub_playing1 = sub_playing3 or sub_playing2 = sub_playing3 loop
        sub_playing3 := playing(trunc(dbms_random.value(1,n+1)));
      end loop;
      sub_subst3 := subs(trunc(dbms_random.value(1,m+1)));
      while sub_subst1 = sub_subst3 or sub_subst2 = sub_subst3 loop
        sub_subst3 := playing(trunc(dbms_random.value(1,n+1)));
      end loop;

      -- inserez substitutiile
      id_substitution := id_substitution+1;
      insert into SUBSTITUTION values (id_substitution,sub_playing1,sub_subst1,v_play.ID_MATCH, trunc(dbms_random.value(0,95)));
      id_substitution := id_substitution+1;
      insert into SUBSTITUTION values (id_substitution,sub_playing2,sub_subst2,v_play.ID_MATCH, trunc(dbms_random.value(0,95)));
      id_substitution := id_substitution+1;
      insert into SUBSTITUTION values (id_substitution,sub_playing3,sub_subst3,v_play.ID_MATCH, trunc(dbms_random.value(0,95)));
    end;
  end loop;
end;