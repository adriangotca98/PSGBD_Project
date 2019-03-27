SET SERVEROUTPUT ON;
DECLARE
  TYPE varr IS VARRAY(400) OF varchar2(255);
  lista_nume varr := varr('Adams Park','Alexandra Stadium','Almondvale Stadium','Amex Stadium','Anfield','Ashton Gate','B2net Stadium','Balmoor','Bayview Stadium','Bescot Stadium','Bloomfield Road','Bootham Crescent','Borough Briggs','Boundary Park','Bramall Lane','Brisbane Road','Britannia Stadium','Broadfield Stadium','Broadwood Stadium','Brunton Park','Cappielow Park','Cardiff City Stadium','Carrow Road','Celtic Park','Central Park','Cliftonhill','Craven Cottage','Crown Ground','Deepdale','Dens Park','Dumbarton Football Stadium','DW Stadium','East End Park','Easter Road','Edgar Street','Elland Road','Emirates Stadium','Etihad Stadium','Ewood Park','Falkirk Stadium','Field Mill','Fir Park','Firhill','Forthbank Stadium','Fratton Park','Galabank','Gayfield Park','Gigg Lane','Glanford Park','Glebe Park','Globe Arena','Goodison Park','Griffin Park','Hampden Park','Highbury Stadium','Hillsborough','Home Park','Huish Park','Ibrox','Kassam Stadium ','KC Stadium','Keepmoat Stadium','Kenilworth Road','King Power Stadium','Kingsmeadow','Liberty Stadium','Links Park','Loftus Road','London Road','Macron Stadium','Madjeski Stadium','McDiarmid Park','Meadow Lane','Memorial Stadium','Millennium Stadium','Molineux','Moss Rose','New Broomfield','New Douglas Park','New Meadow','New York Stadium','Oakwell','Ochilview Park','Old Trafford','Olympic Stadium','Palmerston Park','Pirelli Stadium','Pittodrie','Plainmoor','Portman Road','Prenton Park','Pride Park','Priestfield Stadium','Recreation Ground','Recreation Park','Ricoh Arena','Riverside','Rodney Parade','Roots Hall','Rugby Park','Selhurst Park','Seward Stadium','Shielfield Park','Sixfields Stadium','Somerset Park','Spotland Stadium','St Andrews','St James Park','St James Park','St Marys Stadium','St Mirren Park','Stadium of Light','Stadiummk','Stair Park','Stamford Bridge','Starks Park','Station Park','Tannadice Park','The Caledonian Stadium','The City Ground','The County Ground','The Den','The Galpharm Stadium','The Hawthorns','The Hive Stadium','The Lamex Stadium','The Valley','Turf Moor','Tynecastle','Vale Park','Valley Parade','Vicarage Road','Victoria Park','Victoria Park','Victoria Road','Villa Park','Wembley','Weston Homes Community Stadium','Whaddon Road','White Hart Lane');  
  lista_orase varr := varr('Fort Hunt','Bessemer','Paducah','Birmingham','Center Point','Daphne','Decatur','Dothan','East Florence','Enterprise','Fairhope','Florence','Gadsden','Helena','Homewood','Hoover','Hueytown','Huntsville','Madison','Mobile','Montgomery','Mountain Brook','Northport','Opelika','Oxford','Pelham','Phenix City','Prattville','Prichard','Selma','Talladega','Tillmans Corner','Troy','Trussville','Tuscaloosa','Vestavia Hills','Bella Vista','Benton','Bentonville','Blytheville','Bryant','Cabot','Conway','El Dorado','Fayetteville','Forrest City','Fort Smith','Hot Springs','Jacksonville','Jonesboro','Little Rock','Maumelle','North Little Rock','Paragould','Pine Bluff','Rogers','Russellville','Searcy','Siloam Springs','Springdale','Texarkana','Van Buren','West Memphis','"Washington','Bear','Dover','Middletown','Newark');
  v_nume VARCHAR2(255);    
  v_city VARCHAR2(255); 
  v_capacity INT;
  v_founding_date date;

BEGIN
  DBMS_OUTPUT.PUT_LINE('Inserarea a 100 stadioane...');
  FOR v_i IN 1..100 LOOP
    v_nume := lista_nume(TRUNC(DBMS_RANDOM.VALUE(0,lista_nume.count))+1);
    v_city := lista_orase(TRUNC(DBMS_RANDOM.VALUE(0,lista_orase.count))+1);
    v_founding_date := TO_DATE('01-01-1900','MM-DD-YYYY')+TRUNC(DBMS_RANDOM.VALUE(0,36500));
    v_capacity := TRUNC(DBMS_RANDOM.VALUE(1000,100000))+1;
    DBMS_OUTPUT.PUT_LINE(v_nume|| ' ' || v_city || ' ' || v_founding_date || ' ' || v_capacity);
    insert into stadium values(v_i, v_nume, v_city, v_founding_date, v_capacity);
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('Inserarea a avut success');
end;