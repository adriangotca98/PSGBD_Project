SET SERVEROUTPUT ON;
DECLARE
  cursor meci is select * from match;
  v_idx_goal int;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Inserarea a 1000000 goluri...');
  v_idx_goal := 0;
  FOR v_i IN meci LOOP
    declare
      cursor jucatori is select id_player from player where id_team = v_i.id_team1 or id_team = v_i.id_team2;
      v_goals int;
      tot_juc int;
      v_scorer int;
      v_idx int;
    begin
      select count(*) "cnt" into tot_juc from player where id_team = v_i.id_team1 or id_team = v_i.id_team2;
      
      v_goals := TRUNC(DBMS_RANDOM.VALUE(0,5));
      for v_g in 0..v_goals loop
        v_scorer := TRUNC(DBMS_RANDOM.VALUE(0,tot_juc));
        v_idx := 0;
        for v_j in jucatori loop
          if v_idx = v_scorer then
            v_idx_goal :=v_idx_goal+1;
            insert into goal values(v_idx_goal, v_i.id_team1, v_i.match_time, v_j.id_player);
            exit;
          end if;
          v_idx := v_idx+1;
        end loop;
      end loop;
    end;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('Inserarea a avut success');
end;