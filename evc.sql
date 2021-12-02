CREATE DATABASE IF NOT EXISTS `evc_db`;
USE evc_db;

DROP TABLE IF EXISTS `evcUserCheckup`;
DROP TABLE IF EXISTS `evcDoctorCheckup`;
DROP TABLE IF EXISTS `checkup`;
DROP TABLE IF EXISTS `evcDoctor`;
DROP TABLE IF EXISTS `evcUser`;
-------------------------------------------------------------------------------------------------
CREATE TABLE evcUser(
userId INT AUTO_INCREMENT,
username VARCHAR(20),
userEmail VARCHAR(100),
userPassword VARCHAR(100),
userSex ENUM ('m','w'),
userBirthdate DATE,
PRIMARY KEY (userId)
);

INSERT INTO evcUser (userId, username, userEmail, userPassword, userSex, userBirthdate)
VALUES (default, 'Testuser', 'User@Test.de', 'testpw', 'm', '1970-01-01');
-------------------------------------------------------------------------------------------------
CREATE TABLE evcDoctor(
doctorId INT AUTO_INCREMENT,
userId INT,
doctorEmailPublic VARCHAR(100),
doctorOfficePublic VARCHAR(70),
doctorStreetPublic VARCHAR(100),
doctorZipPublic INT,
doctorCityPublic VARCHAR(50),
PRIMARY KEY (doctorId),
FOREIGN KEY (userId) REFERENCES evcUser(userId)
);

INSERT INTO evcDoctor (doctorId, userId, doctorEmailPublic, doctorOfficePublic, 
doctorStreetPublic, doctorZipPublic, doctorCityPublic) 
VALUES(default, 1, 'test@test.de', 'Testpraxis', 'Teststrasse 10', 72770, 'Testpraxisstadt');
-------------------------------------------------------------------------------------------------
#checkupIntervallMonths == null --> only one neccessary
CREATE TABLE checkup(
checkupId INT,
checkupName VARCHAR(120),
checkupDescription VARCHAR(1000),
checkupType ENUM ('Checkup', 'Vaccination', 'IGeL'),
checkupMinAge INT,
checkupMaxAge INT,
checkupIntervalMonths INT,
checkupSex ENUM ('m','w', 'mw'),
PRIMARY KEY (checkupId)
);

#ID = SEX|TYPE|TYPE|INDEX|INDEX|INDEX
#SEX: 1 = MW | 2 = W | 3 = M
#TYPE 01 = CHECKUP_ADULTS | 02 = CHECKUP_KIDS | 03 = VACC_ADULTS | 04 = VACC_KIDS
#INDEX XXX = RANDOM INDEX 

# mw checkups adults
INSERT INTO checkup VALUES (101001, 'Allgemeiner Gesundheits-Check-up', 'DESC', 'Checkup', 18, 35, null,'mw');
INSERT INTO checkup VALUES (101002, 'Allgemeiner Gesundheits-Check-up', 'Früherkennung zum Beispiel von Nieren-, Herz-Kreislauferkrankungen und Diabetes. Innerhalb des Check-Ups: Ab Herbst 2021 außerdem einmalig ein Screening auf eine Hepatitis B- und Hepatitis C-Virusinfektion. Damit sollen unentdeckte Infektionen erkannt und frühzeitig behandelt werden, um Spätfolgen zu verhindern. Liegt der letzte Check-up keine drei Jahre zurück, kann das Screening übergangsweise auch separat erfolgen.', 'Checkup', 35, null, 36,'mw');
INSERT INTO checkup VALUES (101003, 'Hautkrebs-Screening', 'Untersuchung der Haut des gesamten Körpers zur Früherkennung von Hautkrebs', 'Checkup', 35, null, 24,'mw');
INSERT INTO checkup VALUES (101004, 'Zahn-Vorsorge', 'Vorsorgeuntersuschung beim Zahnarzt. Jährlich für Bonus.', 'Checkup', 18, null, 12,'mw');

