create or replace function get_assists_number(player_id int) return int as
    goals int;
begin
    select count(*) into goals from goal where id_player_assist=player_id;
    return goals;
end;