/* Enlever les tables s'ils sont deja dans la base de donnee*/
DROP TABLE IF EXISTS UTILISATEUR;
DROP TABLE IF EXISTS TYPE_OBJ;
set foreign_key_checks=0;
DROP TABLE IF EXISTS OBJET;
set foreign_key_checks=1;
DROP TABLE IF EXISTS PATH_PHOTO_O;
DROP TABLE IF EXISTS MESSAGERIE;
DROP TABLE IF EXISTS ANNONCE;
DROP TABLE IF EXISTS INTERESSE_A;
DROP TABLE IF EXISTS MARQUE;
DROP TABLE IF EXISTS TELEPHONE;
DROP TABLE IF EXISTS JEUX;
DROP TABLE IF EXISTS TELEPHONE;
DROP TABLE IF EXISTS PIECE_MECANIQUE;
DROP TABLE IF EXISTS AUTOMOBILE;
DROP TABLE IF EXISTS MUSIQUE;
DROP TABLE IF EXISTS MEUBLE;
DROP TABLE IF EXISTS MAISON;
DROP TABLE IF EXISTS NOURRITURE;
DROP TABLE IF EXISTS VETEMENT;
DROP TABLE IF EXISTS ELECTROMENAGER;
DROP TABLE IF EXISTS APPAREIL_ELECTRONIQUE;
DROP TABLE IF EXISTS BIJOUX;
DROP TABLE IF EXISTS ART;
DROP TABLE IF EXISTS TYPE_OBJ;
DROP TABLE IF EXISTS NOM_ARTISTE;
DROP TABLE IF EXISTS LIVRE;
DROP TABLE IF EXISTS AUTEUR;

/* La table d'UTILISATEUR  contient Id utilisateur (Id_U comme la cle primaire) ainsi que les autres informations sur l'utilisateur tel que Prenom, Nom, Code Postal , Email, telephone, mot de passe et optionnellement une path de photo de l'utilisateur
Utilisateur peut avoir la role comme Achteur ainisi que Annonceur, dans cette table Id_U */
CREATE TABLE UTILISATEUR (Id_U int NOT NULL AUTO_INCREMENT, Prenom VARCHAR(15) NOT NULL, Nom VARCHAR(15) NOT NULL, Code_postal_U VARCHAR(7) not null,CONSTRAINT chk_Code_P_U CHECK (REGEXP_LIKE(Code_postal_U ,'[A-z]{1}[0-9]{1}[A-z]{1}[0-9]{1}[A-z]{1}[0-9]{1}','i')),Email VARCHAR(320) NOT NULL,CONSTRAINT chk_Email CHECK (REGEXP_LIKE(Email,'[A-z]*(.[A-z]*)?@[A-z]*(.[a-z]{2,3})?.[a-z]{2,3}','i')),Mot_de_passe VARCHAR (16) NOT NULL, Path_photo_U VARCHAR (100),Tel VARCHAR (15), CONSTRAINT chk_Tel CHECK (REGEXP_LIKE(Tel ,'[0-9]{3}-[0-9]{3}-[0-9]{4}','i')), primary key(Id_U));

/*la table TYPE_OBJ contenant l'attribut Nom_Type definissant dans le font la categorie des objets se trouvant dans la base de donnee */
CREATE TABLE TYPE_OBJ(Nom_Type varchar (25) NOT NULL, PRIMARY KEY(Nom_Type));

/*insertion la table TYPE_OBJ*/
INSERT INTO TYPE_OBJ VALUES('AUTOMOBILE');
INSERT INTO TYPE_OBJ VALUES('APPAREIL_ELECTRONIQUE');
INSERT INTO TYPE_OBJ VALUES('ART');
INSERT INTO TYPE_OBJ VALUES('BIJOUX');
INSERT INTO TYPE_OBJ VALUES('ELECTROMENAGER');
INSERT INTO TYPE_OBJ VALUES('JEUX');
INSERT INTO TYPE_OBJ VALUES('LIVRE');
INSERT INTO TYPE_OBJ VALUES('MUSIQUE');
INSERT INTO TYPE_OBJ VALUES('MEUBLE');
INSERT INTO TYPE_OBJ VALUES('MAISON');
INSERT INTO TYPE_OBJ VALUES('PIECE_MECANIQUE');
INSERT INTO TYPE_OBJ VALUES('TELEPHONE');
INSERT INTO TYPE_OBJ VALUES('VETEMENT');

