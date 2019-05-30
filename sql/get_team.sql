create or replace function get_team(id int) return varchar2 as
    team_name varchar2(100);
    team_id int;
begin
    select id_team into team_id from player where ID_PLAYER=id;
    select name into team_name from team where id_team=team_id;
    return team_name;
end;