SET SERVEROUTPUT ON;
DECLARE
    TYPE varr IS VARRAY (1000) OF VARCHAR2(255);
    lista_nume    varr := varr('Oliver', 'Jack', 'Harry', 'Jacob', 'Charlie', 'Thomas', 'George', 'Oscar', 'James',
                               'William', 'Noah', 'Alfie', 'Joshua', 'Muhammad', 'Henry', 'Leo', 'Archie', 'Ethan',
                               'Joseph', 'Freddie', 'Samuel', 'Alexander', 'Logan', 'Daniel', 'Isaac', 'Max',
                               'Mohammed', 'Benjamin', 'Mason', 'Lucas', 'Edward', 'Harrison', 'Jake', 'Dylan', 'Riley',
                               'Finley', 'Theo', 'Sebastian', 'Adam', 'Zachary', 'Arthur', 'Toby', 'Jayden', 'Luke',
                               'Harley', 'Lewis', 'Tyler', 'Harvey', 'Matthew', 'David', 'Reuben', 'Michael', 'Elijah',
                               'Kian', 'Tommy', 'Mohammad', 'Blake', 'Luca', 'Theodore', 'Stanley', 'Jenson', 'Nathan',
                               'Charles', 'Frankie', 'Jude', 'Teddy', 'Louie', 'Louis', 'Ryan', 'Hugo', 'Bobby',
                               'Elliott', 'Dexter', 'Ollie', 'Alex', 'Liam', 'Kai', 'Gabriel', 'Connor', 'Aaron',
                               'Frederick', 'Callum', 'Elliot', 'Albert', 'Leon', 'Ronnie', 'Rory', 'Jamie', 'Austin',
                               'Seth', 'Ibrahim', 'Owen', 'Caleb', 'Ellis', 'Sonny', 'Robert', 'Joey', 'Felix',
                               'Finlay', 'Jackson');
    lista_prenume varr := varr('Smith', 'Johnson', 'Williams', 'Jones', 'Brown', 'Davis', 'Miller', 'Wilson', 'Moore',
                               'Taylor', 'Anderson', 'Thomas', 'Jackson', 'White', 'Harris', 'Martin', 'Thompson',
                               'Garcia', 'Martinez', 'Robinson', 'Clark', 'Rodriguez', 'Lewis', 'Lee', 'Walker', 'Hall',
                               'Allen', 'Young', 'Hernandez', 'King', 'Wright', 'Lopez', 'Hill', 'Scott', 'Green',
                               'Adams', 'Baker', 'Gonzalez', 'Nelson', 'Carter', 'Mitchell', 'Perez', 'Roberts',
                               'Turner', 'Phillips', 'Campbell', 'Parker', 'Evans', 'Edwards', 'Collins', 'Stewart',
                               'Sanchez', 'Morris', 'Rogers', 'Reed', 'Cook', 'Morgan', 'Bell', 'Murphy', 'Bailey',
                               'Rivera', 'Cooper', 'Richardson', 'Cox', 'Howard', 'Ward', 'Torres', 'Peterson', 'Gray',
                               'Ramirez', 'James', 'Watson', 'Brooks', 'Kelly', 'Sanders', 'Price', 'Bennett', 'Wood',
                               'Barnes', 'Ross', 'Henderson', 'Coleman', 'Jenkins', 'Perry', 'Powell', 'Long',
                               'Patterson', 'Hughes', 'Flores', 'Washington', 'Butler', 'Simmons', 'Foster', 'Gonzales',
                               'Bryant', 'Alexander', 'Russell', 'Griffin', 'Diaz', 'Hayes');
    v_nume        VARCHAR2(255);
    v_prenume     VARCHAR2(255);
BEGIN
    FOR i IN 1..100
        LOOP
            v_nume := lista_nume(i);
            v_prenume := lista_prenume(i);
            INSERT INTO referee VALUES (i, v_nume, v_prenume);
        END LOOP;
END;