/*La table MARQUE contenant Nom_Marque qui specifie la marque d'un objet d'une categorie specifie, Nom_Type_M est la categorie reliee.
Cette table sert a faire une recherche plus precise ou declarer notre interet sur un objet plus precisement*/
Create Table MARQUE (Nom_Marque varchar(15) not null, Nom_Type_M varchar(25) not null, constraint marque_fk foreign key(Nom_Type_M) references TYPE_OBJ(Nom_Type), primary key(Nom_Marque, Nom_Type_M));

/*La table OBJET contenant Id_O qui est l'id de l'objet  contenant  Nom_O pour nom de l'objet, Code_postal_O montre le lieu de l'objet et on trouve aussi le prix, l'etat et le marque de l'objet si s'applique. 
Cette table a un role principal . L'usager en tant que l'annonceur entre des information sur l'objet qu'il veut partager, une partie des infomraions qui sont commun entre toutes les objets va etre enregistrer 
dans cette table.*/
CREATE TABLE OBJET (Id_O int AUTO_INCREMENT NOT NULL, Nom_O varchar(64) NOT NULL, Code_postal_O varchar (7) NOT NULL, CONSTRAINT chk_Code_P_O CHECK (REGEXP_LIKE(Code_postal_O ,'[A-z]{1}[0-9]{1}[A-z]{1}[0-9]{1}[A-z]{1}[0-9]{1}')),Etat varchar (5) NOT NULL, CONSTRAINT chk_Etat CHECK (REGEXP_LIKE(Etat, '(Neuf|Usage)')),Prix float(10,2) NOT NULL, Nom_Type_O varchar(25) NOT NULL, CONSTRAINT objet_fk FOREIGN KEY (Nom_Type_O) REFERENCES TYPE_OBJ(Nom_Type), Marque_O varchar(15),CONSTRAINT objet_fk2 FOREIGN KEY (Marque_O) REFERENCES MARQUE(Nom_Marque), Quantite int, primary key(Id_O));

/* La table PATH_PHOTO_O contenant les photos des objets que les usager en tant que les annonceurs veulent partager lorsqu'ils font une annonce. */
CREATE TABLE PATH_PHOTO_O (Id_Photo int NOT NULL,CONSTRAINT path_p_fk FOREIGN KEY (Id_Photo) REFERENCES OBJET(Id_O),Path_img_O varchar(300), PRIMARY KEY(Id_Photo));

/* La table MESSAGERIE serant pour  communiquer entre un achteur et un annonceur et donc il est en relation avec la table UTILISATEUR et on a les deux id differents comme Id_Destinataire et Id_Expediteur et evidament le contenu du message ainsi que la date et heure ou le message a ete cree.*/
CREATE TABLE MESSAGERIE (Id_Destinataire int NOT NULL,CONSTRAINT mess_fk1 FOREIGN KEY (Id_Destinataire) REFERENCES UTILISATEUR(Id_U), Id_Expediteur int NOT NULL, CONSTRAINT mess_fk2 FOREIGN KEY (Id_Expediteur) REFERENCES UTILISATEUR(Id_U), Date_heure_mes TIMESTAMP  NOT NULL,Contenu_M varchar(1000) NOT NULL, PRIMARY KEY (Id_Destinataire,Id_Expediteur,Date_heure_mes));

/* La table ANNONCE qui sert a UTILISATEUR en tant qu'un annonceur pour partager ses objets sur le site. Usager peut optionnellement ajouter une description sur l'objet. S'il s'agit d'une location 
on specife le Duree de location. De l'autre cote acheteur peut offrir un prix lequel il souhait acheter l'objet par qui eventuellement devient le prix de vente et donc on l'enregistre sous attribute Prix_Vente*/
CREATE TABLE ANNONCE (Id_Anc_O int NOT NULL, CONSTRAINT annonce_fk1 FOREIGN KEY (Id_Anc_O) REFERENCES OBJET(Id_O), Description varchar(1000), Prix_Vente float(10,2) NOT NULL, Date_heure_affichage TIMESTAMP NOT NULL, Duree varchar(3) NOT NULL, CONSTRAINT chk_Duree CHECK (REGEXP_LIKE(Duree ,'[0-9]{2}Mois-[0-9]{1}Jours')), Date_heure_vente TIMESTAMP  NOT NULL, PRIMARY KEY (Id_Anc_O),ID_ANNONCEUR int NOT NULL,CONSTRAINT  Annonce_fkan FOREIGN KEY (ID_ANNONCEUR) REFERENCES UTILISATEUR(Id_U),ID_ACHETEUR int,CONSTRAINT  Annonce_fkac FOREIGN KEY (ID_ACHETEUR) REFERENCES UTILISATEUR(Id_U));


