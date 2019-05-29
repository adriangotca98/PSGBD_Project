create or replace function get_match_info(id int)
return number is
  type vector is varray (60000) of int;
  type strvector is varray (60000) of varchar(50);
  teams vector := vector();
  times vector := vector();
  players vector := vector();
  subs1 vector := vector();
  subs2 vector := vector();
  goal_players vector := vector();
  players_assist vector := vector();
  card_times vector := vector();
  sub_time vector := vector();
  goal_time vector := vector();
  names strvector := strvector();
  goal_type strvector := strvector();
  v_date varchar(30);
  stad_name varchar(30);
  ref_name varchar(30);
  v_player varchar(30);
  sub1 varchar(30);
  sub2 varchar(30);
  v_assist varchar(30);
  v_team int;
  half1 int;
  ful1 int;
  half2 int;
  ful2 int;
  hteam int;
  ateam int;
  v_stad int;
  v_att int;
  v_ref int;
  v_id_team int;
  c1 int;
  c2 int;
begin
  select ID_TEAM bulk collect into teams from play where id_match = id;
  for i in 1..teams.COUNT loop
    select name bulk collect into names from team where id_team = teams(i);
    DBMS_OUTPUT.put_line(names(1));
  end loop;
  select to_char(match_time, 'hh:mm dd-mm-yyyy') into v_date from match where id_match = id;
  DBMS_OUTPUT.put_line(v_date);
  hteam := teams(1);
  ateam := teams(2);

  half1 := 0;
  ful1 := 0;
  half2 := 0;
  ful2 := 0;
  select goal_time bulk collect into times from goal where id_match = id;
  select ID_PLAYER bulk collect into goal_players from goal where id_match = id;
  select type bulk collect into goal_type from goal where id_match = id;
  for i in 1.. times.count loop
    select id_team into v_team from player where id_player = goal_players(i);
    if goal_type(i) like 'Autogoal' then
      if times(i)<=45 then
        if v_team = ateam then
          half1 := half1+1;
        else
          half2 := half2+1;
        end if;
      end if;
      if v_team = ateam then
        ful1 := ful1+1;
      else
        ful2 := ful2+1;
      end if;
    else
        if times(i)<=45 then
          if v_team = hteam then
            half1 := half1+1;
          else
            half2 := half2+1;
          end if;
        end if;
        if v_team = hteam then
          ful1 := ful1+1;
        else
          ful2 := ful2+1;
        end if;
    end if;
  end loop;
  DBMS_OUTPUT.put_line(half1 || '-' || half2);
  DBMS_OUTPUT.put_line(ful1 || '-' || ful2);

  select id_stadium into v_stad from team where id_team = hteam;
  select name into stad_name from stadium where ID_STADIUM = v_stad;
  DBMS_OUTPUT.put_line(stad_name);

  select ATTENDANCE into v_att from match where ID_MATCH = id;
  DBMS_OUTPUT.put_line(v_att);

  select id_referee into v_ref from match where id_match = hteam;
  select FIRST_NAME || ' ' || LAST_NAME into ref_name from REFEREE where ID_REFEREE = v_ref;
  DBMS_OUTPUT.put_line(ref_name);

  select ID_PLAYER bulk collect into players from first11 where ID_MATCH = id;
  for i in 1..players.count loop
    select id_team into v_id_team from player where id_player = players(i);
    if v_id_team = hteam then
      select FIRST_NAME || ' ' || LAST_NAME || ' (' || POSITION || ')' into v_player from player where id_player = players(i);
      DBMS_OUTPUT.put_line(v_player);
    end if;
  end loop;

  for i in 1..players.count loop
    select id_team into v_id_team from player where id_player = players(i);
    if v_id_team = ateam then
      select FIRST_NAME || ' ' || LAST_NAME || ' (' || POSITION || ')' into v_player from player where id_player = players(i);
      DBMS_OUTPUT.put_line(v_player);
    end if;
  end loop;

  select id_player1 bulk collect into subs1 from SUBSTITUTION where ID_MATCH=id order by SUBSTITUTION_TIME;
  select id_player2 bulk collect into subs2 from SUBSTITUTION where ID_MATCH=id order by SUBSTITUTION_TIME;
  select SUBSTITUTION_TIME bulk collect into sub_time from SUBSTITUTION where ID_MATCH=id order by SUBSTITUTION_TIME;
  for i in 1.. subs1.count loop
    select id_team into v_id_team from player where id_player = subs1(i);
    if v_id_team = hteam then
      select FIRST_NAME || ' ' || LAST_NAME || ' (' || POSITION || ')' into sub1 from player where id_player = subs1(i);
      select FIRST_NAME || ' ' || LAST_NAME || ' (' || POSITION || ')' into sub2 from player where id_player = subs2(i);
      DBMS_OUTPUT.put_line(sub_time(i) || ''' ' || sub1 || ' -> ' || sub2);
    end if;
  end loop;
  for i in 1.. subs1.count loop
    select id_team into v_id_team from player where id_player = subs1(i);
    if v_id_team = ateam then
      select FIRST_NAME || ' ' || LAST_NAME || ' (' || POSITION || ')' into sub1 from player where id_player = subs1(i);
      select FIRST_NAME || ' ' || LAST_NAME || ' (' || POSITION || ')' into sub2 from player where id_player = subs2(i);
      DBMS_OUTPUT.put_line(sub_time(i) || ''' ' || sub1 || ' -> ' || sub2);
    end if;
  end loop;

  DBMS_OUTPUT.put_line(ful1);
  DBMS_OUTPUT.put_line(ful2);
  select id_player bulk collect into players from goal where ID_MATCH=id order by goal_time;
  select goal_time bulk collect into goal_time from goal where ID_MATCH=id order by goal_time;
  select ID_PLAYER_ASSIST bulk collect into players_assist from goal where ID_MATCH=id order by goal_time;
  select type bulk collect into goal_type from goal where ID_MATCH=id order by goal_time;
  for i in 1.. players.count loop
    select id_team into v_id_team from player where id_player = players(i);
    if (v_id_team = hteam and goal_type(i) not like 'Autogoal') or (v_id_team = ateam and goal_type(i) like 'Autogoal') then
      select FIRST_NAME || ' ' || LAST_NAME || ' (' || POSITION || ')' into v_player from player where id_player = players(i);
      if (players_assist(i) is null or goal_type(i) like 'Autogoal') then
        DBMS_OUTPUT.put_line(goal_time(i) || ''' ' || v_player || ' - ' || goal_type(i));
      else
        select FIRST_NAME || ' ' || LAST_NAME || ' (' || POSITION || ')' into v_assist from player where id_player = players_assist(i);
        DBMS_OUTPUT.put_line(goal_time(i) || ''' ' || v_player || ' - ' || goal_type(i) || ' assisted by ' || v_assist);
      end if;
    end if;
  end loop;
  for i in 1.. players.count loop
    select id_team into v_id_team from player where id_player = players(i);
    if (v_id_team = ateam and goal_type(i) not like 'Autogoal') or (v_id_team = hteam and goal_type(i) like 'Autogoal') then
      select FIRST_NAME || ' ' || LAST_NAME || ' (' || POSITION || ')' into v_player from player where id_player = players(i);
      if (players_assist(i) is null or goal_type(i) like 'Autogoal') then
        DBMS_OUTPUT.put_line(goal_time(i) || ''' ' || v_player || ' - ' || goal_type(i));
      else
        select FIRST_NAME || ' ' || LAST_NAME || ' (' || POSITION || ')' into v_assist from player where id_player = players_assist(i);
        DBMS_OUTPUT.put_line(goal_time(i) || ''' ' || v_player || ' - ' || goal_type(i) || ' assisted by ' || v_assist);
      end if;
    end if;
  end loop;



  c1:=0;
  c2:=0;
  select id_player bulk collect into players from cards where ID_MATCH=id order by card_time;
  select card_time bulk collect into card_times from cards where ID_MATCH=id order by card_time;
  for i in 1.. players.count loop
    select id_team into v_id_team from player where id_player = players(i);
    if v_id_team = hteam then
      c1 := c1+1;
    end if;
  end loop;
  for i in 1.. players.count loop
    select id_team into v_id_team from player where id_player = players(i);
    if v_id_team = ateam then
      c2 := c2+1;
    end if;
  end loop;
  DBMS_OUTPUT.put_line(c1);
  DBMS_OUTPUT.put_line(c2);


  select id_player bulk collect into players from cards where ID_MATCH=id order by card_time;
  select card_time bulk collect into card_times from cards where ID_MATCH=id order by card_time;
  for i in 1.. players.count loop
    select id_team into v_id_team from player where id_player = players(i);
    if v_id_team = hteam then
      select FIRST_NAME || ' ' || LAST_NAME || ' (' || POSITION || ')' into v_player from player where id_player = players(i);
      DBMS_OUTPUT.put_line(card_times(i) || ''' ' || v_player);
      c1 := c1+1;
    end if;
  end loop;
  for i in 1.. players.count loop
    select id_team into v_id_team from player where id_player = players(i);
    if v_id_team = ateam then
      select FIRST_NAME || ' ' || LAST_NAME || ' (' || POSITION || ')' into v_player from player where id_player = players(i);
      DBMS_OUTPUT.put_line(card_times(i) || ''' ' || v_player);
      c2 := c2+1;
    end if;
  end loop;
  return teams.count;
end;