# w checkups adults
INSERT INTO checkup VALUES (201001, 'Genitaluntersuchung zur Früherkennung von Krebserkrankungen', 'Desc', 'Checkup', 20, null, 12,'w');
INSERT INTO checkup VALUES (201002, 'Test auf eine Infektion mit Chlamydien', 'DESC', 'Checkup', 25, null, 12,'w');
INSERT INTO checkup VALUES (201003, 'Brust- und Hautkrebsuntersuchung', 'Zur Krebsvorsorge kommt eine jährliche Brust- und Hautuntersuchung hinzu. Achten Sie darauf, dass Sie dabei zur regelmäßigen Früherkennung in die Selbstuntersuchung der Brust eingewiesen werden.', 'Checkup', 30, null, 12,'w');
INSERT INTO checkup VALUES (201004, 'Kombi-Screening', 'Kombiniertes Screening aus zytologischer Untersuchung und HPV-Test.', 'Checkup', 35, null, 36,'w');
INSERT INTO checkup VALUES (201005, 'Früherkennung von Darmkrebs', 'Test auf verborgenes Blut im Stuhl.', 'Checkup', 50, 54, 12,'w');
INSERT INTO checkup VALUES (201006, 'Früherkennung von Brustkrebs', 'Zur Früherkennung von Brustkrebs erhalten Sie alle zwei Jahre eine Einladung zum Mammographie-Screening.', 'Checkup', 50, 69, 24,'w');
INSERT INTO checkup VALUES (201007, 'Früherkennung von Darmkrebs', 'Test auf verborgenes Blut im Stuhl. Alternativ: Zwei Darmspiegelungen im Mindestabstand von 10 Jahren', 'Checkup', 55, null, 24,'w');

# m checkups adults
INSERT INTO checkup VALUES (301001, 'Krebsfrüherkennungsuntersuchung der Genitalien und Prostata', 'Desc', 'Checkup', 45, null, 12,'m');
INSERT INTO checkup VALUES (301002, 'Früherkennung von Darmkrebs', 'Test auf verborgenes Blut im Stuhl. Alternativ: Zwei Darmspiegelungen im Mindestabstand von 10 Jahren', 'Checkup', 50, 54, 12,'m');
INSERT INTO checkup VALUES (301003, 'Früherkennung von Aneurysmen der Bauchschlagader', 'Einmaliger Anspruch auf eine Ultraschalluntersuchung zur Früherkennung von Aneurysmen der Bauchschlagader', 'Checkup', 65, null, null,'m');

# mw checkups kids and juveniles
INSERT INTO checkup VALUES (102001, 'Check der körperlichen Verfassung und seelischen Entwicklung', 'DESC', 'Checkup', 12, 15, null,'mw');
INSERT INTO checkup VALUES (102002, 'Zahn-Vorsorge', 'Vorsorgeuntersuschung beim Zahnarzt. Halbjährig für Bonus.', 'Checkup', 12, 18, 6,'mw');
INSERT INTO checkup VALUES (102003, 'U1', 'DESC', 'Checkup', 0, 18, null,'mw');
INSERT INTO checkup VALUES (102004, 'U2', 'DESC', 'Checkup', 0, 18, null,'mw');
INSERT INTO checkup VALUES (102005, 'U3', 'DESC', 'Checkup', 0, 18, null,'mw');
INSERT INTO checkup VALUES (102006, 'U4', 'DESC', 'Checkup', 0, 18, null,'mw');
INSERT INTO checkup VALUES (102007, 'U5', 'DESC', 'Checkup', 0, 18, null,'mw');
INSERT INTO checkup VALUES (102008, 'U6', 'DESC', 'Checkup', 0, 18, null,'mw');
INSERT INTO checkup VALUES (102009, 'U7', 'DESC', 'Checkup', 0, 18, null,'mw');
INSERT INTO checkup VALUES (102010, 'U7a', 'DESC', 'Checkup', 0, 18, null,'mw');
INSERT INTO checkup VALUES (102011, 'U8', 'DESC', 'Checkup', 0, 18, null,'mw');
INSERT INTO checkup VALUES (102012, 'U9', 'DESC', 'Checkup', 0, 18, null,'mw');