/* La table INTERESSE_A sert a l'usager a etre notifie sur les objets qu'il souhaite a trouver sur le site.*/
CREATE TABLE INTERESSE_A (Id_interet int Auto_increment, Nom_Type varchar (25) NOT NULL, CONSTRAINT  int_fk1  FOREIGN KEY  (Nom_Type) REFERENCES TYPE_OBJ(Nom_Type), Id_U int NOT NULL, CONSTRAINT nt_fk2 FOREIGN KEY (Id_U) REFERENCES UTILISATEUR(Id_U),Nom_Marque varchar (15), CONSTRAINT  int_fk2 FOREIGN KEY  (Nom_Marque) REFERENCES MARQUE(Nom_Marque), PRIMARY KEY (Id_interet));

INSERT INTO INTERESSE_A VALUES (1,'AUTOMOBILE',1,'HYUNDAI');
INSERT INTO INTERESSE_A VALUES (2,'AUTOMOBILE',5,'AUDI');
INSERT INTO INTERESSE_A VALUES (3,'AUTOMOBILE',6,'HYUNDAI');
INSERT INTO INTERESSE_A VALUES (4,'AUTOMOBILE',12,'HYUNDAI');
INSERT INTO INTERESSE_A VALUES (5,'AUTOMOBILE',13,'HONDA');
INSERT INTO INTERESSE_A VALUES (6,'AUTOMOBILE',3, NULL);
INSERT INTO INTERESSE_A VALUES (7,'AUTOMOBILE',21, NULL);
INSERT INTO INTERESSE_A VALUES (8,'AUTOMOBILE',19, NULL);

INSERT INTO MARQUE VALUES
('PUMA', 'VETEMENT');
INSERT INTO MARQUE VALUES
('BUNGALOW', 'MAISON');
INSERT INTO MARQUE VALUES
('LOFT', 'MAISON');
INSERT INTO MARQUE VALUES
('APPARTEMENT', 'MAISON');
INSERT INTO MARQUE VALUES
('TOMMYHELF', 'VETEMENT');
INSERT INTO MARQUE VALUES
('DOLCE', 'VETEMENT');
INSERT INTO MARQUE VALUES
('LOLLI', 'VETEMENT');
INSERT INTO MARQUE VALUES
('LEVIS', 'VETEMENT');
INSERT INTO MARQUE VALUES
('H&M', 'VETEMENT');
INSERT INTO MARQUE VALUES
('SIMONS', 'VETEMENT');
INSERT INTO MARQUE VALUES
('ADIDAS', 'VETEMENT');
INSERT INTO MARQUE VALUES
('NIKE', 'VETEMENT');
INSERT INTO MARQUE VALUES
('POPO', 'VETEMENT');
INSERT INTO MARQUE VALUES
('HYUNDAI', 'AUTOMOBILE');
INSERT INTO MARQUE VALUES
('HONDA', 'AUTOMOBILE');
INSERT INTO MARQUE VALUES
('AUDI', 'AUTOMOBILE');
INSERT INTO MARQUE VALUES
('CHEVROLET', 'AUTOMOBILE');
INSERT INTO MARQUE VALUES
('FUTFUT', 'MUSIQUE');
INSERT INTO MARQUE VALUES
('RAP4EVA', 'MUSIQUE');
INSERT INTO MARQUE VALUES
('GINOVU', 'MUSIQUE');
INSERT INTO MARQUE VALUES
('TOYSRUS', 'JEUX');
INSERT INTO MARQUE VALUES
('CLUBPRICE', 'JEUX');
INSERT INTO MARQUE VALUES
('DIDI', 'MEUBLE');
INSERT INTO MARQUE VALUES
('DADA', 'MEUBLE');
INSERT INTO MARQUE VALUES
('GIGI', 'MEUBLE');
INSERT INTO MARQUE VALUES
('SAMSUNG', 'TELEPHONE');
INSERT INTO MARQUE VALUES
('NOKIA', 'TELEPHONE');
INSERT INTO MARQUE VALUES
('LG', 'TELEPHONE');
INSERT INTO MARQUE VALUES
('IPHONE', 'TELEPHONE');
INSERT INTO MARQUE VALUES
('JIJIBIJOUX', 'BIJOUX');
INSERT INTO MARQUE VALUES
('STANLEX', 'APPAREIL_ELECTRONIQUE');


