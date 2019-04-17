create or replace procedure populate_players as
    TYPE varr IS VARRAY (205) OF VARCHAR2(255);
    lista_prenume varr := varr('Adam', 'Keith', 'Edward', 'Jason', 'Alan', 'Dylan', 'Max', 'Peter', 'Colin', 'Ryan',
                               'Warren', 'Joe', 'Edward', 'Nicholas', 'Ryan', 'Robert', 'Sam', 'Simon', 'Simon', 'Liam',
                               'Neil', 'David', 'Frank', 'Victor', 'Kevin', 'Colin', 'Joshua', 'Max', 'Julian',
                               'Austin', 'Frank', 'Nathan', 'Jacob', 'Liam', 'Oliver', 'Nicholas', 'Jake', 'Julian',
                               'Dan', 'Matt', 'Liam', 'Andrew', 'Jonathan', 'Anthony', 'David', 'Dominic', 'Nicholas',
                               'Piers', 'Kevin', 'Richard', 'Brandon', 'Edward', 'Anthony', 'Cameron', 'Matt', 'Eric',
                               'Anthony', 'Gavin', 'Carl', 'Colin', 'Connor', 'Eric', 'Christopher', 'Matt', 'Andrew',
                               'James', 'Harry', 'Steven', 'Gavin', 'Brandon', 'Ryan', 'Jonathan', 'Peter', 'Brandon',
                               'Robert', 'Max', 'David', 'Connor', 'Brian', 'Richard', 'Matt', 'Luke', 'Owen', 'Andrew',
                               'Andrew', 'Jonathan', 'Anthony', 'Paul', 'Jake', 'James', 'Nicholas', 'Stewart',
                               'Benjamin', 'Phil', 'Phil', 'Brandon', 'Gavin', 'John', 'Dylan', 'Warren', 'Edward',
                               'Max', 'Kevin', 'Stewart', 'Frank', 'Brandon', 'Jonathan', 'Julian', 'Sam', 'Ian',
                               'Blake', 'Dylan', 'Matt', 'Thomas', 'Brandon', 'Steven', 'Justin', 'Sebastian', 'Julian',
                               'Victor', 'Richard', 'Ian', 'Warren', 'Harry', 'Kevin', 'David', 'Evan', 'Steven',
                               'Justin', 'Evan', 'Boris', 'Leonard', 'Edward', 'William', 'Brian', 'Gavin', 'Steven',
                               'Paul', 'Sebastian', 'Ian', 'Frank', 'Neil', 'Trevor', 'Peter', 'Benjamin', 'Victor',
                               'Phil', 'Sean', 'Keith', 'Dylan', 'Thomas', 'Sebastian', 'Matt', 'John', 'Nathan',
                               'Frank', 'Brandon', 'Tim', 'Joseph', 'Luke', 'Edward', 'Boris', 'Luke', 'Jake', 'Ian',
                               'Andrew', 'Jacob', 'Dylan', 'Austin', 'Stephen', 'Victor', 'Adrian', 'William', 'Edward',
                               'Keith', 'Edward', 'Christopher', 'Austin', 'Connor', 'Cameron', 'Richard', 'Kevin',
                               'Cameron', 'Isaac', 'Colin', 'Connor', 'David', 'Christopher', 'Tim', 'Andrew', 'Luke',
                               'Justin', 'Brandon', 'Benjamin', 'Phil', 'Robert', 'Brandon', 'Michael', 'William',
                               'Boris');
    lista_nume varr := varr('Taylor', 'Chapman', 'Lambert', 'King', 'Peters', 'Bond', 'Ellison', 'Roberts', 'Lewis',
                            'Lambert', 'Butler', 'Jones', 'Rutherford', 'Mitchell', 'Black', 'Clarkson', 'Nolan',
                            'Hill', 'Powell', 'May', 'Sutherland', 'Mills', 'Short', 'Hudson', 'Reid', 'Parsons',
                            'Roberts', 'Dyer', 'Lewis', 'Alsop', 'Bower', 'Vaughan', 'McDonald', 'Mackay', 'Wright',
                            'Bond', 'Jones', 'Blake', 'Rees', 'Metcalfe', 'Vance', 'Clarkson', 'Howard', 'Avery',
                            'Rees', 'Ferguson', 'Underwood', 'Hill', 'Bailey', 'Forsyth', 'Chapman', 'Dowd',
                            'Roberts', 'Dowd', 'Wallace', 'Marshall', 'Hemmings', 'Mills', 'Scott', 'Alsop',
                            'Arnold', 'Walker', 'Kerr', 'Murray', 'MacDonald', 'Fraser', 'Buckland', 'Blake',
                            'Hardacre', 'Newman', 'Gill', 'Hunter', 'Kerr', 'Mitchell', 'Anderson', 'Greene',
                            'Peake', 'Randall', 'McGrath', 'Stewart', 'Hart', 'Cornish', 'Ross', 'Smith', 'Lawrence',
                            'Abraham', 'Parsons', 'Hamilton', 'Murray', 'Slater', 'Thomson', 'Bond', 'Cornish',
                            'Duncan', 'Forsyth', 'Welch', 'Paige', 'Blake', 'Parsons', 'Nolan', 'Wright', 'Baker',
                            'Langdon', 'Graham', 'Wright', 'Hart', 'Mackay', 'Taylor', 'Hudson', 'Graham', 'Walsh',
                            'Roberts', 'Hudson', 'Thomson', 'Poole', 'Duncan', 'Edmunds', 'Grant', 'Wright', 'Smith',
                            'Parsons', 'Fisher', 'Piper', 'Dickens', 'Mackay', 'Paterson', 'Bower', 'Davidson',
                            'Wilkins', 'Carr', 'Cameron', 'Nash', 'Ince', 'Hardacre', 'Baker', 'Piper', 'Miller',
                            'May', 'Springer', 'Mathis', 'Howard', 'Hamilton', 'Smith', 'Morgan', 'Brown', 'Powell',
                            'Bell', 'Fraser', 'Campbell', 'Avery', 'Russell', 'Glover', 'Hill', 'Carr', 'Butler',
                            'Harris', 'Ogden', 'Bond', 'Hudson', 'Kelly', 'Jones', 'May', 'Parsons', 'Martin',
                            'Burgess', 'Hemmings', 'Hughes', 'White', 'North', 'Vaughan', 'Newman', 'Walsh',
                            'Wright', 'Turner', 'Short', 'Black', 'Mitchell', 'Manning', 'Campbell', 'Smith',
                            'Wilkins', 'Churchill', 'Wilson', 'Coleman', 'Burgess', 'Sharp', 'McLean', 'Scott',
                            'Bailey', 'Paterson', 'Hill', 'Wallace', 'May', 'Miller', 'Nash', 'Hughes', 'Howard',
                            'Pullman', 'Gray', 'Jones');
    lista_pozitii varr := varr('GK', 'GK', 'RB', 'RB', 'LB', 'LB', 'RWB', 'RWB', 'LWB', 'LWB', 'RM', 'RM', 'LM', 'LM',
                               'RW', 'RW', 'LW', 'LW', 'CF', 'CF', 'CAM', 'CAM', 'CM', 'CM', 'CDM', 'CDM', 'CB', 'CB',
                               'CB', 'CB');
    lista_tari varr := varr('Afghanistan', 'Albania', 'Algeria', 'Andorra', 'Angola', 'Antigua and Barbuda',
                            'Argentina', 'Armenia', 'Australia', 'Austria', 'Azerbaijan', 'Bahamas', 'Bahrain',
                            'Bangladesh', 'Barbados', 'Belarus', 'Belgium', 'Belize', 'Benin', 'Bhutan', 'Bolivia',
                            'Bosnia and Herzegovina', 'Botswana', 'Brazil', 'Brunei', 'Bulgaria', 'Burkina Faso',
                            'Burundi', 'C�te d`Ivoire', 'Cabo Verde', 'Cambodia', 'Cameroon', 'Canada',
                            'Central African Republic', 'Chad', 'Chile', 'China', 'Colombia', 'Comoros', 'Congo',
                            'Costa Rica', 'Croatia', 'Cuba', 'Cyprus', 'Czech Republic',
                            'Democratic Republic of the Congo', 'Denmark', 'Djibouti', 'Dominica',
                            'Dominican Republic', 'Ecuador', 'Egypt', 'El Salvador', 'Equatorial Guinea', 'Eritrea',
                            'Estonia', 'Ethiopia', 'Fiji', 'Finland', 'France', 'Gabon', 'Gambia', 'Georgia',
                            'Germany', 'Ghana', 'Greece', 'Grenada', 'Guatemala', 'Guinea', 'Guinea-Bissau',
                            'Guyana', 'Haiti', 'Holy See', 'Honduras', 'Hungary', 'Iceland', 'India', 'Indonesia',
                            'Iran', 'Iraq', 'Ireland', 'Israel', 'Italy', 'Jamaica', 'Japan', 'Jordan', 'Kazakhstan',
                            'Kenya', 'Kiribati', 'Kuwait', 'Kyrgyzstan', 'Laos', 'Latvia', 'Lebanon', 'Lesotho',
                            'Liberia', 'Libya', 'Liechtenstein', 'Lithuania', 'Luxembourg', 'Macedonia',
                            'Madagascar', 'Malawi', 'Malaysia', 'Maldives', 'Mali', 'Malta', 'Marshall Islands',
                            'Mauritania', 'Mauritius', 'Mexico', 'Micronesia', 'Moldova', 'Monaco', 'Mongolia',
                            'Montenegro', 'Morocco', 'Mozambique', 'Myanmar', 'Namibia', 'Nauru', 'Nepal',
                            'Netherlands', 'New Zealand', 'Nicaragua', 'Niger', 'Nigeria', 'North Korea', 'Norway',
                            'Oman', 'Pakistan', 'Palau', 'Palestine State', 'Panama', 'Papua New Guinea', 'Paraguay',
                            'Peru', 'Philippines', 'Poland', 'Portugal', 'Qatar', 'Romania', 'Russia', 'Rwanda',
                            'Saint Kitts and Nevis', 'Saint Lucia', 'Saint Vincent and the Grenadines', 'Samoa',
                            'San Marino', 'Sao Tome and Principe', 'Saudi Arabia', 'Senegal', 'Serbia', 'Seychelles',
                            'Sierra Leone', 'Singapore', 'Slovakia', 'Slovenia', 'Solomon Islands', 'Somalia',
                            'South Africa', 'South Korea', 'South Sudan', 'Spain', 'Sri Lanka', 'Sudan', 'Suriname',
                            'Swaziland', 'Sweden', 'Switzerland', 'Syria', 'Tajikistan', 'Tanzania', 'Thailand',
                            'Timor-Leste', 'Togo', 'Tonga', 'Trinidad and Tobago', 'Tunisia', 'Turkey',
                            'Turkmenistan', 'Tuvalu', 'Uganda', 'Ukraine', 'United Arab Emirates', 'United Kingdom',
                            'United States of America', 'Uruguay', 'Uzbekistan', 'Vanuatu', 'Venezuela', 'Viet Nam',
                            'Yemen', 'Zambia', 'Zimbabwe');
    ind INT;
    id_tara INT;
    nume player.first_name%TYPE;
    prenume player.last_name%TYPE;
    pozitie player.position%TYPE;
    id_team player.id_team%TYPE;
    id_player player.id_player%TYPE;
    data_nastere player.date_of_birth%TYPE;
    nationalitate player.nationality%TYPE;
    valoare player.value%type;
