create or replace procedure get_teams_list as
    type vector is varray(1030) of varchar(100);
    names vector:=vector();
begin
    select name||'||'||ID_TEAM bulk collect into names from team;
    for i in names.first..names.last loop
        DBMS_OUTPUT.put_line(names(i));
    end loop;
end;