CREATE TABLE TELEPHONE (Id_Tel int NOT NULL, CONSTRAINT tel_fk FOREIGN KEY  (Id_Tel) REFERENCES OBJET(Id_O), Color varchar(7) NOT NULL, PRIMARY KEY(Id_Tel));

CREATE TABLE PIECE_MECANIQUE (Id_PMec int  NOT NULL , CONSTRAINT pm_fk  FOREIGN KEY  (Id_PMec) REFERENCES OBJET(Id_O), PRIMARY KEY(Id_PMec));

CREATE TABLE JEUX (Id_J int NOT NULL, CONSTRAINT jeux_fk FOREIGN KEY  (Id_J) REFERENCES OBJET(Id_O), Categorie_age varchar(10),Nb_joueurs int, CONSTRAINT chk_Categorie_age CHECK (REGEXP_LIKE(Categorie_age,'(TOUT PETIT|ENFANT|ADOLESCENCE|ADULTE)')), PRIMARY KEY(Id_J));

CREATE TABLE AUTOMOBILE (Id_Auto int  NOT NULL, CONSTRAINT Automobile_fk FOREIGN KEY (Id_Auto) REFERENCES OBJET(Id_O), Annee NUMERIC(4)  NOT NULL, Kilometre NUMERIC(6) NOT NULL, Nb_places NUMERIC(1), Color VARCHAR(10) NOT NULL, PRIMARY KEY(Id_Auto));

CREATE TABLE MUSIQUE (Id_Msq int NOT NULL,CONSTRAINT  Musique_fk FOREIGN KEY (Id_Msq) REFERENCES OBJET(Id_O), Sorte varchar(10) NOT NULL, Groupe varchar(15), Type_musique varchar(10), PRIMARY KEY(Id_Msq));

CREATE TABLE MEUBLE (Id_Mub int NOT NULL,CONSTRAINT Meuble_fk FOREIGN KEY  (Id_Mub) REFERENCES OBJET(Id_O), Color varchar(10) NOT NULL, Dimension varchar(15), Materiau varchar(10),PRIMARY KEY(Id_Mub));

CREATE TABLE MAISON (Id_Msn int NOT NULL, CONSTRAINT Maison_fk  FOREIGN KEY  (Id_Msn) REFERENCES OBJET(Id_O), Annee_Construction Numeric(4) NOT NULL, Nb_Chambres Numeric(2) NOT NULL, Garage varchar(3) not null,  CONSTRAINT  chk_Garage CHECK (REGEXP_LIKE(Garage, '(OUI|NON)')), Cours_arriere  varchar(3) NOT NULL, CONSTRAINT  chk_Cours_arriere CHECK (REGEXP_LIKE(Cours_arriere,'(OUI|NON)')),PRIMARY KEY(Id_Msn));

CREATE TABLE NOURRITURE (Id_N int NOT NULL, CONSTRAINT  Nourriture_fk  FOREIGN KEY  (Id_N) REFERENCES OBJET(Id_O), Date_peremption DATE, PRIMARY KEY(Id_N));

CREATE TABLE VETEMENT ( Id_Vet  int NOT NULL,CONSTRAINT Vet_fk FOREIGN KEY (Id_Vet) REFERENCES OBJET(Id_O), Taille_lettre varchar(5), CONSTRAINT  chk_Taille_lettre CHECK (REGEXP_LIKE (Taille_lettre, '(XXS|XS|S|M|L|XL|XXL|XXXL)')),Taille_chiffre numeric(3), Sexe  varchar(7) NOT NULL, CONSTRAINT chk_Sexe CHECK (REGEXP_LIKE(Sexe, '(HOMME|FEMME|UNISEXE)')), Categorie_age varchar(10),CONSTRAINT chk_Categorie_age CHECK (REGEXP_LIKE(Categorie_age,'(TOUT PETIT|ENFANT|ADOLESCENCE|ADULTE)')), Materiau varchar(10), CONSTRAINT chk_Materiau_Vet CHECK (REGEXP_LIKE(Materiau,'(Acrylique|Angora|Cachemire|Coton|Cuir|Daim|Denim|Faux cuir|Fourrure|Gore-tex|Jersey|Laine|Lin|Lycra|Nylon| Polaire|Polyamide|Polyester|Soie)')),Primary key(Id_Vet));
          
CREATE TABLE ELECTROMENAGER ( Id_Elcmngr int NOT NULL, CONSTRAINT Electromenager_fk FOREIGN KEY (Id_Elcmngr) REFERENCES    OBJET(Id_O), PRIMARY KEY(Id_Elcmngr));

