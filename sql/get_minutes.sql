create or replace function get_minutes(player_id int) return int as
    type int_vector is varray(2500) of int;
    match_list int_vector:=int_vector();
    team_id int;
    minutes int;
    first_minute int;
    last_minute int;
    substitutions_out int_vector:=int_vector();
    substitutions_in int_vector:=int_vector();
    first11_players int_vector:=int_vector();
begin
    match_list.extend(2490);
    substitutions_in.extend(10);
    substitutions_out.extend(10);
    first11_players.extend(30);
    select id_team into team_id from player where id_player=player_id;
    select id_match bulk collect into match_list from play where id_team=team_id;
    for v_i in match_list.first..match_list.last loop
        first_minute:=0;
        last_minute:=-1;
        select id_player bulk collect into first11_players from first11 where id_match=match_list(v_i);
        for v_j in first11_players.first..first11_players.last loop
            if first11_players(v_j)=player_id then
                first_minute:=0;
            end if;
        end loop;
        select ID_PLAYER1 bulk collect into substitutions_in from substitution where ID_MATCH=match_list(v_i);
        for v_j in substitutions_in.first..substitutions_in.last loop
            if substitutions_in(v_j)=player_id then
                select SUBSTITUTION_TIME into first_minute from SUBSTITUTION where ID_MATCH=match_list(v_i) and id_player1=substitutions_in(v_j);
            end if;
        end loop;
        select ID_PLAYER2 bulk collect into substitutions_out from substitution where ID_MATCH=match_list(v_i);
        for v_j in substitutions_out.first..substitutions_out.last loop
            if substitutions_out(v_j)=player_id then
                select SUBSTITUTION_TIME into last_minute from SUBSTITUTION where ID_MATCH=match_list(v_i) and id_player2=substitutions_out(v_j);
            end if;
        end loop;
        minutes:=minutes+last_minute-first_minute+1;
    end loop;
    return minutes;
end;