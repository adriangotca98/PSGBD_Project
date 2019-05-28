create or replace function get_fantastic(stage int, pos int)
return number is
  type vector is varray (60000) of int;
  type strvector is varray (60000) of varchar(10);
  players vector := vector();
  matches vector := vector();
  replacement vector := vector();
  scorers vector := vector();
  assists vector := vector();
  v_team vector := vector();
  v_cards vector := vector();
  res_id vector := vector();
  res_score vector := vector();
  v_pos strvector := strvector();
  minutes int;
  rating int;
  score1 int;
  score2 int;
  my_team int;
  goals int;
  assist int;
  card int;
  v_score int;
  ok int;
  temp int;
  my_position varchar(10);




  gk_score int:=0;
  cb1_score int:=0;
  cb2_score int:=0;
  lb_score int:=0;
  rb_score int:=0;
  lm_score int:=0;
  rm_score int:=0;
  cm1_score int:=0;
  cm2_score int:=0;
  st1_score int:=0;
  st2_score int:=0;

  gk_id int;
  cb1_id int;
  cb2_id int;
  lb_id int;
  rb_id int;
  lm_id int;
  rm_id int;
  cm1_id int;
  cm2_id int;
  st1_id int;
  st2_id int;
begin
  select id_player bulk collect into players from FIRST11 where (stage-1)*512+1<=ID_MATCH and ID_MATCH<=stage*512;
  select id_match bulk collect into matches from FIRST11 where (stage-1)*512+1<=ID_MATCH and ID_MATCH<=stage*512;

  res_id.extend(60000);
  res_score.extend(60000);

  for i in 1..players.count loop

    select id_team bulk collect into v_team from player where id_player = players(i);
    my_team := v_team(1);
    goals := 0;
    score1 := 0;
    score2 := 0;
    card := 0;
    assist := 0;

    select POSITION bulk collect into v_pos from player where id_player = players(i);
    my_position := v_pos(1);

    -- vedem cate minute a jucat
    select SUBSTITUTION_TIME bulk collect into replacement from SUBSTITUTION where ID_PLAYER1=players(i) and ID_MATCH = matches(i);
    if (replacement.count=0) then
      minutes := 90;
    else
      minutes := replacement(1);
    end if;

    -- vedem ce scor a fost si daca am dat gol ori assist
    select id_player bulk collect into scorers from goal where ID_MATCH = matches(i);
    select ID_PLAYER_ASSIST bulk collect into assists from goal where ID_MATCH = matches(i);

    for j in 1..scorers.count loop
      select id_team bulk collect into v_team from player where id_player = scorers(j);
      if (v_team(1) = my_team) then
        score1 := score1 + 1;
      else
        score2 := score2 + 1;
      end if;
      if (players(i) = scorers(j)) then
        goals := goals+1;
      end if;
      if (players(i) = assists(j)) then
        assist := assist + 1;
      end if;
    end loop;

    -- vedem daca am luat cartonase
    select id_player bulk collect into v_cards from CARDS where ID_MATCH = matches(i);
    for j in 1..v_cards.count loop
      if (players(i) = v_cards(j)) then
        card := card + 1;
      end if;
    end loop;

    v_score := (minutes + goals*50 + (score1-score2)*20 + assist*35 - card*35)/3;
    if (v_score<0) then
      v_score := 0;
    end if;
    if (v_score>100) then
      v_score := 100;
    end if;

    if my_position = 'GK' and gk_score<v_score then
      gk_score := v_score;
      gk_id := players(i);
    end if;

    if (my_position = 'RB' or my_position = 'RWB') and rb_score<v_score then
      rb_score := v_score;
      rb_id := players(i);
    end if;

    if (my_position = 'LB' or my_position = 'LWB') and lb_score<v_score then
      lb_score := v_score;
      lb_id := players(i);
    end if;

    if (my_position = 'CB' and cb1_score<=v_score) then
      cb2_score := cb1_score;
      cb2_id := cb1_id;
      cb1_score := v_score;
      cb1_id := players(i);
    elsif (my_position = 'CB' and cb2_score<v_score) then
        cb2_score := v_score;
        cb2_id := players(i);
    end if;

    if (my_position = 'CM' or my_position = 'CDM') and cm1_score<=v_score then
      cm2_score := cm1_score;
      cm2_id := cm1_id;
      cm1_score := v_score;
      cm1_id := players(i);
    elsif (my_position = 'CM' or my_position = 'CDM') and cm2_score<v_score then
        cm2_score := v_score;
        cm2_id := players(i);
    end if;

    if (my_position = 'LM' or my_position = 'LW') and lm_score<v_score then
      lm_score := v_score;
      lm_id := players(i);
    end if;

    if (my_position = 'RM' or my_position = 'RW') and rm_score<v_score then
      rm_score := v_score;
      rm_id := players(i);
    end if;

    if (my_position = 'ST' or my_position = 'CF') and st1_score<=v_score then
      st2_score := st1_score;
      st2_id := st1_id;
      st1_score := v_score;
      st1_id := players(i);
    elsif (my_position = 'ST' or my_position = 'CF') and st2_score<v_score then
        st2_score := v_score;
        st2_id := players(i);
    end if;
  end loop;


  DBMS_OUTPUT.put_line('Best goalkeeper with a rating of ' || gk_score || ' is : ' || ID_TO_NAME(gk_id));
  DBMS_OUTPUT.put_line('First centre back with a rating of ' || cb1_score || ' is : ' || ID_TO_NAME(cb1_id));
  DBMS_OUTPUT.put_line('Second centre back with a rating of ' || cb2_score || ' is : ' || ID_TO_NAME(cb2_id));
  DBMS_OUTPUT.put_line('Best left back with a rating of ' || lb_score || ' is : ' || ID_TO_NAME(lb_id));
  DBMS_OUTPUT.put_line('Best right back with a rating of ' || rb_score || ' is : ' || ID_TO_NAME(rb_id));
  DBMS_OUTPUT.put_line('First centre midfilder with a rating of ' || cm1_score || ' is : ' || ID_TO_NAME(cm1_id));
  DBMS_OUTPUT.put_line('Second centre midfilder with a rating of ' || cm2_score || ' is : ' || ID_TO_NAME(cm2_id));
  DBMS_OUTPUT.put_line('Best left midfilder with a rating of ' || lm_score || ' is : ' || ID_TO_NAME(lm_id));
  DBMS_OUTPUT.put_line('Best right midfilder with a rating of ' || rm_score || ' is : ' || ID_TO_NAME(rm_id));
  DBMS_OUTPUT.put_line('First striker with a rating of ' || st1_score || ' is : ' || ID_TO_NAME(st1_id));
  DBMS_OUTPUT.put_line('Second striker with a rating of ' || st2_score || ' is : ' || ID_TO_NAME(st2_id));
  return 0;
end;