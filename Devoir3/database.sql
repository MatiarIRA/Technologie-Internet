 CREATE TABLE adherents (ID_A INT AUTO_INCREMENT , Nom VARCHAR(50) NOT NULL,Prenom VARCHAR(50) NOT NULL,Surnom VARCHAR(15) NOT NULL,Mot_de_passe VARCHAR(20) NOT NULL,	Role VARCHAR(1) , CONSTRAINT chk_Role CHECK (Role('J' OR 'G')),	PRIMARY KEY(ID_A));
CREATE TABLE terrain (	ID_T INT , Nom_ter VARCHAR(10) NOT NULL, PRIMARY KEY(ID_T));
INSERT INTO terrain VALUE('1','Badminton');
INSERT INTO terrain VALUE('2','Racquetball');
INSERT INTO terrain VALUE('3','Squash');
INSERT INTO terrain VALUE('4','Tennis');
INSERT INTO terrain VALUE('5','Wallyball');
INSERT INTO terrain VALUE('6','Football');
CREATE TABLE reservation (Date_R DATE NOT NULL, Hour_R VARCHAR(9) NOT NULL, Date_RD DATETIME NOT NULL, ID_RA INT , CONSTRAINT res_fk1 FOREIGN KEY (ID_RA) REFERENCES  adherents(ID_A),ID_RT INT , CONSTRAINT res_fk2 FOREIGN KEY (ID_RT) REFERENCES  terrain(ID_T));

INSERT INTO reservation (Date_R, Hour_R, Date_RD,ID_RA,ID_RT)VALUES ('2017-04-05', '14h - 15h', '2017-04-04 12:15:26', '1','2'); 
INSERT INTO reservation (Date_R, Hour_R, Date_RD,ID_RA,ID_RT)VALUES ('2017-04-12', '16h - 17h', '2017-04-11 19:15:26', '1','2'); 
INSERT INTO reservation (Date_R, Hour_R, Date_RD,ID_RA,ID_RT)VALUES ('2017-04-05', '6h - 7h', '2017-04-04 18:15:26', '2','2'); 
INSERT INTO reservation (Date_R, Hour_R, Date_RD,ID_RA,ID_RT)VALUES ('2017-04-12', '10h - 11h', '2017-04-11 18:10:26', '2','2');
INSERT INTO reservation (Date_R, Hour_R, Date_RD,ID_RA,ID_RT)VALUES ('2017-04-05', '8h - 9h', '2017-04-04 19:10:26', '3','3');
INSERT INTO reservation (Date_R, Hour_R, Date_RD,ID_RA,ID_RT)VALUES ('2017-04-12', '20h - 21h', '2017-04-11 10:11:26', '4','4');
INSERT INTO reservation (Date_R, Hour_R, Date_RD,ID_RA,ID_RT)VALUES ('2017-04-05', '6h - 7h', '2017-04-04 14:13:26', '5','5');
INSERT INTO reservation (Date_R, Hour_R, Date_RD,ID_RA,ID_RT)VALUES ('2017-04-05', '7h - 8h', '2017-04-04 14:14:24', '6','5');