CREATE TABLE APPAREIL_ELECTRONIQUE ( Id_Elc int NOT NULL, CONSTRAINT App_elec_fk FOREIGN KEY (Id_Elc) REFERENCES OBJET(Id_O), PRIMARY KEY(Id_Elc));

CREATE TABLE BIJOUX (Id_Bij int not nULL , CONSTRAINT Bij_fk FOREIGN KEY  (Id_Bij) REFERENCES OBJET(Id_O), Materiau varchar(10), CONSTRAINT  Chk_Materiau_Bij CHECK (REGEXP_LIKE(Materiau, '(Or| Argent| Cuivre| Bronze| Titane| Laiton| Zinc|  Palladium| Platine| Rhodium)')), primary key(Id_Bij));

CREATE TABLE ART (Id_Art int NOT NULL, CONSTRAINT Art_fk FOREIGN KEY  (Id_Art) REFERENCES OBJET(Id_O), Dimension varchar(15), PRIMARY KEY(Id_Art));

CREATE TABLE NOM_ARTISTE ( Id_NomArt int NOT NULL,CONSTRAINT Nom_Artiste_fk FOREIGN KEY (Id_NomArt) REFERENCES ART(Id_Art), Nom_Art varchar (15)  NOT NULL, PRIMARY KEY (Id_NomArt,Nom_Art));

CREATE TABLE LIVRE ( Id_Livre int NOT NULL , CONSTRAINT Livre_fk FOREIGN KEY  (Id_Livre) REFERENCES OBJET(Id_O), Genre varchar(30), Nb_Pages int, Editeur varchar(50), Titre varchar(50)  NOT NULL, PRIMARY KEY(Id_Livre));
    
CREATE TABLE NOM_AUTEUR( Id_NomAut int NOT NULL,CONSTRAINT Nom_Auteur_fk FOREIGN KEY (Id_NomAut) REFERENCES LIVRE(Id_Livre), Nom_Aut varchar (15)  NOT NULL, PRIMARY KEY (Id_NomAut,Nom_Aut));

