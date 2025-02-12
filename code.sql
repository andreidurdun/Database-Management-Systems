--Exercitiul 4

CREATE SEQUENCE CONTRACTE_SEQ START WITH 1;
CREATE SEQUENCE CONTABILI_SEQ START WITH 1;
CREATE SEQUENCE PLATI_SEQ START WITH 1;
CREATE SEQUENCE CLIENTI_SEQ START WITH 1;
CREATE SEQUENCE PACHETE_TURISTIC_SEQ START WITH 1;
CREATE SEQUENCE CAZARI_SEQ START WITH 1;
CREATE SEQUENCE TRANSPORTURI_SEQ START WITH 1;
CREATE SEQUENCE PLECARI_SEQ START WITH 1;
CREATE SEQUENCE DESTINATII_SEQ START WITH 1;
CREATE SEQUENCE ATRACTII_TURISTICE_SEQ START WITH 1;
CREATE SEQUENCE GHIZI_SEQ START WITH 1;
CREATE SEQUENCE RECENZII_SEQ START WITH 1;
CREATE SEQUENCE PROGRAME_LOIALITATE_SEQ START WITH 1;


CREATE TABLE PROGRAME_LOIALITATE (
    Id_Program NUMBER(5) DEFAULT PROGRAME_LOIALITATE_SEQ.NEXTVAL PRIMARY KEY,
    Id_Client NUMBER(5) NOT NULL, 
    Puncte_Loialitate NUMBER(5),
    FOREIGN KEY (Id_Client) REFERENCES CLIENTI(Id_Client)
);

CREATE TABLE CLIENTI (
    Id_Client NUMBER(5) DEFAULT CLIENTI_SEQ.NEXTVAL PRIMARY KEY,
    --Id_Program NUMBER(5),
    Nume VARCHAR2(50),
    Data_Nasterii DATE,
    CNP VARCHAR2(13),
    Adresa VARCHAR2(100),
    Telefon VARCHAR2(15),
    Email VARCHAR2(50)
    --FOREIGN KEY (Id_Program) REFERENCES PROGRAME_LOIALITATE(Id_Program)
);

-- ALTER TABLE CLIENTI 
-- DROP COLUMN Id_Program;

-- ALTER TABLE CLIENTI
-- DROP CONSTRAINT SYS_C008513;

-- ALTER TABLE PROGRAME_LOIALITATE
-- ADD Id_Client NUMBER(5);

-- ALTER TABLE PROGRAME_LOIALITATE
-- ADD CONSTRAINT FK_Program_Client FOREIGN KEY (Id_Client) REFERENCES CLIENTI(Id_Client);


CREATE TABLE TRANSPORTURI (
    Id_Transport NUMBER(5) DEFAULT TRANSPORTURI_SEQ.NEXTVAL PRIMARY KEY,
    Tip_Vehicul VARCHAR2(20),
    Numar_Locuri NUMBER(3),
    Pret NUMBER(6,2),
    Operator VARCHAR2(50),
    Disponibil CHAR(1) CHECK (Disponibil IN ('Y', 'N'))
);

CREATE TABLE PLECARI (
    Id_Plecare NUMBER(5) DEFAULT PLECARI_SEQ.NEXTVAL PRIMARY KEY,
    Oras VARCHAR2(50),
    Adresa VARCHAR2(100),
    Ora_Plecare DATE
);

CREATE TABLE DESTINATII (
    Id_Destinatie NUMBER(5) DEFAULT DESTINATII_SEQ.NEXTVAL PRIMARY KEY,
    Tara VARCHAR2(50),
    Oras VARCHAR2(50),
    Descriere VARCHAR2(200)
);

CREATE TABLE CAZARI (
    Id_Cazare NUMBER(5) DEFAULT CAZARI_SEQ.NEXTVAL PRIMARY KEY,
    Id_Destinatie NUMBER(5) NOT NULL,
    Tip_Cazare VARCHAR2(50),
    Numar_Locuri NUMBER(5),
    Pret NUMBER(6,2),
    Nume VARCHAR2(50),
    Adresa VARCHAR2(100),
    Stele NUMBER(1),
    Facilitati VARCHAR2(200),
    FOREIGN KEY (Id_Destinatie) REFERENCES DESTINATII(Id_Destinatie)
);

CREATE TABLE GHIZI (
    Id_Ghid NUMBER(5) DEFAULT GHIZI_SEQ.NEXTVAL PRIMARY KEY,
    Nume VARCHAR2(50),
    Data_Nasterii DATE,
    CNP VARCHAR2(13),
    Telefon VARCHAR2(15),
    Email VARCHAR2(50),
    Tarif NUMBER(6,2),
    Limbi_Straine VARCHAR2(100),
    Experienta NUMBER(2)
);

CREATE TABLE PACHETE_TURISTICE (
    Id_Pachet NUMBER(5) DEFAULT PACHETE_TURISTIC_SEQ.NEXTVAL PRIMARY KEY,
    Id_Plecare NUMBER(5) NOT NULL,
    Id_Transport NUMBER(5) NOT NULL,
    Id_Cazare NUMBER(5) NOT NULL,
    Id_Ghid NUMBER(5) NOT NULL,
    Data_Plecare DATE,
    Data_Intoarcere DATE,
    Pret NUMBER(6,2),
    Descriere VARCHAR2(200),
    Locuri_Disponibile NUMBER(5),
    Reducere NUMBER(2),
    FOREIGN KEY (Id_Plecare) REFERENCES PLECARI(Id_Plecare),
    FOREIGN KEY (Id_Transport) REFERENCES TRANSPORTURI(Id_Transport),
    FOREIGN KEY (Id_Cazare) REFERENCES CAZARI(Id_Cazare),
    FOREIGN KEY (Id_Ghid) REFERENCES GHIZI(Id_Ghid)
);

CREATE TABLE RECENZII (
    Id_Recenzie NUMBER(5) DEFAULT RECENZII_SEQ.NEXTVAL PRIMARY KEY,
    Id_Client NUMBER(5) NOT NULL,
    Id_Pachet NUMBER(5) NOT NULL,
    Scor NUMBER(1),
    Comentariu VARCHAR2(200),
    Data_Recenzie DATE,
    FOREIGN KEY (Id_Client) REFERENCES CLIENTI(Id_Client),
    FOREIGN KEY (Id_Pachet) REFERENCES PACHETE_TURISTICE(Id_Pachet)
);

CREATE TABLE CONTABILI (
    Id_Contabil NUMBER(5) DEFAULT CONTABILI_SEQ.NEXTVAL PRIMARY KEY,
    Nume VARCHAR2(50),
    Data_Nasterii DATE,
    CNP VARCHAR2(13),
    Telefon VARCHAR2(15),
    Email VARCHAR2(50),
    Salariu NUMBER(6,2)
);

CREATE TABLE CONTRACTE (
    Id_Contract NUMBER(5) DEFAULT CONTRACTE_SEQ.NEXTVAL PRIMARY KEY,
    Id_Client NUMBER(5) NOT NULL,
    Id_Contabil NUMBER(5)   NOT NULL,
    Id_Pachet NUMBER(5) NOT NULL,
    Data_Incepere DATE,
    Data_Terminare DATE,
    Continut VARCHAR2(200),
    FOREIGN KEY (Id_Client) REFERENCES CLIENTI(Id_Client),
    FOREIGN KEY (Id_Contabil) REFERENCES CONTABILI(Id_Contabil),
    FOREIGN KEY (Id_Pachet) REFERENCES PACHETE_TURISTICE(Id_Pachet)
);

CREATE TABLE ATRACTII_TURISTICE (
    Id_Atractie NUMBER(5) DEFAULT ATRACTII_TURISTICE_SEQ.NEXTVAL PRIMARY KEY,
    Id_Destinatie NUMBER(5) NOT NULL,
    Nume VARCHAR2(50),
    Tip_Atractie VARCHAR2(50),
    Pret NUMBER(6,2),
    Descriere VARCHAR2(200),
    FOREIGN KEY (Id_Destinatie) REFERENCES DESTINATII(Id_Destinatie)
);

CREATE TABLE PLATI (
    Id_Plata NUMBER(5) DEFAULT PLATI_SEQ.NEXTVAL PRIMARY KEY,
    Id_Client NUMBER(5) NOT NULL,
    Suma NUMBER(6,2),
    Metoda_Plata VARCHAR2(20),
    Data_Efectuare DATE,
    FOREIGN KEY (Id_Client) REFERENCES CLIENTI(Id_Client)
);

CREATE TABLE CLIENTI_PACHETE (
    Id_Client NUMBER(5) NOT NULL,
    Id_Pachet NUMBER(5) NOT NULL,
    PRIMARY KEY (Id_Client, Id_Pachet),
    FOREIGN KEY (Id_Client) REFERENCES CLIENTI(Id_Client),
    FOREIGN KEY (Id_Pachet) REFERENCES PACHETE_TURISTICE(Id_Pachet)
);

CREATE TABLE PACHETE_DESTINATII (
    Id_Pachet NUMBER(5) NOT NULL,
    Id_Destinatie NUMBER(5) NOT NULL,
    PRIMARY KEY (Id_Pachet, Id_Destinatie),
    FOREIGN KEY (Id_Pachet) REFERENCES PACHETE_TURISTICE(Id_Pachet),
    FOREIGN KEY (Id_Destinatie) REFERENCES DESTINATII(Id_Destinatie)
);


--Exercitiul 5

-- --PROGRAME_LOIALITATE 20
-- INSERT INTO PROGRAME_LOIALITATE (Puncte_Loialitate) VALUES (100);
-- INSERT INTO PROGRAME_LOIALITATE (Puncte_Loialitate) VALUES (200);
-- INSERT INTO PROGRAME_LOIALITATE (Puncte_Loialitate) VALUES (150);
-- INSERT INTO PROGRAME_LOIALITATE (Puncte_Loialitate) VALUES (300);
-- INSERT INTO PROGRAME_LOIALITATE (Puncte_Loialitate) VALUES (50);
-- INSERT INTO PROGRAME_LOIALITATE (Puncte_Loialitate) VALUES (120);
-- INSERT INTO PROGRAME_LOIALITATE (Puncte_Loialitate) VALUES (180);
-- INSERT INTO PROGRAME_LOIALITATE (Puncte_Loialitate) VALUES (400);
-- INSERT INTO PROGRAME_LOIALITATE (Puncte_Loialitate) VALUES (250);
-- INSERT INTO PROGRAME_LOIALITATE (Puncte_Loialitate) VALUES (300);
-- INSERT INTO PROGRAME_LOIALITATE (Puncte_Loialitate) VALUES (50);
-- INSERT INTO PROGRAME_LOIALITATE (Puncte_Loialitate) VALUES (90);
-- INSERT INTO PROGRAME_LOIALITATE (Puncte_Loialitate) VALUES (60);
-- INSERT INTO PROGRAME_LOIALITATE (Puncte_Loialitate) VALUES (70);
-- INSERT INTO PROGRAME_LOIALITATE (Puncte_Loialitate) VALUES (80);
-- INSERT INTO PROGRAME_LOIALITATE (Puncte_Loialitate) VALUES (90);
-- INSERT INTO PROGRAME_LOIALITATE (Puncte_Loialitate) VALUES (10);
-- INSERT INTO PROGRAME_LOIALITATE (Puncte_Loialitate) VALUES (120);
-- INSERT INTO PROGRAME_LOIALITATE (Puncte_Loialitate) VALUES (140);
-- INSERT INTO PROGRAME_LOIALITATE (Puncte_Loialitate) VALUES (160);

-- DELETE FROM PROGRAME_LOIALITATE;
-- COMMIT;
-- DELETE FROM RECENZII;
-- DELETE FROM CLIENTI;
-- DELETE FROM CONTRACTE;
-- DELETE FROM CLIENTI_PACHETE;
-- DELETE FROM PLATI;

-- ALTER SEQUENCE CONTRACTE_SEQ RESTART START WITH 1;
-- ALTER SEQUENCE PLATI_SEQ RESTART START WITH 1;
-- ALTER SEQUENCE CLIENTI_SEQ RESTART START WITH 1;
-- ALTER SEQUENCE RECENZII_SEQ RESTART START WITH 1;
-- ALTER SEQUENCE PROGRAME_LOIALITATE_SEQ RESTART START WITH 1;


--CLIENTI 15
INSERT INTO CLIENTI (Nume, Data_Nasterii, CNP, Adresa, Telefon, Email)
VALUES ('Ion Popescu', TO_DATE('1990-01-15', 'YYYY-MM-DD'), '1234567890123', 'Str. Mihai Eminescu 10', '0723456789', 'ion.popescu@gmail.com');
INSERT INTO CLIENTI (Nume, Data_Nasterii, CNP, Adresa, Telefon, Email)
VALUES ('Maria Ionescu', TO_DATE('1985-02-20', 'YYYY-MM-DD'), '2234567890123', 'Str. Victoriei 22', '0723456790', 'maria.ionescu@gmail.com');
INSERT INTO CLIENTI (Nume, Data_Nasterii, CNP, Adresa, Telefon, Email)
VALUES ('Vasile Georgescu', TO_DATE('1992-06-10', 'YYYY-MM-DD'), '3234567890123', 'Str. Libertatii 5', '0723456791', 'vasile.georgescu@gmail.com');
INSERT INTO CLIENTI (Nume, Data_Nasterii, CNP, Adresa, Telefon, Email)
VALUES ('Ana Dumitrescu', TO_DATE('1988-12-12', 'YYYY-MM-DD'), '4234567890123', 'Str. Dorobanti 33', '0723456792', 'ana.dumitrescu@gmail.com');
INSERT INTO CLIENTI (Nume, Data_Nasterii, CNP, Adresa, Telefon, Email)
VALUES ('Cristina Enache', TO_DATE('1995-03-25', 'YYYY-MM-DD'), '5234567890123', 'Str. Unirii 17', '0723456793', 'cristina.enache@gmail.com');
INSERT INTO CLIENTI (Nume, Data_Nasterii, CNP, Adresa, Telefon, Email)
VALUES ('Dan Ilie', TO_DATE('1990-07-05', 'YYYY-MM-DD'), '6234567890123', 'Str. Crinului 19', '0723456794', 'dan.ilie@gmail.com');
INSERT INTO CLIENTI (Nume, Data_Nasterii, CNP, Adresa, Telefon, Email)
VALUES ('Laura Munteanu', TO_DATE('1987-09-17', 'YYYY-MM-DD'), '7234567890123', 'Str. Panselutei 23', '0723456795', 'laura.munteanu@gmail.com');
INSERT INTO CLIENTI (Nume, Data_Nasterii, CNP, Adresa, Telefon, Email)
VALUES ('Florin Pavel', TO_DATE('1993-04-20', 'YYYY-MM-DD'), '8234567890123', 'Str. Rozelor 15', '0723456796', 'florin.pavel@gmail.com');
INSERT INTO CLIENTI (Nume, Data_Nasterii, CNP, Adresa, Telefon, Email)
VALUES ('Roxana Antonescu', TO_DATE('1996-08-30', 'YYYY-MM-DD'), '9234567890123', 'Str. Ciresului 18', '0723456797', 'roxana.antonescu@gmail.com');
INSERT INTO CLIENTI (Nume, Data_Nasterii, CNP, Adresa, Telefon, Email)
VALUES ('George Avram', TO_DATE('1991-01-01', 'YYYY-MM-DD'), '1023456789012', 'Str. Teiului 11', '0723456798', 'george.avram@gmail.com');
INSERT INTO CLIENTI (Nume, Data_Nasterii, CNP, Adresa, Telefon, Email)
VALUES ('Elena Popa', TO_DATE('1989-10-10', 'YYYY-MM-DD'), '1123456789012', 'Str. Salcamilor 8', '0723456799', 'elena.popa@gmail.com');
INSERT INTO CLIENTI (Nume, Data_Nasterii, CNP, Adresa, Telefon, Email)
VALUES ('Mircea Iancu', TO_DATE('1994-11-12', 'YYYY-MM-DD'), '1223456789012', 'Str. Bujorului 20', '0723456700', 'mircea.iancu@gmail.com');
INSERT INTO CLIENTI (Nume, Data_Nasterii, CNP, Adresa, Telefon, Email)
VALUES ('Sorina Moldovan', TO_DATE('1990-05-05', 'YYYY-MM-DD'), '1323456789012', 'Str. Trandafirilor 3', '0723456701', 'sorina.moldovan@gmail.com');
INSERT INTO CLIENTI (Nume, Data_Nasterii, CNP, Adresa, Telefon, Email)
VALUES ('Andrei Balan', TO_DATE('1986-03-15', 'YYYY-MM-DD'), '1423456789012', 'Str. Macesului 7', '0723456702', 'andrei.balan@gmail.com');
INSERT INTO CLIENTI (Nume, Data_Nasterii, CNP, Adresa, Telefon, Email)
VALUES ('Livia Petrescu', TO_DATE('1997-02-18', 'YYYY-MM-DD'), '1523456789012', 'Str. Zorilor 21', '0723456703', 'livia.petrescu@gmail.com');


