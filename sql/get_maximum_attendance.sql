create or replace function get_maximum_attendance(id_echipa int)
return int as
    id_stadion int;
    capacitate int;
    c int;
begin
    select id_stadium into id_stadion from team where id_echipa=id_team;
    select capacity into capacitate from stadium where id_stadium=id_stadion;
    return capacitate;
end;
