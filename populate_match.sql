DECLARE
    TYPE varr IS VARRAY (1000) OF VARCHAR2(255);
    CURSOR id1 IS SELECT id_team
                  FROM team;
    CURSOR id2 IS SELECT id_team
                  FROM team;
    id_referee INT;
    match_time DATE;
    counter    INT;
BEGIN
    FOR id_team1 IN id1
        LOOP
            counter := 0;
            FOR id_team2 IN id2
                LOOP
                    IF id_team1.id_team <> id_team2.id_team THEN
                        counter := counter + 7;
                        id_referee := dbms_random.value(1, 100);
                        match_time := TO_DATE('01-01-1990', 'MM-DD-YYYY') + counter +
                                      TRUNC(DBMS_RANDOM.VALUE(0, 23) / 24);
                        INSERT INTO match VALUES (match_time, id_team1.id_team, id_team2.id_team, id_referee, null);
                    END IF;
                END LOOP;
        END LOOP;
END;