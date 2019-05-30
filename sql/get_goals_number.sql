create or replace function get_goals_number(player_id int) return int as
    goals int;
begin
    select count(*) into goals from goal where id_player=player_id;
    return goals;
end;