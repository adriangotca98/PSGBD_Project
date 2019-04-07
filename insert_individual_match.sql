create procedure insert_individual_match(id_match int, id_team int) as
    type date_vector is varray(10) of date;
    id_referee int;
    attendance int;
    counter int;
    match_times date_vector:=date_vector(to_date('01-01-1950','dd-mm-yyyy')+18/24,
                                         to_date('01-01-1950','dd-mm-yyyy')+21/24,
                                         to_date('02-01-1950','dd-mm-yyyy')+18/24,
                                         to_date('02-01-1950','dd-mm-yyyy')+21/24,
                                         to_date('03-01-1950','dd-mm-yyyy')+18/24,
                                         to_date('03-01-1950','dd-mm-yyyy')+21/24);
    v_index int;
    match_time date;
begin
    --which round is it?
    counter:=0;
    if mod(id_match,512)<>0 then
        counter:=1;
    end if;
    counter:=counter+trunc(id_match/512);
    counter:=counter*7;

    --at what time will the match be played?
    v_index:=trunc(mod(id_match,512)/86)+1;
    match_time:=match_times(v_index)+counter;

    --attendance
    attendance:=dbms_random.value(1,get_maximum_attendance(id_team)+1);

    --referee id
    id_referee:=mod(mod(id_match,512),100);
    if id_referee=0 then
        id_referee:=100;
    end if;

    --the insert
    insert into match values (id_match,id_referee,match_time,attendance);
end;
/

