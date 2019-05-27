create or replace procedure populate_goal as
  type vector is varray (100) of int;
  type vectorchar is varray (1000) of varchar2(255);
  cursor c_play is select * from play;
  goal_count int;
  id_goal int:=0;
begin
  for v_play in c_play loop

    declare
      players vector := vector();
      subs vector := vector();
      subs_time vector := vector();
      subs_out vector := vector();
      team_players vector := vector();
      v_sub int;
      v_player int;
      v_time int;
      v_idx int;
      v_idx2 int;
      v_type vectorchar := vectorchar('Header', 'Right Foot', 'Left Foot', 'Autogoal');
      v_tip varchar2(255);
      v_assist int;
      v_player2 int;
      ok int;
      v_rez int;
      v_tries int;
    begin
      players.extend(100);
      team_players.extend(100);
      -- selectez toti jucatorii de pe teren din acest meci
      select id_player bulk collect into players from FIRST11 where id_match=v_play.ID_MATCH;

      -- selectez toti jucatorii din echipa
      select id_player bulk collect into team_players from player where id_team = v_play.ID_TEAM;

      -- selectez toti jucatorii de pe teren din acest meci
      select id_player1 bulk collect into subs_out from SUBSTITUTION where id_match=v_play.ID_MATCH;
      select id_player2 bulk collect into subs from SUBSTITUTION where id_match=v_play.ID_MATCH;
      select SUBSTITUTION_TIME bulk collect into subs_time from SUBSTITUTION where id_match=v_play.ID_MATCH;

      goal_count := trunc(DBMS_RANDOM.value(1, 5));
      for i in 1..goal_count loop
        v_tip := v_type(trunc(DBMS_RANDOM.value(1, 5)));

        --sansele sa fie o rezerva
        v_sub := trunc(DBMS_RANDOM.value(1, 11));
        if v_sub < 3 then
          -- gasesc o rezerva din echipa aceasta
          v_idx := trunc(DBMS_RANDOM.value(1, 7));
          v_player := subs(v_idx);
          while TRUE loop
            ok := 0;
            for i in 1..team_players.count loop
              if v_player  = team_players(i) then
                ok := 1;
                exit;
              end if;
            end loop;
            if ok = 1 then
              exit;
            end if;
            v_idx := trunc(DBMS_RANDOM.value(1, 7));
            v_player := subs(v_idx);
          end loop;

          v_time := trunc(DBMS_RANDOM.value(subs_time(v_idx), 95));
          id_goal := id_goal+1;

          --cautam un assist
          v_assist := trunc(DBMS_RANDOM.value(1, 10));
          if v_assist <= 2 then
            -- nu avem un assist
            insert into GOAL values (id_goal,v_play.ID_MATCH,v_time,v_player,NULL,v_tip);
          else
            --sansele ca assistul sa fie o rezerva
            v_rez := trunc(DBMS_RANDOM.value(1, 10));
            if v_rez <=2 then
              -- assistul este o rezerva
              v_tries := 20;
              v_idx2 := trunc(DBMS_RANDOM.value(1, 7));
              while v_idx2 = v_idx loop
                v_idx2 := trunc(DBMS_RANDOM.value(1, 7));
              end loop;
              v_player2 := subs(v_idx2);
              while v_tries > 0 loop
                ok := 0;
                for i in 1..team_players.count loop
                  if v_player2 = team_players(i) then
                    ok := 1;
                    exit;
                  end if;
                end loop;
                if ok = 1 and subs_time(v_idx2) < v_time then
                  exit;
                end if;
                v_idx2 := trunc(DBMS_RANDOM.value(1, 7));
                v_player2 := subs(v_idx2);
                v_tries := v_tries-1;
              end loop;
              if v_tries = 0 then
                -- nu avem o rezerva potrivita
                insert into GOAL values (id_goal,v_play.ID_MATCH,v_time,v_player,NULL,v_tip);
              else
                -- avem o rezerva potrivita
                insert into GOAL values (id_goal,v_play.ID_MATCH,v_time,v_player,v_player2,v_tip);
              end if;
            else
              -- assistul este un jucator din first 11 neeliminat inca
              v_idx2 := trunc(DBMS_RANDOM.value(1, 23));
              v_player2 := players(v_idx2);
              v_tries := 20;
              while v_tries>0 loop
                ok := 0;
                -- verificam ca suntem in aceeasi echipa
                for i in 1..team_players.count loop
                  if v_player2 = team_players(i) then
                    ok := 1;
                    exit;
                  end if;
                end loop;
                -- verificam sa fie pe teren
                for i in 1..subs_out.COUNT loop
                  if v_idx2 = subs_out(i) and subs_time(i) < v_time then
                    ok := 0;
                    exit;
                  end if;
                end loop;
                if ok = 1 then
                  exit;
                end if;
                v_idx2 := trunc(DBMS_RANDOM.value(1, 23));
                v_player2 := players(v_idx2);
                v_tries := v_tries-1;
              end loop;
              if v_tries = 0 then
                insert into GOAL values (id_goal,v_play.ID_MATCH,v_time,v_player,NULL,v_tip);
              else
                insert into GOAL values (id_goal,v_play.ID_MATCH,v_time,v_player,v_player2,v_tip);
              end if;
            end if;
          end if;
        else
          -- golul este dat de cineva din first11
          v_idx := trunc(DBMS_RANDOM.value(1, 23));
          v_player := players(v_idx);
          while TRUE loop
            ok := 0;
            for i in 1..team_players.count loop
              if v_player  = team_players(i) then
                ok := 1;
                exit;
              end if;
            end loop;
            if ok = 1 then
              exit;
            end if;
            v_idx := trunc(DBMS_RANDOM.value(1, 23));
            v_player := players(v_idx);
          end loop;

          v_time := trunc(DBMS_RANDOM.value(0, 95));
          for i in 1..subs_out.count loop
            if v_player = subs_out(i) then
              v_time := trunc(DBMS_RANDOM.value(0, subs_time(i)));
            end if;
          end loop;
          id_goal := id_goal+1;

          v_rez := trunc(DBMS_RANDOM.value(1, 10));
          if v_rez <= 2 then
            -- assistul este dat de o rezerva
            v_idx2 := trunc(DBMS_RANDOM.value(1, 7));
            v_player2 := players(v_idx2);
            v_tries := 20;
            while v_tries > 0 loop
              ok := 0;
              for i in 1..team_players.count loop
                if team_players(i) = v_player2 then
                  ok := 1;
                  exit;
                end if;
              end loop;
              for i in 1..subs.count loop
                if subs(i) = v_player2 and v_time < subs_time(i) then
                  ok := 0;
                  exit;
                end if;
              end loop;
              if ok = 1 then
                exit;
              end if;
              v_idx2 := trunc(DBMS_RANDOM.value(1, 7));
              v_player2 := players(v_idx2);
              v_tries := v_tries-1;
            end loop;
            if v_tries = 0 then
              insert into GOAL values (id_goal,v_play.ID_MATCH,v_time,v_player,NULL,v_tip);
            else
              insert into GOAL values (id_goal,v_play.ID_MATCH,v_time,v_player,v_player2,v_tip);
            end if;
          else
            -- assistul este dat de cineva din first11
            v_idx2 := trunc(DBMS_RANDOM.value(1, 23));
            v_player2 := players(v_idx2);
            v_tries := 20;
            while v_tries > 0 loop
              ok := 0;
              for i in 1..team_players.count loop
                if team_players(i) = v_player2 then
                  ok := 1;
                  exit;
                end if;
              end loop;
              for i in 1..subs_out.count loop
                if subs_out(i) = v_player2 and subs_time(i) < v_time then
                  ok := 0;
                  exit;
                end if;
              end loop;
              if ok = 1 then
                exit;
              end if;
              v_idx2 := trunc(DBMS_RANDOM.value(1, 7));
              v_player2 := players(v_idx2);
              v_tries := v_tries-1;
            end loop;
            if v_tries = 0 then
              insert into GOAL values (id_goal,v_play.ID_MATCH,v_time,v_player,NULL,v_tip);
            else
              insert into GOAL values (id_goal,v_play.ID_MATCH,v_time,v_player,v_player2,v_tip);
            end if;
          end if;
        end if;
      end loop;
    end;
  end loop;
end;