# vacc checkups adults
INSERT INTO checkup VALUES (103001, 'Tetanus', 'DESC', 'Vaccination', 18, null, 120,'mw');
INSERT INTO checkup VALUES (103002, 'Diphterie', 'DESC', 'Vaccination', 18, null, 120,'mw');
#Second after 1-3 months, Third after 5-12 / 9-12 months, Booster: 3y / 5y / if > 50-60 y/o: 3y
INSERT INTO checkup VALUES (103003, 'FSME', 'Für Menschen in Risikogebieten. Drei Impfungen zur Grundimmuniserung nötig.', 'Vaccination', 18, null, 0,'mw');
INSERT INTO checkup VALUES (103004, 'Masern', 'Für Menschen geb. nach 1970, bei denen der Impfstatus unklar ist, oder nur einmalig in der Kindheit geimpft wurde.', 'Vaccination', 18, 50, null,'mw');
INSERT INTO checkup VALUES (103005, 'Keuchhusten', 'DESC', 'Vaccination', 18, 60, null,'mw');
INSERT INTO checkup VALUES (103006, 'Pneumokken', 'DESC', 'Vaccination', 60, null, null,'mw');
INSERT INTO checkup VALUES (103007, 'Gürtelrose', 'Bei Grunderkrankung wie Asthma oder Diabetes ab 50 Jahren. Ansonsten ab 60 Jahren.', 'Vaccination', 50, null, null,'mw');
INSERT INTO checkup VALUES (103008, 'Grippe', 'Vor allem empfohlen für chronisch Kranke, Schwangere, Personen ab 60 Jahren und Menschen mit erhöhter Infektionsgefahr, zum Beispiel medizinisches Personal', 'Vaccination', 18, null, 12,'mw');
INSERT INTO checkup VALUES (103009, 'COVID-19', 'Empfehlungen der STIKO beachten!', 'Vaccination', 18, null, 6,'mw');

# mw vacc checkups kids and juveniles 
INSERT INTO checkup VALUES (104001, 'HPV Impfung', 'Nach ärztlicher Beratung', 'Vaccination', 9, 14, null,'mw');
-------------------------------------------------------------------------------------------------
CREATE TABLE evcUserCheckup(
evcUserCheckupId INT AUTO_INCREMENT,
userId INT,
checkupId INT,
evcUserCheckupDate DATE,
evcUserCheckupNotes VARCHAR(1000),
PRIMARY KEY (evcUserCheckupId),
FOREIGN KEY (userId) REFERENCES evcUser(userId),
FOREIGN KEY (checkupId) REFERENCES checkup(checkupId)
);

INSERT INTO evcUserCheckup (evcUserCheckupId, userId, checkupId, evcUserCheckupDate, evcUserCheckupNotes)
VALUES (default, 1, 301001, '2020-01-01', 'Alles bestens');
-------------------------------------------------------------------------------------------------
CREATE TABLE evcDoctorCheckup(
evcDoctorCheckupId INT AUTO_INCREMENT,
doctorId INT,
checkupId INT,
PRIMARY KEY (evcDoctorCheckupId),
FOREIGN KEY (doctorId) REFERENCES evcDoctor(doctorId),
FOREIGN KEY (checkupId) REFERENCES checkup(checkupId)
);

INSERT INTO evcDoctorCheckup (evcDoctorCheckupId, doctorId, checkupId)
VALUES (default, 1, 101001), (default, 1, 101002), (default, 1, 101003);
-------------------------------------------------------------------------------------------------