--TRANSPORTURI 20
INSERT INTO TRANSPORTURI (Tip_Vehicul, Numar_Locuri, Pret, Operator, Disponibil)
VALUES ('Autocar', 50, 150.00, 'TransTour', 'Y');
INSERT INTO TRANSPORTURI (Tip_Vehicul, Numar_Locuri, Pret, Operator, Disponibil)
VALUES ('Microbuz', 20, 75.00, 'QuickTravel', 'Y');
INSERT INTO TRANSPORTURI (Tip_Vehicul, Numar_Locuri, Pret, Operator, Disponibil)
VALUES ('Avion', 180, 500.00, 'BlueSky', 'Y');
INSERT INTO TRANSPORTURI (Tip_Vehicul, Numar_Locuri, Pret, Operator, Disponibil)
VALUES ('Tren', 100, 200.00, 'RailExpress', 'Y');
INSERT INTO TRANSPORTURI (Tip_Vehicul, Numar_Locuri, Pret, Operator, Disponibil)
VALUES ('Ferry', 300, 250.00, 'SeaWave', 'N');
INSERT INTO TRANSPORTURI (Tip_Vehicul, Numar_Locuri, Pret, Operator, Disponibil)
VALUES ('Autocar', 55, 180.00, 'MegaTravel', 'Y');
INSERT INTO TRANSPORTURI (Tip_Vehicul, Numar_Locuri, Pret, Operator, Disponibil)
VALUES ('Microbuz', 25, 90.00, 'CityHop', 'N');
INSERT INTO TRANSPORTURI (Tip_Vehicul, Numar_Locuri, Pret, Operator, Disponibil)
VALUES ('Avion', 220, 600.00, 'SkyHigh', 'Y');
INSERT INTO TRANSPORTURI (Tip_Vehicul, Numar_Locuri, Pret, Operator, Disponibil)
VALUES ('Tren', 80, 150.00, 'SpeedRail', 'Y');
INSERT INTO TRANSPORTURI (Tip_Vehicul, Numar_Locuri, Pret, Operator, Disponibil)
VALUES ('Autocar', 45, 120.00, 'EuroTravel', 'Y');
INSERT INTO TRANSPORTURI (Tip_Vehicul, Numar_Locuri, Pret, Operator, Disponibil)
VALUES ('Microbuz', 15, 70.00, 'TravelGo', 'N');
INSERT INTO TRANSPORTURI (Tip_Vehicul, Numar_Locuri, Pret, Operator, Disponibil)
VALUES ('Avion', 150, 450.00, 'FlyAway', 'Y');
INSERT INTO TRANSPORTURI (Tip_Vehicul, Numar_Locuri, Pret, Operator, Disponibil)
VALUES ('Tren', 120, 220.00, 'GreenRail', 'Y');
INSERT INTO TRANSPORTURI (Tip_Vehicul, Numar_Locuri, Pret, Operator, Disponibil)
VALUES ('Ferry', 250, 300.00, 'OceanLine', 'N');
INSERT INTO TRANSPORTURI (Tip_Vehicul, Numar_Locuri, Pret, Operator, Disponibil)
VALUES ('Autocar', 60, 200.00, 'TopTravel', 'Y');
INSERT INTO TRANSPORTURI (Tip_Vehicul, Numar_Locuri, Pret, Operator, Disponibil)
VALUES ('Microbuz', 18, 85.00, 'CityRide', 'Y');
INSERT INTO TRANSPORTURI (Tip_Vehicul, Numar_Locuri, Pret, Operator, Disponibil)
VALUES ('Avion', 300, 700.00, 'GlobalAir', 'Y');
INSERT INTO TRANSPORTURI (Tip_Vehicul, Numar_Locuri, Pret, Operator, Disponibil)
VALUES ('Tren', 110, 180.00, 'ExpressLine', 'N');
INSERT INTO TRANSPORTURI (Tip_Vehicul, Numar_Locuri, Pret, Operator, Disponibil)
VALUES ('Autocar', 40, 130.00, 'FastTrack', 'Y');
INSERT INTO TRANSPORTURI (Tip_Vehicul, Numar_Locuri, Pret, Operator, Disponibil)
VALUES ('Ferry', 200, 280.00, 'SeaBridge', 'Y');