begin
    ind := 1;
    FOR i IN 1..1024
        LOOP
            FOR j IN 1..30
                LOOP
                    nume := lista_nume(trunc(DBMS_RANDOM.VALUE(1, 201)));
                    prenume := lista_prenume(trunc(DBMS_RANDOM.VALUE(1, 201)));
                    pozitie := lista_pozitii(j);
                    id_team := i;
                    id_player := ind;
                    data_nastere := to_date('01-01-1970', 'DD-MM-YYYY') + TRUNC(DBMS_RANDOM.VALUE(0, 14600));
                    id_tara := TRUNC(DBMS_RANDOM.VALUE(1, 195));
                    valoare := trunc(DBMS_RANDOM.VALUE(100000, 500000000));
                    nationalitate := lista_tari(id_tara);
                    INSERT INTO player
                    VALUES (id_player, id_team, nume, prenume, nationalitate, data_nastere, pozitie, valoare);
                    ind := ind + 1;
                END LOOP;
        END LOOP;
    FOR i IN 1..1024
        LOOP
            FOR j IN 1..10
                LOOP
                    nume := lista_nume(trunc(DBMS_RANDOM.VALUE(1, 201)));
                    prenume := lista_prenume(trunc(DBMS_RANDOM.VALUE(1, 201)));
                    id_team := i;
                    pozitie := lista_pozitii(TRUNC(DBMS_RANDOM.VALUE(1, 30)));
                    id_player := ind;
                    data_nastere := to_date('01-01-1970', 'DD-MM-YYYY') + TRUNC(DBMS_RANDOM.VALUE(0, 14600));
                    id_tara := TRUNC(DBMS_RANDOM.VALUE(1, 195));
                    nationalitate := lista_tari(id_tara);
                    valoare := trunc(DBMS_RANDOM.VALUE(100000, 500000000));
                    INSERT INTO player
                    VALUES (id_player, id_team, nume, prenume, nationalitate, data_nastere, pozitie, valoare);
                    ind := ind + 1;
                END LOOP;
        END LOOP;
END;

