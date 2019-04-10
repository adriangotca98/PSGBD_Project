create procedure populate_match_and_play as
    type vector is varray (1030) of int;
    previous_round vector := vector();
    this_round vector := vector();
    id_referee int;
    id_match int;
    id_play int;
    v_first int;
    v_second int;
    match_time date;
    counter int;
    attendance int;
    i int;
    j int;
    v_index int;
begin
    this_round.extend(1024);
    previous_round.extend(1024);
    id_match := 1;
    id_play := 1;
    counter := 0;
    v_index := 1;

    --this is for the first visit!!!!!!!!!!!!!!!!!!

    i := 1;
    j := 1024;
    --make the first round
    while (i < j)
        loop
            this_round(v_index) := i;
            this_round(v_index + 1) := j;
            i := i + 1;
            j := j - 1;
            v_index := v_index + 2;
        end loop;
    --this_round(i) plays with this_round(i+1) for every odd i
    for round in 1..1023
        loop
            i := 1;
            --insert in match and play the matches from this round
            while (i <= 1024)
                loop
                    insert_individual_match(id_match, this_round(i));
                    insert into play values (id_play, id_match, this_round(i));
                    insert into play values (id_play + 1, id_match, this_round(i + 1));
                    i := i + 2;
                    id_play := id_play + 2;
                    id_match := id_match + 1;
                end loop;
            --preparing for the next round
            for i in reverse 1024..1
                loop
                    previous_round(i) := this_round(this_round.last);
                    this_round.trim;
                end loop;
            --making the next round, according to https://blog.moove-it.com/algorithm-generation-soccer-fixture/
            if mod(round, 2) = 0 then
                v_first := 1024;
                v_second := previous_round(previous_round.last);
            else
                v_first := previous_round(previous_round.last);
                v_second := 1024;
            end if;
            this_round(1) := v_first;
            this_round(2) := v_second;
            --eliminate 1024 and last element
            previous_round.trim;
            v_index:=1;
            while v_index<=previous_round.last loop
                if previous_round(v_index)=1024 then
                    declare
                        ind int;
                    begin
                        for ind in v_index..previous_round.last-1 loop
                            previous_round(ind):=previous_round(ind+1);
                        end loop;
                        previous_round.trim;
                    end;
                end if;
                v_index:=v_index+1;
            end loop;
            --putting the remaining matches in this round
            v_index := 3;
            while previous_round.count <> 0
                loop
                    this_round(v_index+1):=previous_round(previous_round.last);
                    previous_round.trim;
                    this_round(v_index):=previous_round(previous_round.last);
                    previous_round.trim;
                    v_index:=v_index+2;
                end loop;
        end loop;

    --this is for the second visit!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

    i := 1024;
    j := 1;
    --make the first round
    while (i > j)
        loop
            this_round(v_index) := i;
            this_round(v_index + 1) := j;
            i := i - 1;
            j := j + 1;
            v_index := v_index + 2;
        end loop;
    --this_round(i) plays with this_round(i+1) for every odd i
    for round in 1..1023
        loop
            i := 1;
            --insert in match and play the matches from this round
            while (i <= 1024)
                loop
                    insert_individual_match(id_match, this_round(i));
                    insert into play values (id_play, id_match, this_round(i));
                    insert into play values (id_play + 1, id_match, this_round(i + 1));
                    i := i + 2;
                    id_play := id_play + 2;
                    id_match := id_match + 1;
                end loop;
            --preparing for the next round
            for i in reverse 1024..1
                loop
                    previous_round(i) := this_round(this_round.last);
                    this_round.trim;
                end loop;
            --making the next round, according to https://blog.moove-it.com/algorithm-generation-soccer-fixture/
            if mod(round, 2) = 0 then
                v_first := 1024;
                v_second := previous_round(previous_round.last);
            else
                v_first := previous_round(previous_round.last);
                v_second := 1024;
            end if;
            this_round(1) := v_first;
            this_round(2) := v_second;
            --eliminate 1024 and last element
            previous_round.trim;
            v_index:=1;
            while v_index<=previous_round.last loop
                if previous_round(v_index)=1024 then
                    declare
                        ind int;
                    begin
                        for ind in v_index..previous_round.last-1 loop
                            previous_round(ind):=previous_round(ind+1);
                        end loop;
                        previous_round.trim;
                    end;
                end if;
                v_index:=v_index+1;
            end loop;
            --putting the remaining matches in this round
            v_index := 3;
            while previous_round.count <> 0
                loop
                    this_round(v_index+1):=previous_round(previous_round.last);
                    previous_round.trim;
                    this_round(v_index):=previous_round(previous_round.last);
                    previous_round.trim;
                    v_index:=v_index+2;
                end loop;
        end loop;
end;
/