INSERT INTO UTILISATEUR VALUES(1,'Bill','Lewis','H4X1B1','bill@lewis.com','123456','img.bill.jpg','438-123-4567'); 
INSERT INTO UTILISATEUR VALUES(2,'John','Hill','H4A1B1','john@hill.com','123456','','438-321-4567'); 
INSERT INTO UTILISATEUR VALUES(3,'Ruth','Lewis','H4B1B1','ruth@lewis.com','123456','','438-123-5555'); 
INSERT INTO UTILISATEUR VALUES(4,'Carol','Evans','H4X1C1','carol@evans.com','123456','','514-123-4567'); 
INSERT INTO UTILISATEUR VALUES(5,'Jeff','Lee','H4D1B1','jeff@lee.com','123456','','438-514-4567');
INSERT INTO UTILISATEUR VALUES(6,'David','Lewis','H4X1E1','david@lewis.com','123456','','438-415-4567');
INSERT INTO UTILISATEUR VALUES(7,'Mary','Garcia','H4F1B1','mary@garcia.com','123456','','438-123-6666'); 
INSERT INTO UTILISATEUR VALUES(8,'James','Lewis','H4X1G1','james@lewis.com','123456','','438-123-0101');
INSERT INTO UTILISATEUR VALUES(9,'Paul','Young','H4H1B1','paul@young.com','123456','img.paul.jpg','514-010-4567');
INSERT INTO UTILISATEUR VALUES(10,'Cristina','Mendez','H4X1B1','cristina@mendez.com','123456','img.cristina.jpg','514-111-4567'); 
INSERT INTO UTILISATEUR VALUES(11,'Danny','Rand','H4A1B1','danny@rand.com','123456','','438-222-4567');
INSERT INTO UTILISATEUR VALUES(12,'Joy','Evans','H4B1B1','joy@lewis.com','123456','','438-333-5555');
INSERT INTO UTILISATEUR VALUES(13,'Harold','McDonald','H4X1C1','harold@mcdonald.com','123456','','514-444-4567'); 
INSERT INTO UTILISATEUR VALUES(14,'Barry','Alen','H4D1B1','barry@alen.com','123456','','438-555-4567');
INSERT INTO UTILISATEUR VALUES(15,'Iris','West','H4X1E1','iris@west.com','123456','img.iris.jpg','438-666-4567'); 
INSERT INTO UTILISATEUR VALUES(16,'Ronna','Rand','H4F1B1','ronna@rand.com','123456','','438-777-6666');
INSERT INTO UTILISATEUR VALUES(17,'Arian','Azmoudeh','H4X1G1','arian@azmoudeh.com','123456','','438-888-0101'); 
INSERT INTO UTILISATEUR VALUES(18,'Vivianne','Young','H4H1B1','vivianne@young.com','123456','','514-999-4567');
INSERT INTO UTILISATEUR VALUES(19,'Bill','Smith','H4M1B1','bill@smith.com','123456','','438-000-4567');
INSERT INTO UTILISATEUR VALUES(20,'Scarlette','Johansson','H4A1B1','john@scarlette.com','123456','','438-321-1111');
INSERT INTO UTILISATEUR VALUES(21,'Rayan','Razmi','H4B1B1','rayan@razmi.com','123456','','438-123-2222'); 
INSERT INTO UTILISATEUR VALUES(22,'Jesus','Evans','H4X1C1','jesus@evans.com','123456','img.jesus.jpg','514-123-3333'); 
INSERT INTO UTILISATEUR VALUES(23,'Jeniffer','Lee','H4D1B1','jeniffer@lee.com','123456','','438-514-4444'); 
INSERT INTO UTILISATEUR VALUES(24,'Yazdan','Hormozi','H4X1E1','yazdan@hormozi.com','123456','','438-415-5555'); 
INSERT INTO UTILISATEUR VALUES(25,'Dave','Stanford','H4H1B1','dave@stanford.com','123456','','514-010-6666');

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Pantalon','J4Y1H5', 'Neuf', 20, 'PUMA', 'VETEMENT',1);
INSERT INTO VETEMENT VALUES (1,'XL',NULL, 'UNISEXE', 'TOUT PETIT',NULL);
INSERT INTO ANNONCE (ID_ANNONCEUR, DESCRIPTION, ID_ANC_O) VALUES (10, 'JE VENDS CA', 1);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Maison de campagne','J4Y1Z5', 'Usage', 100000, 'BUNGALOW', 'MAISON', 1);
INSERT INTO MAISON VALUES (2,1950, 6, 'oui', 'oui');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (5,2);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O, QUANTITE) VALUES ('Maison de campagne','J2B1Z5', 'Usage', 120000, 'BUNGALOW', 'MAISON', 1);
INSERT INTO MAISON VALUES (3,1950, 6, 'oui', 'oui');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (8,3);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Collections de livre','J4Y1Z5', 'Usage', 100000, NULL, 'LIVRE',3);
INSERT INTO LIVRE VALUES (4,'Fantastique', NULL, NULL, 'Les rois du monde');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (3,4);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Loft a vendre','G4Y5Z5', 'Neuf', 1000000, 'LOFT','MAISON',1);
INSERT INTO MAISON VALUES (5,2017, 10, 'oui', 'oui');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (6,5);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Appartement pas cher','G4Y5Y8', 'Usage', 50000, 'APPARTEMENT','MAISON',1);
INSERT INTO MAISON VALUES (6,1980, 3, 'non', 'non');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (14,6);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Petit oasis','A4Y5Z5', 'Usage', 200000, 'BUNGALOW','MAISON',1);
INSERT INTO MAISON VALUES (7,1940, 4, 'non', 'oui');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (17,7);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Mes jeans favoris','G5C1B3', 'Usage', 40, 'ADIDAS','VETEMENT',1);
INSERT INTO VETEMENT VALUES (8,'XL',NULL, 'UNISEXE', '0-5',NULL);
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (20,8);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Pantalon de sport','G2C1B3', 'Usage', 45, 'NIKE','VETEMENT',1);
INSERT INTO VETEMENT VALUES (9,NULL,20, 'HOMME', '20-99','NYLON');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (24,9);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('LG Neuf 2017','C5C1B3', 'Usage', 150, 'LG','TELEPHONE',1);
INSERT INTO TELEPHONE VALUES (10,'ROUGE');
INSERT INTO ANNONCE(ID_ANNONCEUR, ID_ANC_O) VALUES (23,10);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('IPhone7','B5C1B3', 'Usage', 90, 'IPHONE','TELEPHONE',1);
INSERT INTO TELEPHONE VALUES (11,'BLANC');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (20,11);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Nokia 4.3','G5J1B3', 'Usage', 30, 'NOKIA','TELEPHONE',1);
INSERT INTO TELEPHONE VALUES (12,'NOIR');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (15,12);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Bague de ma maman','V5J1B3', 'Usage', 1000, 'JIJIBIJOUX','BIJOUX',1);
INSERT INTO BIJOUX VALUES (13,'OR');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (9,13);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Bague de fiancailles','A9J1B3', 'Neuf', 350, 'JIJIBIJOUX','BIJOUX',1);
INSERT INTO BIJOUX VALUES (14,'ARGENT');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (1,14);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Grille-Pain','J5Z1C5', 'Usage', 75, 'STANLEX','APPAREIL_ELECTRONIQUE',1);
INSERT INTO APPAREIL_ELECTRONIQUE VALUES (15);
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (5,15);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Maison de ville','Z2Y5Y8', 'Usage', 500000, 'BUNGALOW','MAISON',1);
INSERT INTO MAISON VALUES (16,1930, 9, 'non', 'non');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (1,16);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Maison de ville','Z2Y5Y8', 'Usage', 500000, 'BUNGALOW','MAISON',1);
INSERT INTO MAISON VALUES (17,1927, 9, 'non', 'non');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (3,17);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Maison de campagne','A6B5Y8', 'Usage', 300000, 'BUNGALOW','MAISON',1);
INSERT INTO MAISON VALUES (18,1920, 7, 'non', 'non');
INSERT INTO ANNONCE(ID_ANNONCEUR, ID_ANC_O) VALUES (19,18);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Maison South shore','J5I1H5', 'Usage', 200000, 'BUNGALOW','MAISON',1);
INSERT INTO MAISON VALUES (19,1940, 6, 'oui', 'non');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (4,19);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Maison de peur','J9I1H2', 'Usage', 233000, 'APPARTEMENT','MAISON',1);
INSERT INTO MAISON VALUES (20,1910, 3, 'non', 'non');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (8,20);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Maison a vendre','K5I1H5', 'Usage', 199999, 'BUNGALOW','MAISON',1);
INSERT INTO MAISON VALUES (21,2000, 5, 'oui', 'oui');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (17,21);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Loft de la famille Bibi','J5I1H5', 'Usage', 99980, 'LOFT','MAISON',1);
INSERT INTO MAISON VALUES (22,2010, 8, 'non', 'non');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (13,22);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Maison 1 etage','J5I1B9', 'Usage', 50000, 'BUNGALOW','MAISON',1);
INSERT INTO MAISON VALUES (23,1925, 5, 'oui', 'oui');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (1,23);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Jvends mon char','J5I1B9', 'Usage', 9000, 'HYUNDAI','AUTOMOBILE',1);
INSERT INTO AUTOMOBILE VALUES (24,2007, 100000,4,'Noir');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (2,24);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Auto a vendre','J5I5B9', 'Usage', 11000, 'HONDA','AUTOMOBILE',1);
INSERT INTO AUTOMOBILE VALUES (25,2000, 140000,5,'Gris');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (22,25);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Audi pas cher','G7I1B9', 'Neuf', 25000, 'AUDI','AUTOMOBILE',1);
INSERT INTO AUTOMOBILE VALUES (26,2016, 0,5, 'Blanc');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (11,26);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Car to sell','A7B4C4', 'Usage', 15000, 'CHEVROLET','AUTOMOBILE',1);
INSERT INTO AUTOMOBILE VALUES (27,2013, 50000,4,'Noir');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (14,27);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Hyundai 1999','A7B8J2', 'Usage', 3000, 'CHEVROLET','AUTOMOBILE',1);
INSERT INTO AUTOMOBILE VALUES (28,1999, 150000,6,'Noir');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (17,28);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Honda NGXT5','B7B8J2', 'Usage', 9500, 'HONDA','AUTOMOBILE',1);
INSERT INTO AUTOMOBILE VALUES (29,2003, 108950,4,'Rouge');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (12,29);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Honda ZAB23','A3J8J2', 'Usage', 10500, 'HONDA','AUTOMOBILE',1);
INSERT INTO AUTOMOBILE VALUES (30,2004, 107990,4,'Gris');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (11,30);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Hyundai Powa3','J7L3B3', 'Usage', 8500, 'HYUNDAI','AUTOMOBILE',1);
INSERT INTO AUTOMOBILE VALUES (31,2004, 125000,4,'Gris');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (23,31);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Mes jeans favoris','G5C1B3', 'Usage', 40, 'ADIDAS','VETEMENT',1);
INSERT INTO VETEMENT VALUES (32,'XL',NULL, 'UNISEXE', 'TOUT PETIT',NULL);
INSERT INTO ANNONCE(ID_ANNONCEUR, ID_ANC_O) VALUES (22,32);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('T-shirt rose','H4K3E3', 'Usage', 15, 'PUMA','VETEMENT',1);
INSERT INTO VETEMENT VALUES (33,NULL,'26', 'FEMME', 'ADULTE',NULL);
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (18,33);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Manteau pas cher','G5C1B3', 'Usage', 32, 'TOMMYHELF','VETEMENT',1);
INSERT INTO VETEMENT VALUES (34,NULL,'24', 'FEMME', 'ADULTE',NULL);
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (12,34);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Short','G5C1B3', 'Usage', 25, 'SIMONS','VETEMENT',1);
INSERT INTO VETEMENT VALUES (35,NULL,'26', 'FEMME', 'ADULTE',NULL);
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (12,35);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Manteau hiver','X5A8B2', 'Neuf', 90, 'H&M','VETEMENT',10);
INSERT INTO VETEMENT VALUES (36,NULL,'32', 'HOMME', 'ADULTE',NULL);
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (10,36);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Pantalon grande taille','XJ98B2', 'Usage', 49, 'H&M','VETEMENT',1);
INSERT INTO VETEMENT VALUES (37,NULL,'40', 'HOMME', 'ADULTE',NULL);
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (9,37);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Honda','J7U1H2', 'Usage', 10500, 'HONDA','AUTOMOBILE',1);
INSERT INTO AUTOMOBILE VALUES (38,2007, 90000,6,'NOIR');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (12,38);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Hyundai','F4H1K2', 'Usage', 9700, 'HYUNDAI','AUTOMOBILE',1);
INSERT INTO AUTOMOBILE VALUES (39,2003, 75000,7,'BLANC');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (12,39);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Livre de poche','J4Y1Z5', 'Neuf', 70, NULL, 'LIVRE',3);
INSERT INTO LIVRE VALUES (40,'Peur', NULL, NULL, 'La civilisation');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (1,40);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Livre de poche','G4J1B2', 'Neuf', 5, NULL, 'LIVRE',3);
INSERT INTO LIVRE VALUES (41,'Peur', NULL, NULL, 'Alyss');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (1,41);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Boris vian','J4Y1Z9', 'Usage', 5, NULL, 'LIVRE',3);
INSERT INTO LIVRE VALUES (42,'Fantastique', NULL, NULL, 'Ecume des jours');
INSERT INTO ANNONCE (ID_ANNONCEUR, ID_ANC_O) VALUES (1,42);



INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Pantalon','J4B1H5', 'Neuf', 20, 'POPO', 'VETEMENT',1);
INSERT INTO VETEMENT VALUES (43,'S',NULL, 'FEMME', NULL,NULL);
INSERT INTO ANNONCE (ID_ANNONCEUR, DESCRIPTION, ID_ANC_O) VALUES (2, NULL, 43);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('Pantalon','J4B1B5', 'Neuf', 23, 'LEVIS', 'VETEMENT',1);
INSERT INTO VETEMENT VALUES (44,'XS',NULL, 'UNISEXE', NULL, 'COTON');
INSERT INTO ANNONCE (ID_ANNONCEUR, DESCRIPTION, ID_ANC_O) VALUES (2, NULL, 44);

INSERT INTO OBJET(NOM_O,CODE_POSTAL_O,ETAT,PRIX,MARQUE_O, NOM_TYPE_O,QUANTITE) VALUES ('BB Fun','J4B1C3', 'Usage', 35, NULL, 'JEUX',1);
INSERT INTO JEUX VALUES (45,'TOUT PETIT',6);
INSERT INTO ANNONCE (ID_ANNONCEUR, DESCRIPTION, ID_ANC_O) VALUES (7, NULL, 45);

Update ANNONCE set id_acheteur = 2 where id_anc_o = 5;
Update ANNONCE set prix_vente = 800000 where id_anc_o = 5;
Update ANNONCE set ID_ACHETEUR=2 WHERE ID_ANC_O = 17;

Insert into MESSAGERIE values (10,2,NOW(), 'Je veux acheter');
Insert into MESSAGERIE values (2,10,NOW(), 'Quel produit');
Insert into MESSAGERIE values (18,19,NOW(), 'Quel produit');
Insert into MESSAGERIE values (12,16,NOW(), 'Est-ce negotiable');


Update ANNONCE set Id_acheteur = 17 where id_anc_o = 43;
Update ANNONCE set Id_acheteur = 19 where id_anc_o = 44;
=========================================