--PLECARI 15
INSERT INTO PLECARI (Oras, Adresa, Ora_Plecare)
VALUES ('Bucuresti', 'Gara de Nord', TO_DATE('2024-07-01 08:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO PLECARI (Oras, Adresa, Ora_Plecare)
VALUES ('Cluj-Napoca', 'Aeroport Avram Iancu', TO_DATE('2024-07-02 09:30', 'YYYY-MM-DD HH24:MI'));
INSERT INTO PLECARI (Oras, Adresa, Ora_Plecare)
VALUES ('Timisoara', 'Autogara Sud', TO_DATE('2024-07-03 12:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO PLECARI (Oras, Adresa, Ora_Plecare)
VALUES ('Iasi', 'Aeroport International', TO_DATE('2024-07-04 15:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO PLECARI (Oras, Adresa, Ora_Plecare)
VALUES ('Brasov', 'Gara Centrala', TO_DATE('2024-07-05 07:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO PLECARI (Oras, Adresa, Ora_Plecare)
VALUES ('Constanta', 'Port Tomis', TO_DATE('2024-07-06 11:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO PLECARI (Oras, Adresa, Ora_Plecare)
VALUES ('Oradea', 'Autogara Vest', TO_DATE('2024-07-07 10:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO PLECARI (Oras, Adresa, Ora_Plecare)
VALUES ('Sibiu', 'Aeroport Sibiu', TO_DATE('2024-07-08 13:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO PLECARI (Oras, Adresa, Ora_Plecare)
VALUES ('Arad', 'Gara Arad', TO_DATE('2024-07-09 14:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO PLECARI (Oras, Adresa, Ora_Plecare)
VALUES ('Galati', 'Autogara Galati', TO_DATE('2024-07-10 16:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO PLECARI (Oras, Adresa, Ora_Plecare)
VALUES ('Pitesti', 'Gara Pitesti', TO_DATE('2024-07-11 09:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO PLECARI (Oras, Adresa, Ora_Plecare)
VALUES ('Targu Mures', 'Aeroport Transilvania', TO_DATE('2024-07-12 11:30', 'YYYY-MM-DD HH24:MI'));
INSERT INTO PLECARI (Oras, Adresa, Ora_Plecare)
VALUES ('Baia Mare', 'Autogara Nord', TO_DATE('2024-07-13 08:30', 'YYYY-MM-DD HH24:MI'));
INSERT INTO PLECARI (Oras, Adresa, Ora_Plecare)
VALUES ('Ploiesti', 'Gara de Sud', TO_DATE('2024-07-14 07:45', 'YYYY-MM-DD HH24:MI'));
INSERT INTO PLECARI (Oras, Adresa, Ora_Plecare)
VALUES ('Bacau', 'Autogara Bacau', TO_DATE('2024-07-15 13:45', 'YYYY-MM-DD HH24:MI'));

--DESTINATII 20
INSERT INTO DESTINATII (Tara, Oras, Descriere)
VALUES ('Franta', 'Paris', 'Capitala Frantei, cunoscută pentru Turnul Eiffel și muzeul Luvru.');
INSERT INTO DESTINATII (Tara, Oras, Descriere)
VALUES ('Italia', 'Roma', 'Orașul etern, cu Colosseumul și Vaticanul.');
INSERT INTO DESTINATII (Tara, Oras, Descriere)
VALUES ('Spania', 'Barcelona', 'Oraș vibrant, renumit pentru arhitectura lui Gaudi.');
INSERT INTO DESTINATII (Tara, Oras, Descriere)
VALUES ('Grecia', 'Atena', 'Leagănul civilizației, cu Acropole și Parthenon.');
INSERT INTO DESTINATII (Tara, Oras, Descriere)
VALUES ('Marea Britanie', 'Londra', 'Metropolă culturală, cu Big Ben și British Museum.');
INSERT INTO DESTINATII (Tara, Oras, Descriere)
VALUES ('Japonia', 'Tokyo', 'Capitală modernă, plină de tehnologie și tradiție.');
INSERT INTO DESTINATII (Tara, Oras, Descriere)
VALUES ('Austria', 'Viena', 'Oraș imperial, cu palate și muzică clasică.');
INSERT INTO DESTINATII (Tara, Oras, Descriere)
VALUES ('Germania', 'Berlin', 'Capitala Germaniei, cu Poarta Brandenburg și istorie bogată.');
INSERT INTO DESTINATII (Tara, Oras, Descriere)
VALUES ('Egipt', 'Cairo', 'Orașul piramidelor și al Nilului.');
INSERT INTO DESTINATII (Tara, Oras, Descriere)
VALUES ('Turcia', 'Istanbul', 'Oraș pe două continente, cu Hagia Sophia și Marele Bazar.');
INSERT INTO DESTINATII (Tara, Oras, Descriere)
VALUES ('Statele Unite', 'New York', 'Orașul care nu doarme niciodată.');
INSERT INTO DESTINATII (Tara, Oras, Descriere)
VALUES ('Brazilia', 'Rio de Janeiro', 'Oraș cunoscut pentru carnaval și plaja Copacabana.');
INSERT INTO DESTINATII (Tara, Oras, Descriere)
VALUES ('Thailanda', 'Bangkok', 'Capitală exotică, cu temple și piețe vibrante.');
INSERT INTO DESTINATII (Tara, Oras, Descriere)
VALUES ('Australia', 'Sydney', 'Oraș cu Opera House și plaje superbe.');
INSERT INTO DESTINATII (Tara, Oras, Descriere)
VALUES ('Canada', 'Toronto', 'Metropolă modernă și multiculturală.');
INSERT INTO DESTINATII (Tara, Oras, Descriere)
VALUES ('Mexic', 'Cancun', 'Destinație turistică cu plaje și ruine mayașe.');
INSERT INTO DESTINATII (Tara, Oras, Descriere)
VALUES ('India', 'Delhi', 'Capitala Indiei, cu temple și monumente istorice.');
INSERT INTO DESTINATII (Tara, Oras, Descriere)
VALUES ('China', 'Beijing', 'Orașul Zidului Chinezesc și al Orașului Interzis.');
INSERT INTO DESTINATII (Tara, Oras, Descriere)
VALUES ('Africa de Sud', 'Cape Town', 'Oraș cu peisaje spectaculoase și Table Mountain.');
INSERT INTO DESTINATII (Tara, Oras, Descriere)
VALUES ('Olanda', 'Amsterdam', 'Orașul canalelor și al muzeelor.');

--CAZARI 20
INSERT INTO CAZARI (Id_Destinatie, Tip_Cazare, Numar_Locuri, Pret, Nume, Adresa, Stele, Facilitati)
VALUES (1, 'Hotel', 100, 150.00, 'Hotel Eiffel', 'Champs-Élysées, Paris', 5, 'WiFi, Mic dejun inclus, Piscină');
INSERT INTO CAZARI (Id_Destinatie, Tip_Cazare, Numar_Locuri, Pret, Nume, Adresa, Stele, Facilitati)
VALUES (2, 'Hotel', 80, 130.00, 'Colosseum Inn', 'Via del Corso, Roma', 4, 'WiFi, Parcare gratuită');
INSERT INTO CAZARI (Id_Destinatie, Tip_Cazare, Numar_Locuri, Pret, Nume, Adresa, Stele, Facilitati)
VALUES (3, 'Hostel', 50, 40.00, 'Gaudi Hostel', 'Las Ramblas, Barcelona', 3, 'WiFi, Bucătărie comună');
INSERT INTO CAZARI (Id_Destinatie, Tip_Cazare, Numar_Locuri, Pret, Nume, Adresa, Stele, Facilitati)
VALUES (4, 'Hotel', 120, 110.00, 'Athens Palace', 'Plaka, Atena', 4, 'WiFi, Spa');
INSERT INTO CAZARI (Id_Destinatie, Tip_Cazare, Numar_Locuri, Pret, Nume, Adresa, Stele, Facilitati)
VALUES (5, 'Pensiune', 30, 90.00, 'Big Ben Lodge', 'Westminster, Londra', 3, 'Mic dejun inclus');
INSERT INTO CAZARI (Id_Destinatie, Tip_Cazare, Numar_Locuri, Pret, Nume, Adresa, Stele, Facilitati)
VALUES (6, 'Hotel', 200, 200.00, 'Tokyo Tower Hotel', 'Shibuya, Tokyo', 5, 'WiFi, Spa, Piscină');
INSERT INTO CAZARI (Id_Destinatie, Tip_Cazare, Numar_Locuri, Pret, Nume, Adresa, Stele, Facilitati)
VALUES (7, 'Hotel', 150, 140.00, 'Vienna Imperial', 'Ringstraße, Viena', 5, 'WiFi, Mic dejun inclus');
INSERT INTO CAZARI (Id_Destinatie, Tip_Cazare, Numar_Locuri, Pret, Nume, Adresa, Stele, Facilitati)
VALUES (8, 'Hostel', 70, 50.00, 'Berlin Backpackers', 'Alexanderplatz, Berlin', 2, 'WiFi, Bucătărie comună');
INSERT INTO CAZARI (Id_Destinatie, Tip_Cazare, Numar_Locuri, Pret, Nume, Adresa, Stele, Facilitati)
VALUES (9, 'Hotel', 90, 120.00, 'Pyramid View', 'Giza, Cairo', 4, 'WiFi, Piscină');
INSERT INTO CAZARI (Id_Destinatie, Tip_Cazare, Numar_Locuri, Pret, Nume, Adresa, Stele, Facilitati)
VALUES (10, 'Hotel', 130, 100.00, 'Hagia Sophia Hotel', 'Sultanahmet, Istanbul', 4, 'WiFi, Spa');
INSERT INTO CAZARI (Id_Destinatie, Tip_Cazare, Numar_Locuri, Pret, Nume, Adresa, Stele, Facilitati)
VALUES (11, 'Hotel', 120, 180.00, 'Liberty Suites', 'Manhattan, New York', 5, 'WiFi, Piscină, Mic dejun inclus');
INSERT INTO CAZARI (Id_Destinatie, Tip_Cazare, Numar_Locuri, Pret, Nume, Adresa, Stele, Facilitati)
VALUES (12, 'Pensiune', 40, 70.00, 'Carnival House', 'Copacabana, Rio de Janeiro', 3, 'WiFi, Mic dejun inclus');
INSERT INTO CAZARI (Id_Destinatie, Tip_Cazare, Numar_Locuri, Pret, Nume, Adresa, Stele, Facilitati)
VALUES (13, 'Hotel', 200, 160.00, 'Temple Inn', 'Sukhumvit, Bangkok', 4, 'WiFi, Spa');
INSERT INTO CAZARI (Id_Destinatie, Tip_Cazare, Numar_Locuri, Pret, Nume, Adresa, Stele, Facilitati)
VALUES (14, 'Hotel', 150, 220.00, 'Harbour View', 'Circular Quay, Sydney', 5, 'WiFi, Piscină');
INSERT INTO CAZARI (Id_Destinatie, Tip_Cazare, Numar_Locuri, Pret, Nume, Adresa, Stele, Facilitati)
VALUES (15, 'Hotel', 100, 150.00, 'Maple Leaf Suites', 'Downtown, Toronto', 4, 'WiFi, Parcare gratuită');
INSERT INTO CAZARI (Id_Destinatie, Tip_Cazare, Numar_Locuri, Pret, Nume, Adresa, Stele, Facilitati)
VALUES (16, 'Resort', 300, 250.00, 'Mayan Paradise', 'Zona Hotelera, Cancun', 5, 'Piscină, All Inclusive');
INSERT INTO CAZARI (Id_Destinatie, Tip_Cazare, Numar_Locuri, Pret, Nume, Adresa, Stele, Facilitati)
VALUES (17, 'Hotel', 80, 110.00, 'Lotus Inn', 'Connaught Place, Delhi', 3, 'WiFi, Mic dejun inclus');
INSERT INTO CAZARI (Id_Destinatie, Tip_Cazare, Numar_Locuri, Pret, Nume, Adresa, Stele, Facilitati)
VALUES (18, 'Hotel', 250, 190.00, 'Forbidden City Hotel', 'Dongcheng, Beijing', 5, 'WiFi, Spa');
INSERT INTO CAZARI (Id_Destinatie, Tip_Cazare, Numar_Locuri, Pret, Nume, Adresa, Stele, Facilitati)
VALUES (19, 'Vila', 60, 130.00, 'Mountain View', 'Table Mountain, Cape Town', 4, 'WiFi, Parcare gratuită');
INSERT INTO CAZARI (Id_Destinatie, Tip_Cazare, Numar_Locuri, Pret, Nume, Adresa, Stele, Facilitati)
VALUES (20, 'Hotel', 90, 100.00, 'Canal View Inn', 'Centru, Amsterdam', 3, 'WiFi, Mic dejun inclus');

--GHIZI 12
INSERT INTO GHIZI (Nume, Data_Nasterii, CNP, Telefon, Email, Tarif, Limbi_Straine, Experienta)
VALUES ('Ion Popescu', TO_DATE('1985-05-10', 'YYYY-MM-DD'), '1850510100012', '0721234567', 'ion.popescu@gmail.com', 150.00, 'Romana, Engleza', 10);
INSERT INTO GHIZI (Nume, Data_Nasterii, CNP, Telefon, Email, Tarif, Limbi_Straine, Experienta)
VALUES ('Maria Ionescu', TO_DATE('1990-08-15', 'YYYY-MM-DD'), '2900815100023', '0734567890', 'maria.ionescu@yahoo.com', 120.00, 'Romana, Franceza', 7);
INSERT INTO GHIZI (Nume, Data_Nasterii, CNP, Telefon, Email, Tarif, Limbi_Straine, Experienta)
VALUES ('Alexandru Radu', TO_DATE('1988-03-20', 'YYYY-MM-DD'), '1880320100015', '0741234567', 'alex.radu@gmail.com', 100.00, 'Romana, Spaniola', 8);
INSERT INTO GHIZI (Nume, Data_Nasterii, CNP, Telefon, Email, Tarif, Limbi_Straine, Experienta)
VALUES ('Elena Dumitrescu', TO_DATE('1992-09-15', 'YYYY-MM-DD'), '2920915100024', '0754567890', 'elena.dumitrescu@yahoo.com', 110.00, 'Romana, Engleza, Italiana', 6);
INSERT INTO GHIZI (Nume, Data_Nasterii, CNP, Telefon, Email, Tarif, Limbi_Straine, Experienta)
VALUES ('Radu Vasile', TO_DATE('1980-11-25', 'YYYY-MM-DD'), '1801125100013', '0769876543', 'radu.vasile@mail.com', 130.00, 'Romana, Germana', 12);
INSERT INTO GHIZI (Nume, Data_Nasterii, CNP, Telefon, Email, Tarif, Limbi_Straine, Experienta)
VALUES ('Ana Tudor', TO_DATE('1995-02-18', 'YYYY-MM-DD'), '2950218100035', '0732223344', 'ana.tudor@gmail.com', 90.00, 'Romana, Franceza', 4);
INSERT INTO GHIZI (Nume, Data_Nasterii, CNP, Telefon, Email, Tarif, Limbi_Straine, Experienta)
VALUES ('Cristian Marinescu', TO_DATE('1983-07-12', 'YYYY-MM-DD'), '1830712100021', '0725566778', 'cristian.marin@gmail.com', 140.00, 'Romana, Engleza, Japoneza', 15);
INSERT INTO GHIZI (Nume, Data_Nasterii, CNP, Telefon, Email, Tarif, Limbi_Straine, Experienta)
VALUES ('Irina Stoica', TO_DATE('1990-04-10', 'YYYY-MM-DD'), '2900410100019', '0747788990', 'irina.stoica@mail.com', 120.00, 'Romana, Chineza', 9);
INSERT INTO GHIZI (Nume, Data_Nasterii, CNP, Telefon, Email, Tarif, Limbi_Straine, Experienta)
VALUES ('Mihai Popa', TO_DATE('1986-01-05', 'YYYY-MM-DD'), '1860105100014', '0723456789', 'mihai.popa@yahoo.com', 125.00, 'Romana, Engleza', 11);
INSERT INTO GHIZI (Nume, Data_Nasterii, CNP, Telefon, Email, Tarif, Limbi_Straine, Experienta)
VALUES ('Simona Gheorghe', TO_DATE('1993-12-01', 'YYYY-MM-DD'), '2931201100028', '0765432109', 'simona.gheorghe@gmail.com', 105.00, 'Romana, Rusa', 7);
INSERT INTO GHIZI (Nume, Data_Nasterii, CNP, Telefon, Email, Tarif, Limbi_Straine, Experienta)
VALUES ('Bogdan Ionescu', TO_DATE('1984-06-14', 'YYYY-MM-DD'), '1840614100032', '0735678901', 'bogdan.ionescu@mail.com', 150.00, 'Romana, Portugheza', 13);
INSERT INTO GHIZI (Nume, Data_Nasterii, CNP, Telefon, Email, Tarif, Limbi_Straine, Experienta)
VALUES ('Adriana Mihai', TO_DATE('1996-08-22', 'YYYY-MM-DD'), '2960822100040', '0756789012', 'adriana.mihai@gmail.com', 95.00, 'Romana, Italiana', 5);


--PACHETE_TURISTICE
INSERT INTO PACHETE_TURISTICE (Id_Plecare, Id_Transport, Id_Cazare, Id_Ghid, Data_Plecare, Data_Intoarcere, Pret, Descriere, Locuri_Disponibile, Reducere) VALUES
(1, 1, 1, 1, TO_DATE('2024-01-15', 'YYYY-MM-DD'), TO_DATE('2024-01-22', 'YYYY-MM-DD'), 1200.50, 'Aventuri Alpine', 20, 10);
INSERT INTO PACHETE_TURISTICE (Id_Plecare, Id_Transport, Id_Cazare, Id_Ghid, Data_Plecare, Data_Intoarcere, Pret, Descriere, Locuri_Disponibile, Reducere) VALUES
(2, 2, 2, 2, TO_DATE('2024-02-10', 'YYYY-MM-DD'), TO_DATE('2024-02-20', 'YYYY-MM-DD'), 1500.00, 'Vacanta Tropicala', 30, 5);
INSERT INTO PACHETE_TURISTICE (Id_Plecare, Id_Transport, Id_Cazare, Id_Ghid, Data_Plecare, Data_Intoarcere, Pret, Descriere, Locuri_Disponibile, Reducere) VALUES
(3, 3, 3, 3, TO_DATE('2024-03-05', 'YYYY-MM-DD'), TO_DATE('2024-03-08', 'YYYY-MM-DD'), 800.75, 'City Break Paris', 25, 0);
INSERT INTO PACHETE_TURISTICE (Id_Plecare, Id_Transport, Id_Cazare, Id_Ghid, Data_Plecare, Data_Intoarcere, Pret, Descriere, Locuri_Disponibile, Reducere) VALUES
(4, 4, 4, 4, TO_DATE('2024-04-01', 'YYYY-MM-DD'), TO_DATE('2024-04-15', 'YYYY-MM-DD'), 3000.00, 'Safari African', 15, 12);
INSERT INTO PACHETE_TURISTICE (Id_Plecare, Id_Transport, Id_Cazare, Id_Ghid, Data_Plecare, Data_Intoarcere, Pret, Descriere, Locuri_Disponibile, Reducere) VALUES
(5, 5, 5, 5, TO_DATE('2024-05-01', 'YYYY-MM-DD'), TO_DATE('2024-05-13', 'YYYY-MM-DD'), 2000.00, 'Circuit Cultural Italia', 20, 8);
INSERT INTO PACHETE_TURISTICE (Id_Plecare, Id_Transport, Id_Cazare, Id_Ghid, Data_Plecare, Data_Intoarcere, Pret, Descriere, Locuri_Disponibile, Reducere) VALUES
(6, 6, 6, 6, TO_DATE('2024-06-10', 'YYYY-MM-DD'), TO_DATE('2024-06-12', 'YYYY-MM-DD'), 500.00, 'Relaxare la Spa', 50, 15);
INSERT INTO PACHETE_TURISTICE (Id_Plecare, Id_Transport, Id_Cazare, Id_Ghid, Data_Plecare, Data_Intoarcere, Pret, Descriere, Locuri_Disponibile, Reducere) VALUES
(7, 7, 7, 7, TO_DATE('2024-07-01', 'YYYY-MM-DD'), TO_DATE('2024-07-21', 'YYYY-MM-DD'), 5000.00, 'Expeditie Polara', 10, 20);
INSERT INTO PACHETE_TURISTICE (Id_Plecare, Id_Transport, Id_Cazare, Id_Ghid, Data_Plecare, Data_Intoarcere, Pret, Descriere, Locuri_Disponibile, Reducere) VALUES
(8, 8, 8, 8, TO_DATE('2024-08-15', 'YYYY-MM-DD'), TO_DATE('2024-08-27', 'YYYY-MM-DD'), 2500.00, 'Plaje Exotice Bali', 40, 5);
INSERT INTO PACHETE_TURISTICE (Id_Plecare, Id_Transport, Id_Cazare, Id_Ghid, Data_Plecare, Data_Intoarcere, Pret, Descriere, Locuri_Disponibile, Reducere) VALUES
(9, 9, 9, 9, TO_DATE('2024-09-01', 'YYYY-MM-DD'), TO_DATE('2024-09-15', 'YYYY-MM-DD'), 4000.00, 'Croaziera Mediteraneana', 30, 10);
INSERT INTO PACHETE_TURISTICE (Id_Plecare, Id_Transport, Id_Cazare, Id_Ghid, Data_Plecare, Data_Intoarcere, Pret, Descriere, Locuri_Disponibile, Reducere) VALUES
(10, 10, 10, 10, TO_DATE('2024-10-10', 'YYYY-MM-DD'), TO_DATE('2024-10-15', 'YYYY-MM-DD'), 1000.00, 'Tur Transilvania', 25, 0);
INSERT INTO PACHETE_TURISTICE (Id_Plecare, Id_Transport, Id_Cazare, Id_Ghid, Data_Plecare, Data_Intoarcere, Pret, Descriere, Locuri_Disponibile, Reducere) VALUES
(11, 11, 11, 11, TO_DATE('2024-11-01', 'YYYY-MM-DD'), TO_DATE('2024-11-16', 'YYYY-MM-DD'), 4500.00, 'Circuit Scandinavia', 15, 18);
INSERT INTO PACHETE_TURISTICE (Id_Plecare, Id_Transport, Id_Cazare, Id_Ghid, Data_Plecare, Data_Intoarcere, Pret, Descriere, Locuri_Disponibile, Reducere) VALUES
(12, 12, 12, 12, TO_DATE('2024-12-20', 'YYYY-MM-DD'), TO_DATE('2024-12-27', 'YYYY-MM-DD'), 1800.00, 'Pachet Ski Austria', 50, 5);
INSERT INTO PACHETE_TURISTICE (Id_Plecare, Id_Transport, Id_Cazare, Id_Ghid, Data_Plecare, Data_Intoarcere, Pret, Descriere, Locuri_Disponibile, Reducere) VALUES
(13, 13, 13, 1, TO_DATE('2025-01-05', 'YYYY-MM-DD'), TO_DATE('2025-01-15', 'YYYY-MM-DD'), 2200.00, 'Explorare Thailanda', 30, 10);
INSERT INTO PACHETE_TURISTICE (Id_Plecare, Id_Transport, Id_Cazare, Id_Ghid, Data_Plecare, Data_Intoarcere, Pret, Descriere, Locuri_Disponibile, Reducere) VALUES
(14, 14, 14, 2, TO_DATE('2024-12-01', 'YYYY-MM-DD'), TO_DATE('2024-12-04', 'YYYY-MM-DD'), 700.00, 'Weekend Londra', 25, 0);
INSERT INTO PACHETE_TURISTICE (Id_Plecare, Id_Transport, Id_Cazare, Id_Ghid, Data_Plecare, Data_Intoarcere, Pret, Descriere, Locuri_Disponibile, Reducere) VALUES
(15, 15, 15, 3, TO_DATE('2024-03-20', 'YYYY-MM-DD'), TO_DATE('2024-03-28', 'YYYY-MM-DD'), 1500.00, 'Circuit Balcanic', 30, 5);
INSERT INTO PACHETE_TURISTICE (Id_Plecare, Id_Transport, Id_Cazare, Id_Ghid, Data_Plecare, Data_Intoarcere, Pret, Descriere, Locuri_Disponibile, Reducere) VALUES
(6, 16, 16, 4, TO_DATE('2024-04-10', 'YYYY-MM-DD'), TO_DATE('2024-04-25', 'YYYY-MM-DD'), 5000.00, 'Tur Japonia', 15, 12);
INSERT INTO PACHETE_TURISTICE (Id_Plecare, Id_Transport, Id_Cazare, Id_Ghid, Data_Plecare, Data_Intoarcere, Pret, Descriere, Locuri_Disponibile, Reducere) VALUES
(7, 17, 17, 5, TO_DATE('2024-06-01', 'YYYY-MM-DD'), TO_DATE('2024-06-13', 'YYYY-MM-DD'), 4000.00, 'Aventura in Amazon', 20, 10);
INSERT INTO PACHETE_TURISTICE (Id_Plecare, Id_Transport, Id_Cazare, Id_Ghid, Data_Plecare, Data_Intoarcere, Pret, Descriere, Locuri_Disponibile, Reducere) VALUES
(8, 18, 18, 6, TO_DATE('2024-07-20', 'YYYY-MM-DD'), TO_DATE('2024-07-27', 'YYYY-MM-DD'), 1800.00, 'Descopera Grecia', 35, 5);
INSERT INTO PACHETE_TURISTICE (Id_Plecare, Id_Transport, Id_Cazare, Id_Ghid, Data_Plecare, Data_Intoarcere, Pret, Descriere, Locuri_Disponibile, Reducere) VALUES
(9, 19, 19, 7, TO_DATE('2025-01-10', 'YYYY-MM-DD'), TO_DATE('2025-01-31', 'YYYY-MM-DD'), 6000.00, 'Expeditie Antarctica', 10, 20);
INSERT INTO PACHETE_TURISTICE (Id_Plecare, Id_Transport, Id_Cazare, Id_Ghid, Data_Plecare, Data_Intoarcere, Pret, Descriere, Locuri_Disponibile, Reducere) VALUES
(10, 20, 20, 8, TO_DATE('2024-09-10', 'YYYY-MM-DD'), TO_DATE('2024-09-20', 'YYYY-MM-DD'), 3500.00, 'Cruise Alaska', 25, 8);


--RECENZII
INSERT INTO RECENZII (Id_Client, Id_Pachet, Scor, Comentariu, Data_Recenzie) VALUES 
(1, 1, 5, 'O experienta minunata!', TO_DATE('2024-01-25', 'YYYY-MM-DD'));
INSERT INTO RECENZII (Id_Client, Id_Pachet, Scor, Comentariu, Data_Recenzie) VALUES
(2, 2, 4, 'Plaje superbe si oameni prietenosi.', TO_DATE('2024-02-22', 'YYYY-MM-DD'));
INSERT INTO RECENZII (Id_Client, Id_Pachet, Scor, Comentariu, Data_Recenzie) VALUES
(3, 3, 3, 'Organizare buna, dar putin scump.', TO_DATE('2024-03-10', 'YYYY-MM-DD'));
INSERT INTO RECENZII (Id_Client, Id_Pachet, Scor, Comentariu, Data_Recenzie) VALUES
(4, 4, 5, 'Safari-ul a fost de neuitat!', TO_DATE('2024-04-20', 'YYYY-MM-DD'));
INSERT INTO RECENZII (Id_Client, Id_Pachet, Scor, Comentariu, Data_Recenzie) VALUES
(5, 5, 4, 'Circuit cultural interesant.', TO_DATE('2024-05-15', 'YYYY-MM-DD'));
INSERT INTO RECENZII (Id_Client, Id_Pachet, Scor, Comentariu, Data_Recenzie) VALUES
(6, 6, 5, 'Relaxare totala, recomand!', TO_DATE('2024-06-14', 'YYYY-MM-DD'));
INSERT INTO RECENZII (Id_Client, Id_Pachet, Scor, Comentariu, Data_Recenzie) VALUES
(7, 7, 4, 'Foarte frig, dar experienta unica.', TO_DATE('2024-07-25', 'YYYY-MM-DD'));
INSERT INTO RECENZII (Id_Client, Id_Pachet, Scor, Comentariu, Data_Recenzie) VALUES
(8, 8, 5, 'Bali este un paradis.', TO_DATE('2024-08-30', 'YYYY-MM-DD'));
INSERT INTO RECENZII (Id_Client, Id_Pachet, Scor, Comentariu, Data_Recenzie) VALUES
(9, 9, 4, 'Croaziera bine organizata.', TO_DATE('2024-09-20', 'YYYY-MM-DD'));
INSERT INTO RECENZII (Id_Client, Id_Pachet, Scor, Comentariu, Data_Recenzie) VALUES
(10, 10, 5, 'Transilvania e magica!', TO_DATE('2024-10-18', 'YYYY-MM-DD'));
INSERT INTO RECENZII (Id_Client, Id_Pachet, Scor, Comentariu, Data_Recenzie) VALUES
(11, 11, 5, 'Scandinavia e superba.', TO_DATE('2024-11-20', 'YYYY-MM-DD'));
INSERT INTO RECENZII (Id_Client, Id_Pachet, Scor, Comentariu, Data_Recenzie) VALUES
(12, 12, 5, 'Partiile de ski excelente.', TO_DATE('2024-12-29', 'YYYY-MM-DD'));
INSERT INTO RECENZII (Id_Client, Id_Pachet, Scor, Comentariu, Data_Recenzie) VALUES
(13, 13, 5, 'Thailanda e fascinanta.', TO_DATE('2025-01-20', 'YYYY-MM-DD'));
INSERT INTO RECENZII (Id_Client, Id_Pachet, Scor, Comentariu, Data_Recenzie) VALUES
(14, 14, 4, 'Londra e mereu o idee buna.', TO_DATE('2024-12-06', 'YYYY-MM-DD'));
INSERT INTO RECENZII (Id_Client, Id_Pachet, Scor, Comentariu, Data_Recenzie) VALUES
(15, 15, 4, 'Balcanii sunt plini de istorie.', TO_DATE('2024-03-30', 'YYYY-MM-DD'));
INSERT INTO RECENZII (Id_Client, Id_Pachet, Scor, Comentariu, Data_Recenzie) VALUES
(6, 16, 5, 'Turul Japoniei a fost uimitor.', TO_DATE('2024-04-28', 'YYYY-MM-DD'));
INSERT INTO RECENZII (Id_Client, Id_Pachet, Scor, Comentariu, Data_Recenzie) VALUES
(7, 17, 5, 'Amazonul este uluitor.', TO_DATE('2024-06-15', 'YYYY-MM-DD'));
INSERT INTO RECENZII (Id_Client, Id_Pachet, Scor, Comentariu, Data_Recenzie) VALUES
(8, 18, 5, 'Grecia e superba vara.', TO_DATE('2024-07-29', 'YYYY-MM-DD'));
INSERT INTO RECENZII (Id_Client, Id_Pachet, Scor, Comentariu, Data_Recenzie) VALUES
(9, 19, 4, 'Expeditie extrema dar frumoasa.', TO_DATE('2025-02-01', 'YYYY-MM-DD'));
INSERT INTO RECENZII (Id_Client, Id_Pachet, Scor, Comentariu, Data_Recenzie) VALUES
(2, 20, 5, 'Alaska e spectaculoasa.', TO_DATE('2024-09-22', 'YYYY-MM-DD'));

--CONTABILI 20
INSERT INTO CONTABILI (NUME, Data_Nasterii, CNP, TELEFON, EMAIL, SALARIU) VALUES
('Popescu', TO_DATE('1980-01-15', 'YYYY-MM-DD'), '1234567890124', '0745123456', 'ion.popescu@contabilitate.com', 3500.00);
INSERT INTO CONTABILI (NUME, Data_Nasterii, CNP, TELEFON, EMAIL, SALARIU) VALUES
('Ionescu', TO_DATE('1990-02-20', 'YYYY-MM-DD'), '2234567890123', '0734987654', 'maria.ionescu@contabilitate.com', 4000.00);
INSERT INTO CONTABILI (NUME, Data_Nasterii, CNP, TELEFON, EMAIL, SALARIU) VALUES
('Georgescu', TO_DATE('1985-05-10', 'YYYY-MM-DD'), '3234567890124', '0723546987', 'alexandru.georgescu@contabilitate.com', 4500.00);
INSERT INTO CONTABILI (NUME, Data_Nasterii, CNP, TELEFON, EMAIL, SALARIU) VALUES
('Marinescu', TO_DATE('1978-07-25', 'YYYY-MM-DD'), '4234567890123', '0742654789', 'elena.marinescu@contabilitate.com', 3800.00);
INSERT INTO CONTABILI (NUME, Data_Nasterii, CNP, TELEFON, EMAIL, SALARIU) VALUES
('Vasilescu', TO_DATE('1983-11-05', 'YYYY-MM-DD'), '5234567890123', '0734112233', 'cristina.vasilescu@contabilitate.com', 4100.00);
INSERT INTO CONTABILI (NUME, Data_Nasterii, CNP, TELEFON, EMAIL, SALARIU) VALUES
('Dumitrescu', TO_DATE('1992-08-18', 'YYYY-MM-DD'), '6234567890123', '0755332211', 'dan.dumitrescu@contabilitate.com', 4200.00);
INSERT INTO CONTABILI (NUME, Data_Nasterii, CNP, TELEFON, EMAIL, SALARIU) VALUES
('Radu', TO_DATE('1986-03-11', 'YYYY-MM-DD'), '7234567890123', '0765432123', 'ioana.radu@contabilitate.com', 4300.00);
INSERT INTO CONTABILI (NUME, Data_Nasterii, CNP, TELEFON, EMAIL, SALARIU) VALUES
('Stoica', TO_DATE('1980-09-30', 'YYYY-MM-DD'), '8234567890123', '0732334455', 'mihai.stoica@contabilitate.com', 4400.00);
INSERT INTO CONTABILI (NUME, Data_Nasterii, CNP, TELEFON, EMAIL, SALARIU) VALUES
('Niculae', TO_DATE('1991-12-12', 'YYYY-MM-DD'), '9234567890123', '0724112233', 'andrei.niculae@contabilitate.com', 3500.00);
INSERT INTO CONTABILI (NUME, Data_Nasterii, CNP, TELEFON, EMAIL, SALARIU) VALUES
('Lazar', TO_DATE('1988-04-08', 'YYYY-MM-DD'), '1023456789012', '0734778899', 'gabriela.lazar@contabilitate.com', 4600.00);
INSERT INTO CONTABILI (NUME, Data_Nasterii, CNP, TELEFON, EMAIL, SALARIU) VALUES
('Preda', TO_DATE('1994-06-17', 'YYYY-MM-DD'), '1123456789012', '0744667788', 'daniel.preda@contabilitate.com', 4700.00);
INSERT INTO CONTABILI (NUME, Data_Nasterii, CNP, TELEFON, EMAIL, SALARIU) VALUES
('Iliescu', TO_DATE('1981-10-30', 'YYYY-MM-DD'), '1223456789012', '0723987654', 'anca.iliescu@contabilitate.com', 3900.00);
INSERT INTO CONTABILI (NUME, Data_Nasterii, CNP, TELEFON, EMAIL, SALARIU) VALUES
('Morar', TO_DATE('1989-02-25', 'YYYY-MM-DD'), '1323456789012', '0744556677', 'victor.morar@contabilitate.com', 3800.00);
INSERT INTO CONTABILI (NUME, Data_Nasterii, CNP, TELEFON, EMAIL, SALARIU) VALUES
('Tudor', TO_DATE('1993-05-17', 'YYYY-MM-DD'), '1423456789012', '0733998877', 'simona.tudor@contabilitate.com', 4200.00);
INSERT INTO CONTABILI (NUME, Data_Nasterii, CNP, TELEFON, EMAIL, SALARIU) VALUES
('Matei', TO_DATE('1987-09-14', 'YYYY-MM-DD'), '1523456789012', '0723344556', 'razvan.matei@contabilitate.com', 4500.00);
INSERT INTO CONTABILI (NUME, Data_Nasterii, CNP, TELEFON, EMAIL, SALARIU) VALUES
('Chirila', TO_DATE('1982-11-10', 'YYYY-MM-DD'), '1623456789012', '0766443322', 'adriana.chirila@contabilitate.com', 4600.00);
INSERT INTO CONTABILI (NUME, Data_Nasterii, CNP, TELEFON, EMAIL, SALARIU) VALUES
('Dobre', TO_DATE('1995-01-28', 'YYYY-MM-DD'), '1723456789012', '0744221133', 'florin.dobre@contabilitate.com', 4700.00);
INSERT INTO CONTABILI (NUME, Data_Nasterii, CNP, TELEFON, EMAIL, SALARIU) VALUES
('Popa', TO_DATE('1990-04-15', 'YYYY-MM-DD'), '1823456789012', '0755112233', 'carmen.popa@contabilitate.com', 4300.00);
INSERT INTO CONTABILI (NUME, Data_Nasterii, CNP, TELEFON, EMAIL, SALARIU) VALUES
('Enache', TO_DATE('1984-07-23', 'YYYY-MM-DD'), '1923456789012', '0733221144', 'oana.enache@contabilitate.com', 4400.00);
INSERT INTO CONTABILI (NUME, Data_Nasterii, CNP, TELEFON, EMAIL, SALARIU) VALUES
('Stefan', TO_DATE('1992-12-05', 'YYYY-MM-DD'), '2023456789012', '0723112233', 'catalin.stefan@contabilitate.com', 4800.00);


--ATRACTII_TURISTICE
INSERT INTO ATRACTII_TURISTICE (Id_Destinatie, NUME, TIP_ATRACTIE, PRET, DESCRIERE) VALUES (1, 'Colosseum', 'Istoric', 100, 'Amfiteatru antic din perioada romană');
INSERT INTO ATRACTII_TURISTICE (Id_Destinatie, NUME, TIP_ATRACTIE, PRET, DESCRIERE) VALUES (2, 'Turnul Eiffel', 'Arhitectural', 130, 'Simbol iconic al Franței și al Parisului');
INSERT INTO ATRACTII_TURISTICE (Id_Destinatie, NUME, TIP_ATRACTIE, PRET, DESCRIERE) VALUES (3, 'Piramidele din Giza', 'Istoric', 201, 'Structuri antice celebre ale faraonilor');
INSERT INTO ATRACTII_TURISTICE (Id_Destinatie, NUME, TIP_ATRACTIE, PRET, DESCRIERE) VALUES (4, 'Machu Picchu', 'Istoric', 80, 'Oraș antic al civilizației incașe');
INSERT INTO ATRACTII_TURISTICE (Id_Destinatie, NUME, TIP_ATRACTIE, PRET, DESCRIERE) VALUES (5, 'Statue of Liberty', 'Monument', 169, 'Simbol al libertății și democrației');
INSERT INTO ATRACTII_TURISTICE (Id_Destinatie, NUME, TIP_ATRACTIE, PRET, DESCRIERE) VALUES (6, 'Taj Mahal', 'Arhitectural', 321, 'Mausoleu iconic construit în memoria iubirii');
INSERT INTO ATRACTII_TURISTICE (Id_Destinatie, NUME, TIP_ATRACTIE, PRET, DESCRIERE) VALUES (7, 'Stonehenge', 'Istoric', 112, 'Cerc misterios de pietre antice');
INSERT INTO ATRACTII_TURISTICE (Id_Destinatie, NUME, TIP_ATRACTIE, PRET, DESCRIERE) VALUES (8, 'Opera din Sydney', 'Arhitectural', 35, 'Clădire iconică pentru spectacole artistice');
INSERT INTO ATRACTII_TURISTICE (Id_Destinatie, NUME, TIP_ATRACTIE, PRET, DESCRIERE) VALUES (9, 'Parcul Național Serengeti', 'Natural', 65, 'Habitat faimos pentru migrația animalelor sălbatice');
INSERT INTO ATRACTII_TURISTICE (Id_Destinatie, NUME, TIP_ATRACTIE, PRET, DESCRIERE) VALUES (10, 'Marele Canion', 'Natural', 312, 'Peisaj spectaculos format de râul Colorado');
INSERT INTO ATRACTII_TURISTICE (Id_Destinatie, NUME, TIP_ATRACTIE, PRET, DESCRIERE) VALUES (11, 'Cascada Niagara', 'Natural', 122, 'Cascadă renumită la granița SUA și Canada');
INSERT INTO ATRACTII_TURISTICE (Id_Destinatie, NUME, TIP_ATRACTIE, PRET, DESCRIERE) VALUES (12, 'Aurora Boreală', 'Natural', 134, 'Fenomen natural de lumini pe cerul nordic');
INSERT INTO ATRACTII_TURISTICE (Id_Destinatie, NUME, TIP_ATRACTIE, PRET, DESCRIERE) VALUES (13, 'Angkor Wat', 'Istoric', 66, 'Complex de temple din perioada Khmeră');
INSERT INTO ATRACTII_TURISTICE (Id_Destinatie, NUME, TIP_ATRACTIE, PRET, DESCRIERE) VALUES (14, 'Clădirea Burj Khalifa', 'Arhitectural', 677, 'Cea mai înaltă clădire din lume');
INSERT INTO ATRACTII_TURISTICE (Id_Destinatie, NUME, TIP_ATRACTIE, PRET, DESCRIERE) VALUES (15, 'Castelul Bran', 'Istoric', 56, 'Castel faimos asociat cu legenda lui Dracula');
INSERT INTO ATRACTII_TURISTICE (Id_Destinatie, NUME, TIP_ATRACTIE, PRET, DESCRIERE) VALUES (16, 'Insulele Galapagos', 'Natural', 67, 'Arhipelag renumit pentru biodiversitate');
INSERT INTO ATRACTII_TURISTICE (Id_Destinatie, NUME, TIP_ATRACTIE, PRET, DESCRIERE) VALUES (17, 'Muntele Fuji', 'Natural', 66, 'Vulcan iconic și simbol național');
INSERT INTO ATRACTII_TURISTICE (Id_Destinatie, NUME, TIP_ATRACTIE, PRET, DESCRIERE) VALUES (18, 'Acropole', 'Istoric', 46, 'Complex antic cu Parthenonul în centru');
INSERT INTO ATRACTII_TURISTICE (Id_Destinatie, NUME, TIP_ATRACTIE, PRET, DESCRIERE) VALUES (19, 'Podul Golden Gate', 'Arhitectural', 98, 'Pod suspendat iconic');
INSERT INTO ATRACTII_TURISTICE (Id_Destinatie, NUME, TIP_ATRACTIE, PRET, DESCRIERE) VALUES (20, 'Castelul Neuschwanstein', 'Istoric', 100, 'Castel de poveste în Bavaria');


--CLIENTI_PACHETE
INSERT INTO CLIENTI_PACHETE (ID_CLIENT, ID_PACHET) VALUES
(1, 1);
INSERT INTO CLIENTI_PACHETE (ID_CLIENT, ID_PACHET) VALUES
(2, 2);
INSERT INTO CLIENTI_PACHETE (ID_CLIENT, ID_PACHET) VALUES
(3, 3);
INSERT INTO CLIENTI_PACHETE (ID_CLIENT, ID_PACHET) VALUES
(4, 4);
INSERT INTO CLIENTI_PACHETE (ID_CLIENT, ID_PACHET) VALUES
(5, 5);
INSERT INTO CLIENTI_PACHETE (ID_CLIENT, ID_PACHET) VALUES
(6, 6);
INSERT INTO CLIENTI_PACHETE (ID_CLIENT, ID_PACHET) VALUES
(7, 7);
INSERT INTO CLIENTI_PACHETE (ID_CLIENT, ID_PACHET) VALUES
(8, 8);
INSERT INTO CLIENTI_PACHETE (ID_CLIENT, ID_PACHET) VALUES
(9, 9);
INSERT INTO CLIENTI_PACHETE (ID_CLIENT, ID_PACHET) VALUES
(10, 10);
INSERT INTO CLIENTI_PACHETE (ID_CLIENT, ID_PACHET) VALUES
(11, 11);
INSERT INTO CLIENTI_PACHETE (ID_CLIENT, ID_PACHET) VALUES
(12, 12);
INSERT INTO CLIENTI_PACHETE (ID_CLIENT, ID_PACHET) VALUES
(13, 13);
INSERT INTO CLIENTI_PACHETE (ID_CLIENT, ID_PACHET) VALUES
(14, 14);
INSERT INTO CLIENTI_PACHETE (ID_CLIENT, ID_PACHET) VALUES
(15, 15);
INSERT INTO CLIENTI_PACHETE (ID_CLIENT, ID_PACHET) VALUES
(1, 16);
INSERT INTO CLIENTI_PACHETE (ID_CLIENT, ID_PACHET) VALUES
(2, 17);
INSERT INTO CLIENTI_PACHETE (ID_CLIENT, ID_PACHET) VALUES
(3, 18);
INSERT INTO CLIENTI_PACHETE (ID_CLIENT, ID_PACHET) VALUES
(4, 19);
INSERT INTO CLIENTI_PACHETE (ID_CLIENT, ID_PACHET) VALUES
(5, 20);


--PACHETE_DESTINATII
INSERT INTO PACHETE_DESTINATII (ID_PACHET, ID_DESTINATIE) VALUES
(1, 1);
INSERT INTO PACHETE_DESTINATII (ID_PACHET, ID_DESTINATIE) VALUES
(2, 2);
INSERT INTO PACHETE_DESTINATII (ID_PACHET, ID_DESTINATIE) VALUES
(3, 3);
INSERT INTO PACHETE_DESTINATII (ID_PACHET, ID_DESTINATIE) VALUES
(4, 4);
INSERT INTO PACHETE_DESTINATII (ID_PACHET, ID_DESTINATIE) VALUES
(5, 5);
INSERT INTO PACHETE_DESTINATII (ID_PACHET, ID_DESTINATIE) VALUES
(6, 6);
INSERT INTO PACHETE_DESTINATII (ID_PACHET, ID_DESTINATIE) VALUES
(7, 7);
INSERT INTO PACHETE_DESTINATII (ID_PACHET, ID_DESTINATIE) VALUES
(8, 8);
INSERT INTO PACHETE_DESTINATII (ID_PACHET, ID_DESTINATIE) VALUES
(9, 9);
INSERT INTO PACHETE_DESTINATII (ID_PACHET, ID_DESTINATIE) VALUES
(10, 10);
INSERT INTO PACHETE_DESTINATII (ID_PACHET, ID_DESTINATIE) VALUES
(11, 11);
INSERT INTO PACHETE_DESTINATII (ID_PACHET, ID_DESTINATIE) VALUES
(12, 12);
INSERT INTO PACHETE_DESTINATII (ID_PACHET, ID_DESTINATIE) VALUES
(13, 13);
INSERT INTO PACHETE_DESTINATII (ID_PACHET, ID_DESTINATIE) VALUES
(14, 14);
INSERT INTO PACHETE_DESTINATII (ID_PACHET, ID_DESTINATIE) VALUES
(15, 15);
INSERT INTO PACHETE_DESTINATII (ID_PACHET, ID_DESTINATIE) VALUES
(16, 16);
INSERT INTO PACHETE_DESTINATII (ID_PACHET, ID_DESTINATIE) VALUES
(17, 17);
INSERT INTO PACHETE_DESTINATII (ID_PACHET, ID_DESTINATIE) VALUES
(18, 18);
INSERT INTO PACHETE_DESTINATII (ID_PACHET, ID_DESTINATIE) VALUES
(19, 19);
INSERT INTO PACHETE_DESTINATII (ID_PACHET, ID_DESTINATIE) VALUES
(20, 20);



--PLATI
-- INSERT INTO PLATI (Id_Client, Suma, Metoda_Plata, Data_Efectuare) VALUES
-- (1, 1500.00, 'Card', TO_DATE('2023-02-10', 'YYYY-MM-DD'));
-- INSERT INTO PLATI (Id_Client, Suma, Metoda_Plata, Data_Efectuare) VALUES
-- (2, 2000.00, 'Transfer bancar', TO_DATE('2023-03-15', 'YYYY-MM-DD'));
-- INSERT INTO PLATI (Id_Client, Suma, Metoda_Plata, Data_Efectuare) VALUES
-- (3, 1000.00, 'Cash', TO_DATE('2023-04-20', 'YYYY-MM-DD'));
-- INSERT INTO PLATI (Id_Client, Suma, Metoda_Plata, Data_Efectuare) VALUES
-- (4, 3000.00, 'Card', TO_DATE('2023-05-01', 'YYYY-MM-DD'));
-- INSERT INTO PLATI (Id_Client, Suma, Metoda_Plata, Data_Efectuare) VALUES
-- (5, 1200.00, 'Transfer bancar', TO_DATE('2023-06-10', 'YYYY-MM-DD'));
-- INSERT INTO PLATI (Id_Client, Suma, Metoda_Plata, Data_Efectuare) VALUES
-- (6, 2000.00, 'Cash', TO_DATE('2023-07-15', 'YYYY-MM-DD'));
-- INSERT INTO PLATI (Id_Client, Suma, Metoda_Plata, Data_Efectuare) VALUES
-- (7, 2500.00, 'Card', TO_DATE('2023-08-01', 'YYYY-MM-DD'));
-- INSERT INTO PLATI (Id_Client, Suma, Metoda_Plata, Data_Efectuare) VALUES
-- (8, 1800.00, 'Transfer bancar', TO_DATE('2023-09-20', 'YYYY-MM-DD'));
-- INSERT INTO PLATI (Id_Client, Suma, Metoda_Plata, Data_Efectuare) VALUES
-- (9, 2000.00, 'Cash', TO_DATE('2023-10-15', 'YYYY-MM-DD'));
-- INSERT INTO PLATI (Id_Client, Suma, Metoda_Plata, Data_Efectuare) VALUES
-- (10, 1700.00, 'Card', TO_DATE('2023-11-01', 'YYYY-MM-DD'));
-- INSERT INTO PLATI (Id_Client, Suma, Metoda_Plata, Data_Efectuare) VALUES
-- (11, 1300.00, 'Transfer bancar', TO_DATE('2023-01-25', 'YYYY-MM-DD'));
-- INSERT INTO PLATI (Id_Client, Suma, Metoda_Plata, Data_Efectuare) VALUES
-- (12, 2200.00, 'Cash', TO_DATE('2023-02-28', 'YYYY-MM-DD'));
-- INSERT INTO PLATI (Id_Client, Suma, Metoda_Plata, Data_Efectuare) VALUES
-- (13, 2500.00, 'Card', TO_DATE('2023-03-15', 'YYYY-MM-DD'));
-- INSERT INTO PLATI (Id_Client, Suma, Metoda_Plata, Data_Efectuare) VALUES
-- (14, 3000.00, 'Transfer bancar', TO_DATE('2023-04-30', 'YYYY-MM-DD'));
-- INSERT INTO PLATI (Id_Client, Suma, Metoda_Plata, Data_Efectuare) VALUES
-- (15, 1500.00, 'Cash', TO_DATE('2023-05-20', 'YYYY-MM-DD'));
-- INSERT INTO PLATI (Id_Client, Suma, Metoda_Plata, Data_Efectuare) VALUES
-- (1, 1800.00, 'Card', TO_DATE('2023-06-25', 'YYYY-MM-DD'));
-- INSERT INTO PLATI (Id_Client, Suma, Metoda_Plata, Data_Efectuare) VALUES
-- (2, 2200.00, 'Transfer bancar', TO_DATE('2023-07-30', 'YYYY-MM-DD'));
-- INSERT INTO PLATI (Id_Client, Suma, Metoda_Plata, Data_Efectuare) VALUES
-- (3, 1500.00, 'Cash', TO_DATE('2023-08-25', 'YYYY-MM-DD'));
-- INSERT INTO PLATI (Id_Client, Suma, Metoda_Plata, Data_Efectuare) VALUES
-- (4, 2000.00, 'Card', TO_DATE('2023-09-15', 'YYYY-MM-DD'));
-- INSERT INTO PLATI (Id_Client, Suma, Metoda_Plata, Data_Efectuare) VALUES
-- (5, 3000.00, 'Transfer bancar', TO_DATE('2023-10-25', 'YYYY-MM-DD'));

--CONTRACTE
-- INSERT INTO CONTRACTE (ID_CLIENT, ID_CONTABIL, ID_PACHET, DATA_INCEPERE, DATA_TERMINARE, CONTINUT) VALUES
-- (1, 1, 1, TO_DATE('2023-01-10', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 'Contract de rezeravre a unui pachet turistic');
-- INSERT INTO CONTRACTE (ID_CLIENT, ID_CONTABIL, ID_PACHET, DATA_INCEPERE, DATA_TERMINARE, CONTINUT) VALUES
-- (2, 2, 2, TO_DATE('2023-02-15', 'YYYY-MM-DD'), TO_DATE('2023-11-30', 'YYYY-MM-DD'), 'Contract de rezeravre a unui pachet turistic');
-- INSERT INTO CONTRACTE (ID_CLIENT, ID_CONTABIL, ID_PACHET, DATA_INCEPERE, DATA_TERMINARE, CONTINUT) VALUES
-- (3, 3, 3, TO_DATE('2023-03-20', 'YYYY-MM-DD'), TO_DATE('2023-09-15', 'YYYY-MM-DD'), 'Contract de rezeravre a unui pachet turistic');
-- INSERT INTO CONTRACTE (ID_CLIENT, ID_CONTABIL, ID_PACHET, DATA_INCEPERE, DATA_TERMINARE, CONTINUT) VALUES
-- (4, 4, 4, TO_DATE('2023-04-01', 'YYYY-MM-DD'), TO_DATE('2023-12-01', 'YYYY-MM-DD'), 'Contract de rezeravre a unui pachet turistic');
-- INSERT INTO CONTRACTE (ID_CLIENT, ID_CONTABIL, ID_PACHET, DATA_INCEPERE, DATA_TERMINARE, CONTINUT) VALUES
-- (5, 5, 5, TO_DATE('2023-05-10', 'YYYY-MM-DD'), TO_DATE('2023-10-20', 'YYYY-MM-DD'), 'Contract de rezeravre a unui pachet turistic');
-- INSERT INTO CONTRACTE (ID_CLIENT, ID_CONTABIL, ID_PACHET, DATA_INCEPERE, DATA_TERMINARE, CONTINUT) VALUES
-- (6, 6, 6, TO_DATE('2023-06-15', 'YYYY-MM-DD'), TO_DATE('2023-12-15', 'YYYY-MM-DD'), 'Contract de rezeravre a unui pachet turistic');
-- INSERT INTO CONTRACTE (ID_CLIENT, ID_CONTABIL, ID_PACHET, DATA_INCEPERE, DATA_TERMINARE, CONTINUT) VALUES
-- (7, 7, 7, TO_DATE('2023-07-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 'Contract de rezeravre a unui pachet turistic');
-- INSERT INTO CONTRACTE (ID_CLIENT, ID_CONTABIL, ID_PACHET, DATA_INCEPERE, DATA_TERMINARE, CONTINUT) VALUES
-- (8, 8, 8, TO_DATE('2023-08-20', 'YYYY-MM-DD'), TO_DATE('2023-12-10', 'YYYY-MM-DD'), 'Contract de rezeravre a unui pachet turistic');
-- INSERT INTO CONTRACTE (ID_CLIENT, ID_CONTABIL, ID_PACHET, DATA_INCEPERE, DATA_TERMINARE, CONTINUT) VALUES
-- (9, 9, 9, TO_DATE('2023-09-15', 'YYYY-MM-DD'), TO_DATE('2023-12-20', 'YYYY-MM-DD'), 'Contract de rezeravre a unui pachet turistic');
-- INSERT INTO CONTRACTE (ID_CLIENT, ID_CONTABIL, ID_PACHET, DATA_INCEPERE, DATA_TERMINARE, CONTINUT) VALUES
-- (10, 10, 10, TO_DATE('2023-10-01', 'YYYY-MM-DD'), TO_DATE('2023-12-25', 'YYYY-MM-DD'), 'Contract de rezeravre a unui pachet turistic');
-- INSERT INTO CONTRACTE (ID_CLIENT, ID_CONTABIL, ID_PACHET, DATA_INCEPERE, DATA_TERMINARE, CONTINUT) VALUES
-- (11, 11, 11, TO_DATE('2023-01-20', 'YYYY-MM-DD'), TO_DATE('2023-11-30', 'YYYY-MM-DD'), 'Contract de rezeravre a unui pachet turistic');
-- INSERT INTO CONTRACTE (ID_CLIENT, ID_CONTABIL, ID_PACHET, DATA_INCEPERE, DATA_TERMINARE, CONTINUT) VALUES
-- (12, 12, 12, TO_DATE('2023-02-25', 'YYYY-MM-DD'), TO_DATE('2023-12-15', 'YYYY-MM-DD'), 'Contract de rezeravre a unui pachet turistic');
-- INSERT INTO CONTRACTE (ID_CLIENT, ID_CONTABIL, ID_PACHET, DATA_INCEPERE, DATA_TERMINARE, CONTINUT) VALUES
-- (13, 13, 13, TO_DATE('2023-03-10', 'YYYY-MM-DD'), TO_DATE('2023-12-20', 'YYYY-MM-DD'), 'Contract de rezeravre a unui pachet turistic');
-- INSERT INTO CONTRACTE (ID_CLIENT, ID_CONTABIL, ID_PACHET, DATA_INCEPERE, DATA_TERMINARE, CONTINUT) VALUES
-- (14, 14, 14, TO_DATE('2023-04-25', 'YYYY-MM-DD'), TO_DATE('2023-12-05', 'YYYY-MM-DD'), 'Contract de rezeravre a unui pachet turistic');
-- INSERT INTO CONTRACTE (ID_CLIENT, ID_CONTABIL, ID_PACHET, DATA_INCEPERE, DATA_TERMINARE, CONTINUT) VALUES
-- (15, 15, 15, TO_DATE('2023-05-05', 'YYYY-MM-DD'), TO_DATE('2023-12-01', 'YYYY-MM-DD'), 'Contract de rezeravre a unui pachet turistic');
-- INSERT INTO CONTRACTE (ID_CLIENT, ID_CONTABIL, ID_PACHET, DATA_INCEPERE, DATA_TERMINARE, CONTINUT) VALUES
-- (1, 16, 16, TO_DATE('2023-06-10', 'YYYY-MM-DD'), TO_DATE('2023-12-20', 'YYYY-MM-DD'), 'Contract de rezeravre a unui pachet turistic');
-- INSERT INTO CONTRACTE (ID_CLIENT, ID_CONTABIL, ID_PACHET, DATA_INCEPERE, DATA_TERMINARE, CONTINUT) VALUES
-- (2, 17, 17, TO_DATE('2023-07-20', 'YYYY-MM-DD'), TO_DATE('2023-12-25', 'YYYY-MM-DD'), 'Contract de rezeravre a unui pachet turistic');
-- INSERT INTO CONTRACTE (ID_CLIENT, ID_CONTABIL, ID_PACHET, DATA_INCEPERE, DATA_TERMINARE, CONTINUT) VALUES
-- (3, 18, 18, TO_DATE('2023-08-10', 'YYYY-MM-DD'), TO_DATE('2023-12-15', 'YYYY-MM-DD'), 'Contract de rezeravre a unui pachet turistic');
-- INSERT INTO CONTRACTE (ID_CLIENT, ID_CONTABIL, ID_PACHET, DATA_INCEPERE, DATA_TERMINARE, CONTINUT) VALUES
-- (4, 19, 19, TO_DATE('2023-09-05', 'YYYY-MM-DD'), TO_DATE('2023-12-10', 'YYYY-MM-DD'), 'Contract de rezeravre a unui pachet turistic');
-- INSERT INTO CONTRACTE (ID_CLIENT, ID_CONTABIL, ID_PACHET, DATA_INCEPERE, DATA_TERMINARE, CONTINUT) VALUES
-- (5, 20, 20, TO_DATE('2023-10-20', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 'Contract de rezeravre a unui pachet turistic');


--Exercitiul 6

CREATE OR REPLACE PROCEDURE RAPORT_VANZARI(DATA_INCEPUT DATE, DATA_SFARSIT DATE) IS
    TYPE T_CLIENTI IS TABLE OF NUMBER INDEX BY VARCHAR2(100); --PT CLIENTI SI NR DE PACHETE CUMPARATE
    TYPE REC1 IS RECORD (
        ID_PACHET PACHETE_TURISTICE.ID_PACHET%TYPE,
        NR_CLIENTI NUMBER
    );
    TYPE REC2 IS RECORD (
        ID_PACHET PACHETE_TURISTICE.ID_PACHET%TYPE,
        VENIT_TOTAL NUMBER
    );
    TYPE T_PACHETE IS TABLE OF REC1; 
    TYPE T_VENITURI IS TABLE OF REC2;
    TYPE VECTOR IS VARRAY(3) OF CLIENTI.NUME%TYPE;

    TAB_CLIENTI T_CLIENTI;
    TAB_PACHETE T_PACHETE := T_PACHETE();
    TAB_VENITURI T_VENITURI := T_VENITURI();
    LOIALITATE VECTOR := VECTOR();
    VENITURI_PACHET NUMBER;
    NUME_CLIENT VARCHAR2(100);
    TOTAL_INCASARI NUMBER := 0;

BEGIN

    DBMS_OUTPUT.PUT_LINE('------RAPORT VANZARI-----PERIOADA: '|| DATA_INCEPUT || ' - ' || DATA_SFARSIT || '------');
    DBMS_OUTPUT.NEW_LINE;
    --DICTIONAR (NR PACHETE CUMPARATE : NUME_CLIENT)
    FOR I IN (SELECT c.NUME, COUNT(*) AS NR_PACHETE_CUMPARATE
                FROM CLIENTI c
                JOIN CLIENTI_PACHETE cp ON c.ID_CLIENT = cp.ID_CLIENT 
                JOIN PACHETE_TURISTICE pt ON cp.ID_PACHET = pt.ID_PACHET
                JOIN CONTRACTE ct ON c.ID_CLIENT = ct.ID_CLIENT AND ct.ID_PACHET = pt.ID_PACHET
                WHERE ct.DATA_INCEPERE >= DATA_INCEPUT AND ct.DATA_TERMINARE <= DATA_SFARSIT
                GROUP BY c.NUME
                ORDER BY NR_PACHETE_CUMPARATE DESC) LOOP
    
    TAB_CLIENTI(I.NUME) := I.NR_PACHETE_CUMPARATE;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('CLIENTII SI NUMARUL DE PACHETE ACHIZITIONATE:');
    DBMS_OUTPUT.NEW_LINE;
    NUME_CLIENT := TAB_CLIENTI.FIRST;
    WHILE NUME_CLIENT IS NOT NULL LOOP
        DBMS_OUTPUT.PUT_LINE('  * ' || NUME_CLIENT || ' a achizitionat ' || TAB_CLIENTI(NUME_CLIENT) || ' pachete');
        NUME_CLIENT := TAB_CLIENTI.NEXT(NUME_CLIENT);
    END LOOP; 

    --CELE MAI CUMPARATE 5 PACHETE (DUPA NR DE CONTRACTE) 
    FOR I IN (
        SELECT pt.ID_PACHET AS ID_PACHET, COUNT(*) AS NR_CONTRACTE
        FROM PACHETE_TURISTICE pt
        JOIN CONTRACTE ct ON pt.ID_PACHET = ct.ID_PACHET
        WHERE ct.DATA_INCEPERE >= DATA_INCEPUT AND ct.DATA_TERMINARE <= DATA_SFARSIT
        GROUP BY pt.ID_PACHET
        ORDER BY NR_CONTRACTE DESC
    ) LOOP
        TAB_PACHETE.EXTEND;
        TAB_PACHETE(TAB_PACHETE.LAST).ID_PACHET := I.ID_PACHET;
        TAB_PACHETE(TAB_PACHETE.LAST).NR_CLIENTI := I.NR_CONTRACTE;
    END LOOP;
    DBMS_OUTPUT.NEW_LINE;
    DBMS_OUTPUT.PUT_LINE('CELE MAI CUMPARATE 5 PACHETE:');
    DBMS_OUTPUT.NEW_LINE;
    IF TAB_PACHETE.COUNT > 0 THEN
        FOR I IN 1..5 LOOP
                DBMS_OUTPUT.PUT_LINE('  * Pachetul cu ID-ul ' || TAB_PACHETE(I).ID_PACHET || ' a fost achizitionat de ' || TAB_PACHETE(I).NR_CLIENTI || ' de clienti');
        END LOOP;
    END IF;

    --VENITURI GENERATE DE FIECARE PACHET
    IF TAB_PACHETE.COUNT > 0 THEN
        FOR I IN TAB_PACHETE.FIRST..TAB_PACHETE.LAST LOOP
            SELECT (PRET - PRET * NVL(REDUCERE, 0)/100) AS VENIT 
            INTO VENITURI_PACHET
            FROM PACHETE_TURISTICE
            WHERE ID_PACHET = TAB_PACHETE(I).ID_PACHET;

            VENITURI_PACHET := VENITURI_PACHET * TAB_PACHETE(I).NR_CLIENTI;

            TAB_VENITURI.EXTEND;
            TAB_VENITURI(TAB_VENITURI.LAST).ID_PACHET := TAB_PACHETE(I).ID_PACHET;
            TAB_VENITURI(TAB_VENITURI.LAST).VENIT_TOTAL := VENITURI_PACHET;
        END LOOP;
    END IF;
    

    DBMS_OUTPUT.NEW_LINE;
    DBMS_OUTPUT.PUT_LINE('VENITURILE GENERATE DE FIECARE PACHET:');
    DBMS_OUTPUT.NEW_LINE;
    IF TAB_VENITURI.COUNT > 0 THEN
        FOR I IN TAB_VENITURI.FIRST..TAB_VENITURI.LAST LOOP
            TOTAL_INCASARI := TOTAL_INCASARI + TAB_VENITURI(I).VENIT_TOTAL;
            DBMS_OUTPUT.PUT_LINE('  * Pachetul cu ID-ul ' || TAB_VENITURI(I).ID_PACHET || ' a generat venituri in valoare de ' || TAB_VENITURI(I).VENIT_TOTAL || ' lei');
        END LOOP;
    END IF;

    DBMS_OUTPUT.NEW_LINE;
    DBMS_OUTPUT.PUT_LINE('INCASARILE TOTALE DIN VANZAREA DE PACHETE: ' || TOTAL_INCASARI || ' lei');
    DBMS_OUTPUT.NEW_LINE;

    --TOP 3 CEI MAI LOIALI CLIENTI
    DBMS_OUTPUT.PUT_LINE('TOP 3 CEI MAI LOIALI CLIENTI:');
    FOR I IN (SELECT *
                FROM (
                    SELECT c.NUME
                    FROM CLIENTI c
                    JOIN PROGRAME_LOIALITATE pl ON c.ID_CLIENT = pl.ID_CLIENT
                    ORDER BY pl.PUNCTE_LOIALITATE DESC
                    ) 
                WHERE ROWNUM <= 3) LOOP
        LOIALITATE.EXTEND;
        LOIALITATE(LOIALITATE.LAST) := I.NUME;
    END LOOP;

    IF LOIALITATE.COUNT > 0 THEN
        FOR I IN LOIALITATE.FIRST..LOIALITATE.LAST LOOP
            DBMS_OUTPUT.PUT_LINE('  * ' || LOIALITATE(I));
        END LOOP;
    END IF;
END;
/

BEGIN
    RAPORT_VANZARI('10/01/23', '12/01/25');
END;


--Exercitiul 7

CREATE OR REPLACE PROCEDURE ATRACTII(V_ID_CLIENT CLIENTI.ID_CLIENT%TYPE) AS
    TYPE REFCUROS IS REF CURSOR;
    CURSOR C1 IS
        SELECT p.ID_PACHET, CURSOR (
            SELECT a.NUME
            FROM ATRACTII_TURISTICE a
            JOIN DESTINATII d ON a.ID_DESTINATIE = d.ID_DESTINATIE
            JOIN PACHETE_DESTINATII pd ON d.ID_DESTINATIE = pd.ID_DESTINATIE
            WHERE pd.ID_PACHET = p.ID_PACHET
        )
        FROM PACHETE_TURISTICE p
        JOIN CLIENTI_PACHETE cp ON p.ID_PACHET = cp.ID_PACHET
        WHERE cp.ID_CLIENT = V_ID_CLIENT;
    
    CURSOR C_GHIZI (P_ID_PACHET PACHETE_TURISTICE.ID_PACHET%TYPE) IS
        SELECT g.NUME
        FROM GHIZI g
        JOIN PACHETE_TURISTICE p ON g.ID_GHID = p.ID_GHID
        WHERE p.ID_PACHET = P_ID_PACHET;

    C2 REFCUROS;

    V_ID_PACHET PACHETE_TURISTICE.ID_PACHET%TYPE;
    V_ATRACTIE ATRACTII_TURISTICE.NUME%TYPE;
    NUME_GHID GHIZI.NUME%TYPE;
BEGIN
    OPEN C1;
    FETCH C1 INTO V_ID_PACHET, C2;
    IF C1%NOTFOUND THEN
        RAISE NO_DATA_FOUND;
    END IF;
    CLOSE C1;
    OPEN C1;
    LOOP
        FETCH C1 INTO V_ID_PACHET, C2;
    EXIT WHEN C1%NOTFOUND;
        --PRELUAM GHIDUL
        OPEN C_GHIZI(V_ID_PACHET);
        FETCH C_GHIZI INTO NUME_GHID;
        CLOSE C_GHIZI;
        FETCH C2 INTO V_ATRACTIE;
        IF C2%NOTFOUND THEN
            DBMS_OUTPUT.PUT_LINE('Nu exista actractii turistice de vizitat pentru pachetul ' || V_ID_PACHET || '. Coordonat de ghidul ' || NUME_GHID);
        ELSE
            DBMS_OUTPUT.PUT_LINE('  * Pachetul ' || V_ID_PACHET || ', coordonat de ghidul ' || NUME_GHID || ', se pot vizita atractiile turistice: ');
            DBMS_OUTPUT.PUT_LINE('      ' || V_ATRACTIE);
            LOOP
                FETCH C2 INTO V_ATRACTIE;
            EXIT WHEN C2%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE('  ' || V_ATRACTIE);
            END LOOP;
        END IF;
    END LOOP;
    CLOSE C1;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista pachete turistice achizitionate de acest client.');
END;
/

DECLARE
    CURSOR C_CLIENTI IS
        SELECT ID_CLIENT, NUME
        FROM CLIENTI; 
BEGIN
    FOR I IN C_CLIENTI LOOP
        DBMS_OUTPUT.NEW_LINE;
        DBMS_OUTPUT.PUT_LINE('Clientul ' || I.NUME || ' a achizitionat urmatoarele pachete turistice: ');   
        ATRACTII(I.ID_CLIENT);
    END LOOP;
END;

--Exercitiul 8

CREATE OR REPLACE PACKAGE SELECTARE_CAZARE AS
    TYPE REC_CAZARI IS RECORD (
        ID_CAZARE CAZARI.ID_CAZARE%TYPE,
        TIP_CAZARE CAZARI.TIP_CAZARE%TYPE,
        NUME_CAZARE CAZARI.NUME%TYPE,
        STELE CAZARI.STELE%TYPE,
        PRET CAZARI.PRET%TYPE
    );
    TYPE T_CAZARI IS TABLE OF REC_CAZARI;
    EXCEPTIE EXCEPTION;

    FUNCTION AFISEAZA_CAZARI(V_ID_PACHET PACHETE_TURISTICE.ID_PACHET%TYPE) 
    RETURN T_CAZARI;

    PROCEDURE ALEGE_CAZARE(V_ID_PACHET PACHETE_TURISTICE.ID_PACHET%TYPE, OPTIUNE NUMBER);

    PROCEDURE AFISEAZA_DETALII_CAZARE(V_NUME CAZARI.NUME%TYPE);
END SELECTARE_CAZARE;
/
CREATE OR REPLACE PACKAGE BODY SELECTARE_CAZARE AS
    --functia care afiseaza cazarile disponibile pentru un pachet
    FUNCTION AFISEAZA_CAZARI(V_ID_PACHET PACHETE_TURISTICE.ID_PACHET%TYPE)
    RETURN T_CAZARI IS
        TAB_CAZARI T_CAZARI := T_CAZARI();
    BEGIN
        SELECT c.ID_CAZARE, c.TIP_CAZARE, c.NUME, c.STELE, c.PRET 
        BULK COLLECT INTO TAB_CAZARI
        FROM CAZARI c
        JOIN DESTINATII d ON c.ID_DESTINATIE = d.ID_DESTINATIE
        JOIN PACHETE_DESTINATII pd ON d.ID_DESTINATIE = pd.ID_DESTINATIE
        WHERE pd.ID_PACHET = V_ID_PACHET;
    
        IF TAB_CAZARI.COUNT = 0 THEN
            RAISE NO_DATA_FOUND;

        END IF;
        DBMS_OUTPUT.PUT_LINE('Puteti alege din urmatoarele cazari: ');
        DBMS_OUTPUT.NEW_LINE;
        FOR I IN TAB_CAZARI.FIRST..TAB_CAZARI.LAST LOOP
            DBMS_OUTPUT.PUT_LINE(' * Varianta ' || I);
            DBMS_OUTPUT.PUT_LINE('    Tip cazare: ' || TAB_CAZARI(I).TIP_CAZARE);
            DBMS_OUTPUT.PUT_LINE('    Nume: ' || TAB_CAZARI(I).NUME_CAZARE);
            DBMS_OUTPUT.PUT_LINE('    Stele: ' || TAB_CAZARI(I).STELE);
            DBMS_OUTPUT.PUT_LINE('    Pret: ' || TAB_CAZARI(I).PRET);
            DBMS_OUTPUT.NEW_LINE;
        END LOOP;

        RETURN TAB_CAZARI;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Nu exista cazari disponibile pentru acest pachet.');
            RETURN TAB_CAZARI;
    END AFISEAZA_CAZARI;
    --afiseaza cazarea alesa si o introduce in pachet
    PROCEDURE ALEGE_CAZARE(V_ID_PACHET PACHETE_TURISTICE.ID_PACHET%TYPE, OPTIUNE NUMBER) IS
        TAB_CAZARI T_CAZARI;
    BEGIN
        TAB_CAZARI := AFISEAZA_CAZARI(V_ID_PACHET);
        IF OPTIUNE < 1 OR OPTIUNE > TAB_CAZARI.COUNT THEN
            RAISE EXCEPTIE;
        END IF;
        DBMS_OUTPUT.PUT_LINE('Ati ales cazarea: ');
        DBMS_OUTPUT.PUT_LINE(' * Tip cazare: ' || TAB_CAZARI(OPTIUNE).TIP_CAZARE);
        DBMS_OUTPUT.PUT_LINE(' * Nume: ' || TAB_CAZARI(OPTIUNE).NUME_CAZARE);
        DBMS_OUTPUT.PUT_LINE(' * Stele: ' || TAB_CAZARI(OPTIUNE).STELE);
        DBMS_OUTPUT.PUT_LINE(' * Pret: ' || TAB_CAZARI(OPTIUNE).PRET);
    
        UPDATE PACHETE_TURISTICE
        SET ID_CAZARE = TAB_CAZARI(OPTIUNE).ID_CAZARE
        WHERE ID_PACHET = V_ID_PACHET;    
    EXCEPTION
        WHEN EXCEPTIE THEN
            DBMS_OUTPUT.PUT_LINE('Optiunea aleasa nu este valida.');
    END ALEGE_CAZARE;

    --PROCEDURA CARE PERMITE AFISAREA DETALIILOR UNEI CAZARI
    PROCEDURE AFISEAZA_DETALII_CAZARE(V_NUME CAZARI.NUME%TYPE) AS
        DETALII_CAZARE REC_CAZARI;
        V_ADRESA CAZARI.ADRESA%TYPE;
        TYPE CURSOR_DINAMIC IS REF CURSOR;
        C1 CURSOR_DINAMIC;
        I NUMBER := 1;
    BEGIN
        SELECT c.ID_CAZARE, c.TIP_CAZARE, c.NUME, c.STELE, c.PRET, c.ADRESA
        INTO DETALII_CAZARE.ID_CAZARE, DETALII_CAZARE.TIP_CAZARE, DETALII_CAZARE.NUME_CAZARE, DETALII_CAZARE.STELE, DETALII_CAZARE.PRET, V_ADRESA
        FROM CAZARI c
        WHERE c.NUME = V_NUME;

        DBMS_OUTPUT.PUT_LINE('Detalii cazare: ');
        DBMS_OUTPUT.PUT_LINE(' * Tip cazare: ' || DETALII_CAZARE.TIP_CAZARE);
        DBMS_OUTPUT.PUT_LINE(' * Nume: ' || DETALII_CAZARE.NUME_CAZARE);
        DBMS_OUTPUT.PUT_LINE(' * Stele: ' || DETALII_CAZARE.STELE);
        DBMS_OUTPUT.PUT_LINE(' * Pret: ' || DETALII_CAZARE.PRET);
        DBMS_OUTPUT.PUT_LINE(' * Adresa: ' || V_ADRESA);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Cazarea nu exista in baza de date.');
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Exista mai multe cazari cu acelasi nume.');
            OPEN C1 FOR SELECT ID_CAZARE, TIP_CAZARE, NUME, STELE, PRET, ADRESA
                        FROM CAZARI 
                        WHERE NUME = V_NUME;
            LOOP
                FETCH C1 INTO DETALII_CAZARE.ID_CAZARE, DETALII_CAZARE.TIP_CAZARE, DETALII_CAZARE.NUME_CAZARE, DETALII_CAZARE.STELE, DETALII_CAZARE.PRET, V_ADRESA;
            EXIT WHEN C1%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE('Detalii cazare ' || I || ': ');
                DBMS_OUTPUT.PUT_LINE(' * Tip cazare: ' || DETALII_CAZARE.TIP_CAZARE);
                DBMS_OUTPUT.PUT_LINE(' * Nume: ' || DETALII_CAZARE.NUME_CAZARE);
                DBMS_OUTPUT.PUT_LINE(' * Stele: ' || DETALII_CAZARE.STELE);
                DBMS_OUTPUT.PUT_LINE(' * Pret: ' || DETALII_CAZARE.PRET);
                DBMS_OUTPUT.PUT_LINE(' * Adresa: ' || V_ADRESA);
                I := I + 1;
            END LOOP;
    END AFISEAZA_DETALII_CAZARE;
END SELECTARE_CAZARE;
/

--apelam functia ca sa vedem cazarile disponibile
DECLARE
    TAB_CAZARI SELECTARE_CAZARE.T_CAZARI;
BEGIN
    TAB_CAZARI := SELECTARE_CAZARE.AFISEAZA_CAZARI(1);
END;
--alegem o cazare
DECLARE
    OPTIUNE NUMBER := '&OPTIUNE';
BEGIN
    SELECTARE_CAZARE.ALEGE_CAZARE(1, OPTIUNE);
END;

SELECT p.ID_PACHET, c.NUME
FROM PACHETE_TURISTICE p, CAZARI c
WHERE p.ID_CAZARE = c.ID_CAZARE AND ID_PACHET = 1;
--DETALII DESPRE O CAZARE
BEGIN
    SELECTARE_CAZARE.AFISEAZA_DETALII_CAZARE('Hotel Eiffel');
END;
/
BEGIN
    SELECTARE_CAZARE.AFISEAZA_DETALII_CAZARE('Colosseum Inn');
END;
/
BEGIN
    SELECTARE_CAZARE.AFISEAZA_DETALII_CAZARE('abcd');
END;
/

--Exercitiul 9

CREATE OR REPLACE PROCEDURE MARESTE_SALARIU_ANGAJATI(P_DATA_INCEPUT CONTRACTE.DATA_INCEPERE%TYPE, P_DATA_SFRASIT CONTRACTE.DATA_TERMINARE%TYPE, X NUMBER) AS
    CURSOR C_GHIZI IS
        SELECT g.ID_GHID AS ID_GHID, g.NUME AS NUME_GHID, co.ID_CONTABIL AS ID_CONTABIL, co.NUME AS NUME_CONTABIL, SUM(p.SUMA) AS SUMA
        FROM GHIZI g
        JOIN PACHETE_TURISTICE pt ON g.ID_GHID = pt.ID_GHID
        JOIN CONTRACTE c ON pt.ID_PACHET = c.ID_PACHET
        JOIN CONTABILI co ON c.ID_CONTABIL = co.ID_CONTABIL
        JOIN PLATI p ON c.ID_CLIENT = p.ID_CLIENT
        WHERE c.DATA_INCEPERE >= P_DATA_INCEPUT AND c.DATA_TERMINARE <= P_DATA_SFRASIT
        GROUP BY g.ID_GHID, g.NUME, co.ID_CONTABIL, co.NUME
        ORDER BY SUM(p.SUMA) DESC;

     TYPE REC IS RECORD(
        ID GHIZI.ID_GHID%TYPE,
        SALARIU GHIZI.TARIF%TYPE
    );
    TYPE TABLOU_GHIZI IS TABLE OF GHIZI.NUME%TYPE INDEX BY PLS_INTEGER;
    TYPE TABLOU_CONTABILI IS TABLE OF CONTABILI.NUME%TYPE INDEX BY PLS_INTEGER;
    TYPE TABLOU_SALARII IS TABLE OF REC;
   
    T_GHIZI TABLOU_GHIZI; --ASIGURA CA NU O SA SE REPETE VREUN GHID SAU CONTABIL
    T_CONTABILI TABLOU_CONTABILI;
    ID PLS_INTEGER;
    NUME GHIZI.NUME%TYPE;
    V_SALARIU GHIZI.TARIF%TYPE;
    T_SALARII_GHIZI TABLOU_SALARII := TABLOU_SALARII();
    T_SALARII_CONTABILI TABLOU_SALARII := TABLOU_SALARII();
    V_SUMA NUMBER := -1;
    CT NUMBER := 0;
    EXCEPTIE1 EXCEPTION;
    EXCEPTIE2 EXCEPTION;
BEGIN
    --VERIFICAM DACA PERIOADA ESTE CORECTA
    IF P_DATA_INCEPUT > P_DATA_SFRASIT OR P_DATA_INCEPUT > SYSDATE OR P_DATA_SFRASIT > SYSDATE THEN
        RAISE EXCEPTIE2;
    END IF;

    --SALVAM SUMA MAXIMA
    FOR I IN C_GHIZI LOOP
        V_SUMA := I.SUMA;
        EXIT;
    END LOOP;
    --verificam daca exista date pentru perioada ceruta
    IF V_SUMA = -1 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Nu exista date pentru perioada ceruta.');
    END IF;

    FOR I IN C_GHIZI LOOP
        IF I.SUMA = V_SUMA THEN
            T_GHIZI(I.ID_GHID) := I.NUME_GHID;
            T_CONTABILI(I.ID_CONTABIL) := I.NUME_CONTABIL;
        END IF;
    END LOOP;
    --ghizi
    IF T_GHIZI.COUNT > 0 THEN
        ID := T_GHIZI.FIRST;
        
        WHILE ID IS NOT NULL LOOP
            NUME := T_GHIZI(ID);
            
            DBMS_OUTPUT.PUT_LINE('Ghid: ' || NUME);
            SELECT TARIF
            INTO V_SALARIU
            FROM GHIZI
            WHERE ID_GHID = ID;
            DBMS_OUTPUT.PUT_LINE('   Tarif vechi: ' || V_SALARIU);
            V_SALARIU := V_SALARIU + 0.1 * V_SALARIU; --marim cu 10%
            DBMS_OUTPUT.PUT_LINE('   Tarif nou: ' || V_SALARIU);
            
            T_SALARII_GHIZI.EXTEND;
            T_SALARII_GHIZI(T_SALARII_GHIZI.LAST).ID := ID;
            T_SALARII_GHIZI(T_SALARII_GHIZI.LAST).SALARIU := V_SALARIU;

            ID := T_GHIZI.NEXT(ID);
            CT := CT + 1;
        END LOOP;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nu exista ghizi');
    END IF;

    --contabili
    IF T_CONTABILI.COUNT > 0 THEN
        ID := T_CONTABILI.FIRST;
        
        WHILE ID IS NOT NULL LOOP
            NUME := T_CONTABILI(ID);
            
            DBMS_OUTPUT.PUT_LINE('Contabil: ' || NUME);
            SELECT SALARIU
            INTO V_SALARIU
            FROM CONTABILI
            WHERE ID_CONTABIL = ID;
            DBMS_OUTPUT.PUT_LINE('   Salariu vechi: ' || V_SALARIU);
            V_SALARIU := V_SALARIU + 0.1 * V_SALARIU; --marim cu 10%
            DBMS_OUTPUT.PUT_LINE('   Salariu nou: ' || V_SALARIU);
            
            T_SALARII_CONTABILI.EXTEND;
            T_SALARII_CONTABILI(T_SALARII_CONTABILI.LAST).ID := ID;
            T_SALARII_CONTABILI(T_SALARII_CONTABILI.LAST).SALARIU := V_SALARIU;

            ID := T_CONTABILI.NEXT(ID);
            CT := CT + 1;
        END LOOP;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nu exista contabili');
    END IF;
    
    --NU PUTEM SA MARIM SALARIILE PENTRU MAI MULT DE X ANGAJATI
    DBMS_OUTPUT.NEW_LINE;
    IF CT > X THEN
        RAISE EXCEPTIE1;
    END IF;

    FORALL I IN T_SALARII_GHIZI.FIRST..T_SALARII_GHIZI.LAST
        UPDATE GHIZI
        SET TARIF = T_SALARII_GHIZI(I).SALARIU
        WHERE ID_GHID = T_SALARII_GHIZI(I).ID;
    COMMIT;
    FORALL I IN T_SALARII_CONTABILI.FIRST..T_SALARII_CONTABILI.LAST
        UPDATE CONTABILI
        SET SALARIU = T_SALARII_CONTABILI(I).SALARIU
        WHERE ID_CONTABIL = T_SALARII_CONTABILI(I).ID;
    COMMIT;

EXCEPTION 
    WHEN EXCEPTIE1 THEN 
        DBMS_OUTPUT.PUT_LINE(CT || ' angajati indeplinesc cerintele pentru marirea salariului.');
        DBMS_OUTPUT.PUT_LINE('Nu putem mari salariile pentru mai mult de ' || X || ' angajati.');
    WHEN EXCEPTIE2 THEN
        DBMS_OUTPUT.PUT_LINE('Va rugam sa introduceti o perioada de timp valida.');

END;

DECLARE 
    EROARE EXCEPTION;
    PRAGMA EXCEPTION_INIT(EROARE, -20001);
BEGIN
    --MARESTE_SALARIU_ANGAJATI('01/12/23', '01/12/24', 3); --prea multe salarii de marit
    --MARESTE_SALARIU_ANGAJATI('01/12/23', '01/12/24', 9); --salariile s au marit cu succes
    -- MARESTE_SALARIU_ANGAJATI('01/12/23', '01/12/21', 9); --perioada invalida
    MARESTE_SALARIU_ANGAJATI('01/12/21', '01/12/21', 9); --nu exista date
EXCEPTION
    WHEN EROARE THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista date pentru perioada ceruta.');
END;


--Exercitiul 10

CREATE OR REPLACE PACKAGE GESTIONARE_PROGRAM AS
    TYPE REC IS RECORD(
        ID_CLIENT CLIENTI.ID_CLIENT%TYPE,
        ID_PACHET PACHETE_TURISTICE.ID_PACHET%TYPE
    );
    TYPE TABLOU IS TABLE OF REC;

    --LISTA CU CLIENTII SI PACHETETE CARE TREBUIE INTRODUSE IN TIMPUL PROGRAMULUI DE LUCRU
    DE_INSERAT TABLOU :=TABLOU();
END GESTIONARE_PROGRAM;
/
CREATE OR REPLACE PACKAGE BODY GESTIONARE_PROGRAM AS
    DE_INSERAT TABLOU := TABLOU();
END GESTIONARE_PROGRAM;
/
CREATE OR REPLACE PROCEDURE REZERVA_PACHET(V_ID_CLIENT CLIENTI.ID_CLIENT%TYPE, V_ID_PACHET PACHETE_TURISTICE.ID_PACHET%TYPE) AS
BEGIN
    --SALVAM DATELE DIN PROGRAMARE PENTRU A LE INTRODUCE IN TIMPUL PROGRAMULUI DE LUCRU
    GESTIONARE_PROGRAM.DE_INSERAT.EXTEND;
    GESTIONARE_PROGRAM.DE_INSERAT(GESTIONARE_PROGRAM.DE_INSERAT.LAST).ID_CLIENT := V_ID_CLIENT;
    GESTIONARE_PROGRAM.DE_INSERAT(GESTIONARE_PROGRAM.DE_INSERAT.LAST).ID_PACHET := V_ID_PACHET;
END;
/
--isereza contractele care au fost rezervate in afara programului
CREATE OR REPLACE PROCEDURE INSERARE_CONTRACTE_REZERVARI AS
BEGIN
    IF GESTIONARE_PROGRAM.DE_INSERAT.COUNT > 0 THEN
    
        FORALL I IN GESTIONARE_PROGRAM.DE_INSERAT.FIRST..GESTIONARE_PROGRAM.DE_INSERAT.LAST
            INSERT INTO CLIENTI_PACHETE(ID_CLIENT, ID_PACHET)
            VALUES(GESTIONARE_PROGRAM.DE_INSERAT(I).ID_CLIENT, GESTIONARE_PROGRAM.DE_INSERAT(I).ID_PACHET);
        COMMIT;

        DBMS_OUTPUT.PUT_LINE('Urmatoarele rezervari au fost introduse cu succes.');
        FOR I IN GESTIONARE_PROGRAM.DE_INSERAT.FIRST..GESTIONARE_PROGRAM.DE_INSERAT.LAST LOOP
            DBMS_OUTPUT.PUT_LINE('Client: ' || GESTIONARE_PROGRAM.DE_INSERAT(I).ID_CLIENT || ' Pachet: ' || GESTIONARE_PROGRAM.DE_INSERAT(I).ID_PACHET );
        END LOOP;
        --STREGEM TOATE rezervarile ca sa nu le introducem de mai multe ori
        GESTIONARE_PROGRAM.DE_INSERAT.DELETE;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nu exista rezervari.');
    END IF;

END;
/

CREATE OR REPLACE TRIGGER RESTRICTIE_CONTRACTE
    BEFORE INSERT OR UPDATE ON CONTRACTE
BEGIN
    IF (TO_CHAR(SYSDATE, 'HH24') NOT BETWEEN 8 AND 20) OR (TO_CHAR(SYSDATE, 'D') = 1) THEN
        RAISE_APPLICATION_ERROR(-20002, 'Suntem in afara programului de lucru.');
    --eroarea va opri insertul in contracte
    END IF;
END;
/

INSERT INTO CLIENTI_PACHETE(ID_CLIENT, ID_PACHET)
VALUES(10,11);

BEGIN
    INSERARE_CONTRACTE_REZERVARI;
END;

ROLLBACK;
BEGIN
    GESTIONARE_PROGRAM.DE_INSERAT.DELETE;
END;


--Exercitiul 11

--I)

--CONTRACTUL SE FINALIZEAZA DUPA 7 ZILE DE LA DATA DE INTOARCERE DIN CALATORIE
CREATE OR REPLACE PROCEDURE INSERARE_CONTRACT(V_ID_CLIENT CLIENTI.ID_CLIENT%TYPE, V_ID_PACHET PACHETE_TURISTICE.ID_PACHET%TYPE) AS
    V_DATA PACHETE_TURISTICE.DATA_INTOARCERE%TYPE;
    TYPE TABLOU IS TABLE OF CONTABILI.ID_CONTABIL%TYPE;
    T_CONTABILI TABLOU := TABLOU();
    I NUMBER;
    EXCEPTIE EXCEPTION;
BEGIN
    SELECT DATA_INTOARCERE
    INTO V_DATA
    FROM PACHETE_TURISTICE
    WHERE ID_PACHET = V_ID_PACHET;

    --ALEGEM UN CONTABIL RANDOM
    SELECT ID_CONTABIL
    BULK COLLECT INTO T_CONTABILI
    FROM CONTABILI;

    IF T_CONTABILI.COUNT = 0 THEN
        RAISE EXCEPTIE;
    END IF;

    I := DBMS_RANDOM.VALUE(1, T_CONTABILI.COUNT);

    INSERT INTO CONTRACTE(ID_CLIENT,ID_CONTABIL, ID_PACHET, DATA_INCEPERE, DATA_TERMINARE, CONTINUT)
    VALUES(V_ID_CLIENT, T_CONTABILI(I), V_ID_PACHET, SYSDATE, V_DATA + 7, 'Contract de rezervare pachet turistic');

EXCEPTION
    WHEN EXCEPTIE THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista contabili disponibili pentru a intocmi contractul');
END;
/
--CLIENTUL TREBUIE SA PLATEASCA PACHETUL
CREATE OR REPLACE PROCEDURE PLATESTE(V_ID_CLIENT CLIENTI.ID_CLIENT%TYPE, V_ID_PACHET PACHETE_TURISTICE.ID_PACHET%TYPE) AS
    SUMA_PLATA PACHETE_TURISTICE.PRET%TYPE;
BEGIN
    --SELECTAM PRETUL PACHETULUI
    SELECT (PRET - PRET*NVL(REDUCERE, 0)/100)
    INTO SUMA_PLATA
    FROM PACHETE_TURISTICE
    WHERE ID_PACHET = V_ID_PACHET;

    INSERT INTO PLATI(ID_CLIENT, SUMA, Metoda_Plata, DATA_EFECTUARE)
    VALUES(V_ID_CLIENT, SUMA_PLATA, 'CARD', SYSDATE);
END;
/
--CIENTUL PRIMESTE 10 PUNCTE LOIALITATE LA ACHIZITIONAREA UNUI PACHET
CREATE OR REPLACE PROCEDURE INCREMENTARE_PUNCTE_LOIALITATRE(V_ID_CLIENT CLIENTI.ID_CLIENT%TYPE) AS
BEGIN
    UPDATE PROGRAME_LOIALITATE pl
    SET pl.PUNCTE_LOIALITATE = pl.PUNCTE_LOIALITATE + 10
    WHERE pl.ID_CLIENT = V_ID_CLIENT;
END;
/
--ACTUALIZAM LOCURILE DISPONIBILE DIN PACHET
CREATE OR REPLACE PROCEDURE UPDATE_LOCURI_DISPONIBILE(V_ID_PACHET PACHETE_TURISTICE.ID_PACHET%TYPE) AS
    V_LOCURI_DISPONIBILE PACHETE_TURISTICE.LOCURI_DISPONIBILE%TYPE;
BEGIN
    SELECT LOCURI_DISPONIBILE
    INTO V_LOCURI_DISPONIBILE
    FROM PACHETE_TURISTICE
    WHERE ID_PACHET = V_ID_PACHET;

    IF V_LOCURI_DISPONIBILE <= 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Nu mai sunt locuri disponibile pentru acest pachet');
    END IF;

    UPDATE PACHETE_TURISTICE
    SET LOCURI_DISPONIBILE = LOCURI_DISPONIBILE - 1
    WHERE ID_PACHET = V_ID_PACHET;

END;
/
--AHIZITIONAREA UNUI PACHET
CREATE OR REPLACE TRIGGER TRIGGER_CONTRACTE
    AFTER INSERT ON CLIENTI_PACHETE
    FOR EACH ROW
DECLARE
    EXCEPTIE EXCEPTION;
    PRAGMA EXCEPTION_INIT(EXCEPTIE, -20001); --exceptia de la UPDATE_LOCURI
BEGIN
    --SALVAM REZERVAREA PENTRU A O INTRODUCE IN TIMPUL PROGRAMULUI DE LUCRU
    IF (TO_CHAR(SYSDATE, 'HH24') NOT BETWEEN 8 AND 20) OR (TO_CHAR(SYSDATE, 'D') = 1) THEN
        REZERVA_PACHET(:NEW.ID_CLIENT, :NEW.ID_PACHET); 
    END IF;

    UPDATE_LOCURI_DISPONIBILE(:NEW.ID_PACHET);
    INSERARE_CONTRACT(:NEW.ID_CLIENT, :NEW.ID_PACHET);
    PLATESTE(:NEW.ID_CLIENT, :NEW.ID_PACHET);
    INCREMENTARE_PUNCTE_LOIALITATRE(:NEW.ID_CLIENT);
    
EXCEPTION
    WHEN EXCEPTIE THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

INSERT INTO CLIENTI_PACHETE(ID_CLIENT, ID_PACHET)
VALUES(9,10);
COMMIT;
SELECT *
FROM CONTRACTE
WHERE ID_CLIENT = 9 AND ID_PACHET = 10;

SELECT COUNT(c.ID_CONTRACT) AS NR_PACHETE, p.PUNCTE_LOIALITATE, pl.SUMA
FROM CONTRACTE c, PROGRAME_LOIALITATE p, PLATI pl
WHERE c.ID_CLIENT = 9 AND p.ID_CLIENT = 9 AND pl.ID_CLIENT = 9
GROUP BY c.ID_CLIENT, p.PUNCTE_LOIALITATE, pl.SUMA;

--fara locuri
INSERT INTO CLIENTI_PACHETE(ID_CLIENT, ID_PACHET)
VALUES(10, 21);

ROLLBACK;



--II)

--CAND SE INTRODUCE UN NOU CLIENT IN BAZA DE DATE, ACESTA PRIMESTE UN PROGRAM DE LOIALITATE
CREATE OR REPLACE TRIGGER TRIGGER_CLIENTI
    AFTER INSERT OR DELETE ON CLIENTI
    FOR EACH ROW

BEGIN
    IF INSERTING THEN
        INSERT INTO PROGRAME_LOIALITATE(ID_CLIENT, PUNCTE_LOIALITATE)
        VALUES(:NEW.ID_CLIENT, 0);
    ELSIF DELETING THEN
        DELETE FROM PROGRAME_LOIALITATE
        WHERE ID_CLIENT = :OLD.ID_CLIENT;
    END IF;
END;
/

INSERT INTO CLIENTI (Nume, Data_Nasterii, CNP, Adresa, Telefon, Email)
VALUES ('Ion Marin', TO_DATE('1990-01-15', 'YYYY-MM-DD'), '1234567890123', 'Str. Mihai Eminescu 10', '0723456789', 'ion.popescu@gmail.com');

SELECT c.NUME, p.*
FROM PROGRAME_LOIALITATE p, CLIENTI c
WHERE p.ID_CLIENT = c.ID_CLIENT AND c.NUME = 'Ion Marin';


--III)

CREATE OR REPLACE PACKAGE REZOLVARE_MUTATING AS
    V_NUME CLIENTI.NUME%TYPE;
END REZOLVARE_MUTATING;
/
CREATE OR REPLACE TRIGGER UPDATE_EMAIL 
AFTER UPDATE OF EMAIL ON CLIENTI
FOR EACH ROW
DECLARE
    V_NUME CLIENTI.NUME%TYPE;
BEGIN
    -- SELECT NUME
    -- INTO V_NUME
    -- FROM CLIENTI
    -- WHERE ID_CLIENT = :NEW.ID_CLIENT;
    -- DBMS_OUTPUT.PUT_LINE('Clientul ' || V_NUME || ' si-a schimbat adresa de email');
    REZOLVARE_MUTATING.V_NUME := :NEW.NUME;
END;
/
CREATE OR REPLACE TRIGGER UPDATE_EMAIL2
AFTER UPDATE OF EMAIL ON CLIENTI
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Clientul ' || REZOLVARE_MUTATING.V_NUME || ' si-a schimbat adresa de email');
END;
/ 
UPDATE CLIENTI
SET EMAIL = 'ABCD@GMAIL.COM'
WHERE ID_CLIENT = 1;


--Exercitiul 12

CREATE SEQUENCE SEQ_URMARIRE START WITH 1;

CREATE TABLE URMARIRE (
    ID_URMARIRE NUMBER(5) DEFAULT SEQ_URMARIRE.NEXTVAL PRIMARY KEY ,
    NUME_UTILIZATOR VARCHAR2(30),
    NUME_TABEL VARCHAR2(30),
    DATA DATE
);

CREATE OR REPLACE TRIGGER TRIGGER_STERGERE 
    BEFORE DROP ON SCHEMA
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    IF ora_dict_obj_name IN ('CLIENTI', 'PLATI', 'CONTRACTE') THEN
        INSERT INTO URMARIRE(NUME_UTILIZATOR, NUME_TABEL, DATA)
        VALUES (USER, ora_dict_obj_name, SYSDATE);
        COMMIT;

        RAISE_APPLICATION_ERROR(-20003, 'Nu aveti permisiunea de a sterge acest tabel!');
    END IF;
END;


--Exercitiul 13

CREATE OR REPLACE PACKAGE TOMBOLA AS
    TYPE REC IS RECORD(
        ID_CLIENT CLIENTI.ID_CLIENT%TYPE,
        NUME CLIENTI.NUME%TYPE,
        ID_PACHET PACHETE_TURISTICE.ID_PACHET%TYPE,
        PUNCTE_LOIALITATE NUMBER
    );
    TYPE TAB_CASTIGATORI IS TABLE OF REC;
    TYPE TAB_CLIENTI IS TABLE OF CLIENTI%ROWTYPE;
    PARTICIPANTI_TOMBOLA TAB_CLIENTI := TAB_CLIENTI();
    T_CASTIGATORI TAB_CASTIGATORI := TAB_CASTIGATORI();

    --IN FUNCTE DE NR DE PUNCTE DE LOIALITATE SI DE RECENZII LASATE
    FUNCTION CALCULEAZA_REDUCERE(V_ID_CLIENT CLIENTI.ID_CLIENT%TYPE)
    RETURN NUMBER;--PROCENT
    --CASTIGATORUL PRIMESTE 100 PUNCTE DE LOIALITATE SI UN PACHET GRATUIT
    FUNCTION SELECTEAZA_CASTIGATOR 
    RETURN CLIENTI%ROWTYPE;

    PROCEDURE SELECTARE_LISTA_PARTICIPANTI;
    PROCEDURE ACTUALIZARE_PUNCTE(V_ID_CLIENT CLIENTI.ID_CLIENT%TYPE, V_NR_PUNCTE NUMBER);
    PROCEDURE INSERARE_PACHET(V_ID_CLIENT CLIENTI.ID_CLIENT%TYPE, V_ID_PACHET PACHETE_TURISTICE.ID_PACHET%TYPE);
    PROCEDURE RULEAZA_TOMBOLA;
END TOMBOLA;
/
CREATE OR REPLACE PACKAGE BODY TOMBOLA AS

    FUNCTION CALCULEAZA_REDUCERE(V_ID_CLIENT CLIENTI.ID_CLIENT%TYPE)
    RETURN NUMBER AS 
        V_PUNCTE NUMBER;
        NR_RECENZII NUMBER;
        REDUCERE NUMBER;
    BEGIN
        BEGIN
            SELECT PUNCTE_LOIALITATE
            INTO V_PUNCTE
            FROM PROGRAME_LOIALITATE
            WHERE ID_CLIENT = V_ID_CLIENT;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                V_PUNCTE := 0;
        END;

        BEGIN
            SELECT COUNT(*)
            INTO NR_RECENZII
            FROM RECENZII
            WHERE ID_CLIENT = V_ID_CLIENT;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                NR_RECENZII := 0;
        END;

        REDUCERE := V_PUNCTE * 0.1 + NR_RECENZII * 0.05;
        RETURN REDUCERE;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN 0;

    END CALCULEAZA_REDUCERE;

    --VOR PARTICIPA LA TOMBOLA CLIENTII CARE AU EFECTUAT PLATI IN VALOARE DE PESTE X LEI IN ULTIMELE 12 LUNI
    --SI AU PROCENTUL REDUCERII PESTE 2,5 (20 PUNCTE SI O RECENZIE)
    PROCEDURE SELECTARE_LISTA_PARTICIPANTI AS
        SUMA_PLATITA NUMBER;
    BEGIN
        FOR I IN (SELECT * FROM CLIENTI) LOOP
            
            BEGIN
                SELECT SUM(SUMA)
                INTO SUMA_PLATITA
                FROM PLATI 
                WHERE ID_CLIENT = I.ID_CLIENT AND DATA_EFECTUARE > ADD_MONTHS(SYSDATE, -12)
                GROUP BY ID_CLIENT;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    SUMA_PLATITA := 0;
            END;

            IF CALCULEAZA_REDUCERE(I.ID_CLIENT) >= 1 AND SUMA_PLATITA >= 500 THEN
                PARTICIPANTI_TOMBOLA.EXTEND;
                PARTICIPANTI_TOMBOLA(PARTICIPANTI_TOMBOLA.LAST) := I;
            END IF;
        END LOOP;
    END SELECTARE_LISTA_PARTICIPANTI;

    FUNCTION SELECTEAZA_CASTIGATOR
    RETURN CLIENTI%ROWTYPE AS
        I NUMBER;
    BEGIN
        IF PARTICIPANTI_TOMBOLA.COUNT > 0 THEN
            I := DBMS_RANDOM.VALUE(1, PARTICIPANTI_TOMBOLA.COUNT);
            RETURN PARTICIPANTI_TOMBOLA(I);
        ELSE
            RAISE_APPLICATION_ERROR(-20005, 'nU EXISTA PARTICIPANTI');
        END IF;

    END SELECTEAZA_CASTIGATOR;

    PROCEDURE ACTUALIZARE_PUNCTE(V_ID_CLIENT CLIENTI.ID_CLIENT%TYPE, V_NR_PUNCTE NUMBER) AS
    BEGIN
        UPDATE PROGRAME_LOIALITATE
        SET PUNCTE_LOIALITATE = PUNCTE_LOIALITATE + V_NR_PUNCTE
        WHERE ID_CLIENT = V_ID_CLIENT;
    END ACTUALIZARE_PUNCTE;

    PROCEDURE INSERARE_PACHET(V_ID_CLIENT CLIENTI.ID_CLIENT%TYPE, V_ID_PACHET PACHETE_TURISTICE.ID_PACHET%TYPE) AS
    BEGIN
        INSERT INTO CLIENTI_PACHETE(ID_CLIENT, ID_PACHET)
        VALUES(V_ID_CLIENT, V_ID_PACHET);

        DBMS_OUTPUT.PUT_LINE('AI CASTIGAT PACHETUL TURISTIC: ' || V_ID_PACHET || ' SI 100 PUNCTE DE LOIALITATE!');

        --STERGEM PLATA PTC PACHETUL A FOST CASTIGAT
        DELETE FROM PLATI
        WHERE ID_CLIENT = V_ID_CLIENT AND DATA_EFECTUARE = SYSDATE;

    END INSERARE_PACHET;

    PROCEDURE RULEAZA_TOMBOLA AS 
        TYPE T IS TABLE OF PACHETE_TURISTICE.ID_PACHET%TYPE;
        V_CASTIGATOR CLIENTI%ROWTYPE;
        V_ID_PACHET PACHETE_TURISTICE.ID_PACHET%TYPE;
        V_PACHETE T := T();
        J NUMBER;
        UNIQUE_CONSTRAINT EXCEPTION;
        PRAGMA EXCEPTION_INIT(UNIQUE_CONSTRAINT, -00001);
    BEGIN
        SELECTARE_LISTA_PARTICIPANTI;

        DBMS_OUTPUT.PUT_LINE('PARTICIPANTII SUNT: ');
        IF PARTICIPANTI_TOMBOLA.COUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('NU EXISTA PARTICIPANTI');
            RETURN;
        END IF;
        FOR I IN PARTICIPANTI_TOMBOLA.FIRST..PARTICIPANTI_TOMBOLA.LAST LOOP
            DBMS_OUTPUT.PUT_LINE('  ' || PARTICIPANTI_TOMBOLA(I).NUME);
        END LOOP;

        V_CASTIGATOR := SELECTEAZA_CASTIGATOR;

        DBMS_OUTPUT.PUT_LINE('CASTIGATORUL ESTE: ' || V_CASTIGATOR.NUME);

        FOR I IN (SELECT ID_PACHET FROM PACHETE_TURISTICE) LOOP
            V_PACHETE.EXTEND;
            V_PACHETE(V_PACHETE.LAST) := I.ID_PACHET;
        END LOOP;
        J := DBMS_RANDOM.VALUE(1, V_PACHETE.COUNT);

        ACTUALIZARE_PUNCTE(V_CASTIGATOR.ID_CLIENT, 100);
        INSERARE_PACHET(V_CASTIGATOR.ID_CLIENT, V_PACHETE(J));

    EXCEPTION
        --DACA CASTIGATORUL ARE DEJA PACHETUL CASTIGAT, SE VA SELECTA ALTUL
        WHEN UNIQUE_CONSTRAINT THEN
            J := DBMS_RANDOM.VALUE(1, V_PACHETE.COUNT);
            INSERARE_PACHET(V_CASTIGATOR.ID_CLIENT, V_PACHETE(J));

    END RULEAZA_TOMBOLA;
END TOMBOLA;
/

BEGIN 
    TOMBOLA.RULEAZA_TOMBOLA;
END;

SELECT c.NUME, cp.ID_PACHET, p.PUNCTE_LOIALITATE
FROM CLIENTI c, CLIENTI_PACHETE cp, PROGRAME_LOIALITATE p
WHERE c.NUME = 'Andrei Balan' AND c.ID_CLIENT = cp.ID_CLIENT AND p.ID_CLIENT = c.ID_CLIENT;

