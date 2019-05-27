create or replace procedure populate_cards as
  type vector is varray (100) of int;
  cursor c_play is select * from match;
  card_count int;
  id_card int:=0;
begin
  for v_play in c_play loop

    declare
      players vector := vector();
      subs vector := vector();
      subs_time vector := vector();
      subs_out vector := vector();
      v_type int;
      v_sub int;
      v_player int;
      v_time int;
      v_idx int;
    begin
      players.extend(100);
      -- selectez toti jucatorii de pe teren din acest meci
      select id_player bulk collect into players from FIRST11 where id_match=v_play.ID_MATCH;

      -- selectez toti jucatorii de pe teren din acest meci
      select id_player1 bulk collect into subs_out from SUBSTITUTION where id_match=v_play.ID_MATCH;
      select id_player2 bulk collect into subs from SUBSTITUTION where id_match=v_play.ID_MATCH;
      select SUBSTITUTION_TIME bulk collect into subs_time from SUBSTITUTION where id_match=v_play.ID_MATCH;

      card_count := trunc(DBMS_RANDOM.value(1, 11));
      for i in 1..card_count loop
        v_type := trunc(DBMS_RANDOM.value(1, 11));
        if v_type > 1 then
          v_type := 0;
        end if;
        v_sub := trunc(DBMS_RANDOM.value(1, 11));
        if v_sub < 3 then
          v_idx := trunc(DBMS_RANDOM.value(1, 7));
          v_player := subs(v_idx);
          v_time := trunc(DBMS_RANDOM.value(subs_time(v_idx), 95));
          id_card := id_card+1;
          insert into CARDS values (id_card,v_player,v_play.ID_MATCH,v_time);
        else
          v_idx := trunc(DBMS_RANDOM.value(1, 23));
          v_player := players(v_idx);
          v_time := trunc(DBMS_RANDOM.value(0, 95));
          for j in 1..subs_out.count loop
            if subs_out(j) = v_player then
              v_time := trunc(DBMS_RANDOM.value(0, subs_time(j)));
              exit;
            end if;
          end loop;
          id_card := id_card+1;
          insert into CARDS values (id_card,v_player,v_play.ID_MATCH,v_time);
        end if;
      end loop;
    end;
  end loop;
end;