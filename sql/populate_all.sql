declare
    type vector is varray (1030) of int;
    previous_round vector := vector();
begin
    --create_table_index();
    --populate_referee();
    --populate_stadium();
    --populate_team();
    --populate_match_and_play();
    --populate_players();
    --populate_first11();
    --POPULATE_SUBSTITUTION();
    --POPULATE_CARDS();
    POPULATE_GOAL();
end;