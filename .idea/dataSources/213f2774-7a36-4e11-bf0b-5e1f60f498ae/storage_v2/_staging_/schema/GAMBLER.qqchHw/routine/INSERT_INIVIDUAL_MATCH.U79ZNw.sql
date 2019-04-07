create procedure insert_individual_match(id_match int, id_team int) as
    TYPE date_vector IS VARRAY(10) OF DATE;
    id_referee int;
    attendance int;
    counter int;
    match_times date_vector:=DATE_VECTOR(TO_DATE('01-01-1950','DD-MM-YYYY')+18/24,
                                         TO_DATE('01-01-1950','DD-MM-YYYY')+21/24,
                                         TO_DATE('02-01-1950','DD-MM-YYYY')+18/24,
                                         TO_DATE('02-01-1950','DD-MM-YYYY')+21/24,
                                         TO_DATE('03-01-1950','DD-MM-YYYY')+18/24,
                                         TO_DATE('03-01-1950','DD-MM-YYYY')+21/24);
    v_index int;
    match_time date;
begin
    --which round is it?
    counter:=0;
    if MOD(id_match,512)<>0 then
        counter:=1;
    end if;
    counter:=counter+trunc(id_match/512);
    counter:=counter*7;

    --at what time will the match be played?
    v_index:=trunc(mod(id_match,512)/86)+1;
    match_time:=match_times(v_index)+counter;

    --attendance
    attendance:=DBMS_RANDOM.VALUE(1,GETMAXIMUMATTENDANCE(id_team)+1);

    --referee ID
    id_referee:=MOD(MOD(id_match,512),100);
    if id_referee=0 then
        id_referee:=100;
    end if;

    --THE INSERT
    insert into match values (id_match,id_referee,match_time,attendance);
end;
/

