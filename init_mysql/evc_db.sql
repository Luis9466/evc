CREATE DATABASE IF NOT EXISTS `evc_db`;
USE evc_db;

DROP TABLE IF EXISTS `evcUserCheckup`;
DROP TABLE IF EXISTS `evcDoctorCheckup`;
DROP TABLE IF EXISTS `evcInsurerCheckupBonus`;
DROP TABLE IF EXISTS `checkup`;
DROP TABLE IF EXISTS `evcDoctor`;
DROP TABLE IF EXISTS `evcUser`;
DROP TABLE IF EXISTS `evcInsurer`;
-------------------------------------------------------------------------------------------------
CREATE TABLE evcInsurer(
insurerId INT AUTO_INCREMENT,
insurerName VARCHAR(50),
insurerBonusInfo VARCHAR(1000),
PRIMARY KEY(insurerId)
);
INSERT INTO evcInsurer (insurerId, insurerName, insurerBonusInfo) VALUES 
(1, 'Techniker', 
'Sie haben die Wahl
Wurden mindestens 1.000 Bonuspunkte erreicht,
können Sie wählen:

Bonusmodell eins: TK-BonusDirect
Mit dem TK BonusDirect entscheiden Sie sich für die
sofortige Auszahlung des Gesundheitsbonus. Für
1.000 Bonuspunkte erhalten Sie einen Gesundheits-
bonus von 30 Euro. Der Bonus erhöht sich je weitere
100 Punkte um 2,50 Euro.

Bonusmodell zwei: TK-Gesundheitsdividende
Noch mehr Einsatz für die Gesundheit lohnt sich!
Profitieren Sie von der TK-Gesundheitsdividende.
Mit 60 Euro für 1.000 Bonuspunkte und 5 Euro je
weitere 100 Punkte ist sie doppelt so hoch wie der
TK-BonusDirect.'), 
(2, 'AOK',
'Für 100 Bonuspunkte erhalten Sie 1,00 Euro. 
Ihren Bonus zahlen wir bereits ab 500 Bonuspunkten, 
also ab der ersten Maßnahme, aus.'), 
(3, 'Barmer',
'Die Geldprämie ist wählbar in folgenden Staffelungen:
    150 Punkte für € 9,00
    500 Punkte für € 30,00
    1.000 Punkte für € 65,00
    1.500 Punkte für € 100,00');
-------------------------------------------------------------------------------------------------
CREATE TABLE evcUser(
userId INT AUTO_INCREMENT,
insurerId INT,
username VARCHAR(20),
userEmail VARCHAR(100),
userPassword VARCHAR(100),
userSex ENUM ('m','w'),
userBirthdate DATE,
PRIMARY KEY (userId),
FOREIGN KEY (insurerId) REFERENCES evcInsurer(insurerId)
);

INSERT INTO evcUser (userId, insurerId, username, userEmail, userPassword, userSex, userBirthdate) VALUES 
(1, null, 'Doc1', 'User@Test.de', '$2b$10$Do/oG6PZxEiKfhmUOkPDnuvUMl/exqgcmh2V15h2QEQZ/4MALPB12', 'm', '1970-01-01'),
(2, null, 'Doc2', 'User2@Test.de', '$2b$10$Do/oG6PZxEiKfhmUOkPDnuvUMl/exqgcmh2V15h2QEQZ/4MALPB12', 'w', '1970-01-01'),
(3, null, 'Doc3', 'User3@Test.de', '$2b$10$Do/oG6PZxEiKfhmUOkPDnuvUMl/exqgcmh2V15h2QEQZ/4MALPB12', 'm', '1970-01-01'),
(4, null, 'Doc4', 'User4@Test.de', '$2b$10$Do/oG6PZxEiKfhmUOkPDnuvUMl/exqgcmh2V15h2QEQZ/4MALPB12', 'w', '1970-01-01'),
(5, null, 'Doc5', 'User5@Test.de', '$2b$10$Do/oG6PZxEiKfhmUOkPDnuvUMl/exqgcmh2V15h2QEQZ/4MALPB12', 'm', '1970-01-01'),
(6, null, 'Doc6', 'User6@Test.de', '$2b$10$Do/oG6PZxEiKfhmUOkPDnuvUMl/exqgcmh2V15h2QEQZ/4MALPB12', 'w', '1970-01-01'),
(7, null, 'Doc7', 'User7@Test.de', '$2b$10$Do/oG6PZxEiKfhmUOkPDnuvUMl/exqgcmh2V15h2QEQZ/4MALPB12', 'm', '1970-01-01'),
(8, null, 'Doc8', 'User8@Test.de', '$2b$10$Do/oG6PZxEiKfhmUOkPDnuvUMl/exqgcmh2V15h2QEQZ/4MALPB12', 'w', '1970-01-01'),
(9, null, 'Doc9', 'User9@Test.de', '$2b$10$Do/oG6PZxEiKfhmUOkPDnuvUMl/exqgcmh2V15h2QEQZ/4MALPB12', 'm', '1970-01-01'),
(10, null, 'Doc10', 'User10@Test.de', '$2b$10$Do/oG6PZxEiKfhmUOkPDnuvUMl/exqgcmh2V15h2QEQZ/4MALPB12', 'w', '1970-01-01'),
(11, 1, 'Usr1', 'User11@Test.de', '$2b$10$Do/oG6PZxEiKfhmUOkPDnuvUMl/exqgcmh2V15h2QEQZ/4MALPB12', 'm', '1960-01-01'),
(12, 2, 'Usr2', 'User12@Test.de', '$2b$10$Do/oG6PZxEiKfhmUOkPDnuvUMl/exqgcmh2V15h2QEQZ/4MALPB12', 'w', '1970-01-01'),
(13, 3, 'Usr3', 'User13@Test.de', '$2b$10$Do/oG6PZxEiKfhmUOkPDnuvUMl/exqgcmh2V15h2QEQZ/4MALPB12', 'm', '1980-01-01'),
(14, 1, 'Usr4', 'User14@Test.de', '$2b$10$Do/oG6PZxEiKfhmUOkPDnuvUMl/exqgcmh2V15h2QEQZ/4MALPB12', 'w', '1990-01-01'),
(15, 2, 'Usr5', 'User15@Test.de', '$2b$10$Do/oG6PZxEiKfhmUOkPDnuvUMl/exqgcmh2V15h2QEQZ/4MALPB12', 'm', '2000-01-01'),
(16, 3, 'Usr6', 'User16@Test.de', '$2b$10$Do/oG6PZxEiKfhmUOkPDnuvUMl/exqgcmh2V15h2QEQZ/4MALPB12', 'w', '2010-01-01');
-------------------------------------------------------------------------------------------------
CREATE TABLE evcDoctor(
doctorId INT AUTO_INCREMENT,
userId INT,
doctorName VARCHAR(50),
doctorEmailPublic VARCHAR(100),
doctorTelPublic VARCHAR(30),
doctorOfficePublic VARCHAR(70),
doctorStreetPublic VARCHAR(100),
doctorHouseNrPublic INT,
doctorZipPublic INT,
doctorCityPublic VARCHAR(50),
PRIMARY KEY (doctorId),
FOREIGN KEY (userId) REFERENCES evcUser(userId)
);

INSERT INTO evcDoctor (doctorId, userId, doctorName, doctorEmailPublic, doctorTelPublic, doctorOfficePublic, 
doctorStreetPublic, doctorHouseNrPublic, doctorZipPublic, doctorCityPublic) VALUES
(1, 1, 'Dr. med. Test','test@medimail.de', '07121/341784', 'Testpraxis', 'Teststrasse', 10, 72760, 'Reutlingen'),
(2, 2, 'Dr. med. Schreiner','schreiner@medimail.de', '07121/341712', 'Schreinerpraxis', 'Sackgasse', 33, 72070, 'Tübingen'),
(3, 3, 'Dr. med. Müller','mueller@medimail.de', '07121/341744', 'Müllerpraxis', 'Baumweg', 12, 72760, 'Reutlingen'),
(4, 4, 'Dr. med. Adler','adler@medimail.de', '07121/341775', 'Adlerpraxis', 'Blumenstrasse', 45, 72070, 'Tübingen'),
(5, 5, 'Dr. med. Zimmer','zimmer@medimail.de', '07121/341717', 'Zimmerpraxis', 'Am Stein', 41, 72760, 'Reutlingen'),
(6, 6, 'Dr. med. Vorso','vorso@medimail.de', '07121/341755', 'Vorsopraxis', 'Seegasse', 71, 72070, 'Tübingen'),
(7, 7, 'Dr. med. Rege','rege@medimail.de', '07121/341754', 'Regepraxis', 'Wiesenweg', 67, 72760, 'Reutlingen'),
(8, 8, 'Dr. med. Hauser','hauser@medimail.de', '07121/341781', 'Hauserpraxis', 'Hofallee', 57, 72070, 'Tübingen'),
(9, 9, 'Dr. med. Igel','igel@medimail.de', '07121/341761', 'Igelpraxis', 'Grubenweg', 26, 72760, 'Reutlingen'),
(10, 10, 'Dr. med. Schranke','schranke@medimail.de', '07121/341795', 'Am Holz', 'Teststrasse', 16, 72070, 'Tübingen');
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
INSERT INTO checkup VALUES (101001, 'Allgemeiner Gesundheits-Check-up 18+', 'Typ 2-Diabetes, Nierenerkrankungen oder Herzprobleme – all diese Erkrankungen können bekämpft werden, wenn man sie frühzeitig erkennt. Gesetzlich Versicherte haben deshalb Anspruch auf eine regelmäßige Gesundheitsuntersuchung, die von der Krankenkasse bezahlt wird. Bei dem Check-up sollen gesundheitliche Risiken und Vorbelastungen abgefragt und Erkrankungen möglichst früh erkannt und bekämpft werden.', 'Checkup', 18, 35, null,'mw');
INSERT INTO checkup VALUES (101002, 'Allgemeiner Gesundheits-Check-up 35+', 'Früherkennung zum Beispiel von Nieren-, Herz-Kreislauferkrankungen und Diabetes. Innerhalb des Check-Ups: Ab Herbst 2021 außerdem einmalig ein Screening auf eine Hepatitis B- und Hepatitis C-Virusinfektion. Damit sollen unentdeckte Infektionen erkannt und frühzeitig behandelt werden, um Spätfolgen zu verhindern. Liegt der letzte Check-up keine drei Jahre zurück, kann das Screening übergangsweise auch separat erfolgen.', 'Checkup', 35, null, 36,'mw');
INSERT INTO checkup VALUES (101003, 'Hautkrebs-Screening', 'Visuelle (mit bloßem Auge), standardisierte Ganzkörperinspektion der gesamten Haut zur Früherkennung von Hautkrebs', 'Checkup', 35, null, 24,'mw');
INSERT INTO checkup VALUES (101004, 'Zahn-Vorsorge', 'Zahnärzte bzw. -ärztinnen diagnostizieren und behandeln Zahn-, Mund- und Kieferkrankheiten samt Anomalien der Zahnstellung. Sie informieren außerdem über Möglichkeiten, Zahn- und Kiefererkrankungen bzw. -schädigungen vorzubeugen.', 'Checkup', 18, null, 12,'mw');


# w checkups adults
INSERT INTO checkup VALUES (201001, 'Genitaluntersuchung zur Früherkennung von Krebserkrankungen', 'Bei der Untersuchung wird der Muttermund inspektiert. Zudem erfolgt ein Krebsabstrich, eine zytologische Untersuchung (Pap-Test) sowie eine gynäkologische Tastuntersuchung.', 'Checkup', 20, null, 12,'w');
INSERT INTO checkup VALUES (201002, 'Test auf eine Infektion mit Chlamydien', 'Die genitale Chlamydia trachomatis-Infektion ist die häufigste sexuell übertragbare bakterielle Erkrankung und birgt ein Risiko für ungewollte Sterilität, Schwangerschaftskomplikationen und Infektionen der Neugeborenen. Daher wird allen Frauen bis zum abgeschlossenen 25. Lebensjahr, die sexuell aktiv sind, einmal jährlich eine Untersuchung auf Chlamydien angeboten.', 'Checkup', 25, null, 12,'w');
INSERT INTO checkup VALUES (201003, 'Brust- und Hautkrebsuntersuchung', 'Zur Krebsvorsorge kommt eine jährliche Brust- und Hautuntersuchung hinzu. Dabei erfolgt eine Inspektion und Abtasten der Brust und der regionären Lymphknoten einschließlich der ärztlichen Anleitung zur Selbstuntersuchung.', 'Checkup', 30, null, 12,'w');
INSERT INTO checkup VALUES (201004, 'Kombi-Screening', 'Bei der Kombinationsuntersuchung wird der vaginale Abstrich sowohl auf HP-Viren (HPV-Test) als auch auf Zellveränderungen (Pap-Test) untersucht. Auffällige Befunde werden weiter abgeklärt, zum Beispiel durch eine weitere Ko-Testung oder eine Spiegelung des Gebärmutterhalses.', 'Checkup', 35, null, 36,'w');
INSERT INTO checkup VALUES (201005, 'Früherkennung von Darmkrebs', 'Bei der Früherkennung von Darmkrebs kann eine Stuhlprobe beim Arzt abgegeben werden. Diese wird im Labor auf verborgenes Blut im Stuhl untersucht.', 'Checkup', 50, 54, 12,'w');
INSERT INTO checkup VALUES (201006, 'Früherkennung von Brustkrebs', 'Zur Früherkennung von Brustkrebs erhalten Sie alle zwei Jahre eine Einladung zum Mammographie-Screening. Dabei erfolgt das Röntgen beider Brüste(Mammographie).', 'Checkup', 50, 69, 24,'w');
INSERT INTO checkup VALUES (201007, 'Früherkennung von Darmkrebs', 'Bei der Früherkennung von Darmkrebs kann eine Stuhlprobe alle zwei Jahre beim Arzt abgegeben werden. Diese wird im Labor auf verborgenes Blut im Stuhl untersucht. Alternativ kann eineDarmspiegelung im Absatand von 10 Jahren durchgeführt werden.', 'Checkup', 55, null, 24,'w');

# m checkups adults
INSERT INTO checkup VALUES (301001, 'Krebsfrüherkennungsuntersuchung der Genitalien und Prostata', 'Bei der Krebsfrüherkennungsuntersuchung der Genitalien und Prostata erfolgt eine Inspektion und Abtasten des äußeren Genitales. Dabei wird die Prostata sowie die regionären Lymphknoten auf Anomalien untersucht.', 'Checkup', 45, null, 12,'m');
INSERT INTO checkup VALUES (301002, 'Früherkennung von Darmkrebs', 'Bei der Früherkennung von Darmkrebs kann eine Stuhlprobe alle zwei Jahre beim Arzt abgegeben werden. Diese wird im Labor auf verborgenes Blut im Stuhl untersucht. Alternativ kann eineDarmspiegelung im Absatand von 10 Jahren durchgeführt werden.', 'Checkup', 50, 54, 12,'m');
INSERT INTO checkup VALUES (301003, 'Früherkennung von Aneurysmen der Bauchschlagader', 'Einmaliger Anspruch auf eine Ultraschalluntersuchung zur Früherkennung von Aneurysmen der Bauchschlagader', 'Checkup', 65, null, null,'m');

# mw checkups kids and juveniles
INSERT INTO checkup VALUES (102001, 'J1: Check der körperlichen Verfassung und seelischen Entwicklung', 'Die J1 umfasst eine eingehende körperliche Untersuchung sowie ein Gespräch über Besonderheiten im Verhalten und in der Entwicklung Ihres Kindes. Körpergröße, Gewicht und Blutdruck werden gemessen, und eine Urinprobe wird untersucht. Der Arzt oder die Ärztin überprüft den Stand der Pubertätsentwicklung.', 'Checkup', 12, 15, null,'mw');
INSERT INTO checkup VALUES (102002, 'Zahn-Vorsorge', 'Untersuchung auf Zahn-, Mund- und Kieferkrankheiten. Dabei wird eine Einschätzung des Kariesrisikos analysiert und gegebenfalls eine Schmelzhärtung mittels lokale Fluoridierung durchgeführt. Zudem werden kariesfreien Fissuren versiegelt.', 'Checkup', 12, 18, 6,'mw');
INSERT INTO checkup VALUES (102003, 'U1', ' Gleich nach der Geburt wird das Neugeborene schon gemessen, bewertet und verglichen (APGAR-Test).', 'Checkup', 0, 18, null,'mw');
INSERT INTO checkup VALUES (102004, 'U2', 'Bei der U2 Basisuntersuchung (3. und 10. Lebenstag) werden die Organe, Geschlechtsteile, Haut und Knochen untersucht sowie die Verdauungstätigkeit und Reflexe des Nervensystems überprüft. Mit einem speziellen Haltegriff wird die Funktionstüchtigkeit des Hüftgelenks getestet. Mittlerweile werden in vielen Kliniken Ultraschalluntersuchungen durchgeführt, um Entwicklungsstörungen im Hüftgelenk vorzeitig zu erkennen.', 'Checkup', 0, 18, null,'mw');
INSERT INTO checkup VALUES (102005, 'U3', 'Bei der U3 Vorsorgeuntersuchung wird kontrolliert, ob sich das Neugeborene (4. bis 6. Lebensowche) in den vergangenen Wochen altersgerecht entwickelt hat. Dabei überprüft der Arzt die Körperfunktionen, das Hörvermögen, die angeborenen Reflexe, das Hüftgelenk mittels Ultraschall, eventuelle Entwicklungsstörungen oder Fehlbildungen sowie motorische Entwicklung wie bspw. die Sprache, das Sozialverhalten und das Spielverhalten.', 'Checkup', 0, 18, null,'mw');
INSERT INTO checkup VALUES (102006, 'U4', 'Die U4 Untersuchung findet zwischen dem 3. und 4. Lebensmonat statt. Der Kinder- und Jugendarzt überprüft die Organe und Geschlechtsteile, das Hör- und Sehvermögen sowie die Knochenlücke (Fontanelle) am Kopf des Kindes. Außerdem werden mit verschiedenen Tests Fähigkeiten untersucht.', 'Checkup', 0, 18, null,'mw');
INSERT INTO checkup VALUES (102007, 'U5', 'Im Alter von einem halben Jahr findet die U5 Vorsorgeuntersuchung statt. Ideal ist der Zeitraum zwischen dem 6. und 7. Lebensmonat. Besondere Aufmerksamkeit wird neben der Motorik auch der Feststellung von neurologischen Auffälligkeiten gewidmet.', 'Checkup', 0, 18, null,'mw');
INSERT INTO checkup VALUES (102008, 'U6', 'Mit fast einem Jahr, in der Regel zwischen 10. und 12. Lebensmonat erfolgt die U6. Die Sozialentwicklung (z. B. „Fremdeln“) und die Sinnes- und Sprachentwicklung stehen bei dieser Untersuchung ganz im Vordergrund. Der Kinder- und Jugendarzt kontrolliert, ob das Kind schon mit gestreckten Beinen und geradem Rücken frei sitzen oder sogar schon alleine stehen und dabei festhalten kann.', 'Checkup', 0, 18, null,'mw');
INSERT INTO checkup VALUES (102009, 'U7', 'Kurz vor dem 2. Geburtstag findet die U7, die so genannte "Zweijahres-Untersuchung" statt.Bei dieser Untersuchung stehen allgemeinen Untersuchungen der Körperfunktionen (+ Gewicht und Größe) und vor allem die Überprüfung der geistigen Entwicklung im Vordergrund.', 'Checkup', 0, 18, null,'mw');
INSERT INTO checkup VALUES (102010, 'U7a', 'Die U7a, die von Kinder- und Jugendärzten im Alter von drei Jahren (zwischen dem 34. und 36. Lebensmonat) angeboten wird, soll dazu beitragen, dass u.a. allergische Erkrankungen, Sozialisations- und Verhaltensstörungen, Übergewicht, Sprachentwicklungsstörungen, Zahn-, Mund- und Kieferanomalien früher erkannt und rechtzeitig behandelt werden.', 'Checkup', 0, 18, null,'mw');
INSERT INTO checkup VALUES (102011, 'U8', 'Bei der U8 Vorsorgeuntersuchung werden Werte von Gewicht, Körperlänge und Kopfumfang in die entsprechenden Kurven eingetragen. Im Vordergrund der Untersuchung stehen Wirbelsäule, das Becken und die Beine.', 'Checkup', 0, 18, null,'mw');
INSERT INTO checkup VALUES (102012, 'U9', ' Die U9 Untersuchung findet im 6. Lebensjahr statt. Dabei wird die Körperlänge gemessen, das Gewicht ermittelt und der Blutdruck überprüft. Es folgt die ausführliche Beurteilung der inneren Organe sowie ihrer Funktion. Auch die Grobmotorik, Feinmotorik und Koordinationsfähigkeit wird begutachtet.', 'Checkup', 0, 18, null,'mw');

# vacc checkups adults
INSERT INTO checkup VALUES (103001, 'Impfung: Tetanus', 'Tetanus-Impfstoffe schützen vor Infektionen mit dem Bakterium Clostridium tetani, dem Verursacher des Tetanus (Wundstarrkrampf). Tetanus ist eine häufig tödlich verlaufende Infektionskrankheit. Impfstoffe gegen Tetanus werden als Kombinationsimpfstoffen angeboten, die mindestens noch vor Diphtherieinfektionen schützen.', 'Vaccination', 18, null, 120,'mw');
INSERT INTO checkup VALUES (103002, 'Impfung: Diphterie', 'Diphtherie-Impfstoffe schützen vor Infektionen mit dem Bakterium Corynebacterium diphtheriae. Sie werden ausschließlich in Form von Kombinationsimpfstoffen angeboten, die mindestens noch vor Tetanusinfektionen schützen.', 'Vaccination', 18, null, 120,'mw');
INSERT INTO checkup VALUES (103003, 'Impfung: FSME', 'FSME-Impfstoffe schützen vor der „Frühsommer-Meningoenzephalitis“ (FSME), die ein Virus der Familie der Flaviviridae verursacht. Bei FSME handelt es sich um eine Gehirn-, Gehirnhaut- oder Rückenmarksentzündung.', 'Vaccination', 18, null, 0,'mw');
INSERT INTO checkup VALUES (103004, 'Impfung: Masern', 'Masern-Impfstoffe schützen vor Infektionen mit dem Masernvirus, einem Virus aus der Familie der Paramyxo-Viren. Impfstoffe gegen Masern werden als MMR- oder MMRV-Kombinationsimpfstoffe angeboten. Die Impfung schützt gegen Masern, Mumps und Röteln sowie gegebenenfalls Varizellen (Windpocken).', 'Vaccination', 18, 50, null,'mw');
INSERT INTO checkup VALUES (103005, 'Impfung: Keuchhusten', 'Pertussis-Impfstoffe schützen vor Infektionen mit dem Bakterium Bordetella pertussis, das Keuchhusten (Pertussis) verursacht.', 'Vaccination', 18, 60, null,'mw');
INSERT INTO checkup VALUES (103006, 'Impfung: Pneumokken', 'Pneumokokken-Impfstoffe schützen vor Infektionen mit den häufigsten und gefährlichsten Pneumokokken,  den Bakterien der Gattung Streptococcus pneumonieae. Pneumokokken können schwere Infektionen, insbesondere Lungenentzündungen verursachen.', 'Vaccination', 60, null, null,'mw');
INSERT INTO checkup VALUES (103007, 'Impfung: Gürtelrose', 'Gürtelrose-Impfstoffe schützen vor Herpes Zoster (Gürtelrose). Die Erkrankung wird durch das Varizella-Zoster-Virus ausgelöst, das bei Erstkontakt Windpocken verursacht.', 'Vaccination', 50, null, null,'mw');
INSERT INTO checkup VALUES (103008, 'Impfung: Grippe', 'Influenza-, d.h. Grippe-Impfstoffe schützen vor der "echten" Grippe. Die Infektion geht mit einer Erkrankung der Atemwege einher. Es wird zwischen Impfstoffen gegen die saisonale Grippe, die jeden Winter auftritt, und präpandemischen und pandemischen Influenzaimpfstoffen unterschieden, die bei drohenden Grippe-Pandemien zum Einsatz kommen.', 'Vaccination', 18, null, 12,'mw');
#INSERT INTO checkup VALUES (103009, 'Impfung: COVID-19', 'Für den Nachweis eines vollständigen Impfschutzes gegen das Coronavirus SARS-CoV-2 muss die zugrundeliegende Schutzimpfung mit einem oder mehreren Impfstoffen erfolgen.', 'Vaccination', 18, null, 6,'mw');

# mw vacc checkups kids and juveniles 
INSERT INTO checkup VALUES (104001, 'Impfung: HPV', 'Impfstoffe gegen HPV (humane Papillomaviren) schützen vor den häufigsten HP-Viren, die Gebärmutterhalskrebs und Tumore im Mund- Rachen- Genital- und Anusbereich verursachen können.', 'Vaccination', 9, 14, null,'mw');

-------------------------------------------------------------------------------------------------
CREATE TABLE evcInsurerCheckupBonus(
insurerCheckupBonusId INT AUTO_INCREMENT,
insurerId INT,
checkupId INT,
bonus INT,
PRIMARY KEY(insurerCheckupBonusId),
FOREIGN KEY (insurerId) REFERENCES evcInsurer(insurerId),
FOREIGN KEY (checkupId) REFERENCES checkup(checkupId)
);
INSERT INTO evcInsurerCheckupBonus VALUES (default, 1, 101001, 200),  (default, 1, 101002, 200),  (default, 1, 101003, 200),  (default, 1, 101004, 200),  (default, 1, 201001, 200),  (default, 1, 201002, 200),  (default, 1, 201003, 200),  (default, 1, 201004, 200),  (default, 1, 201005, 200),  (default, 1, 201006, 200),  (default, 1, 201007, 200),  (default, 1, 301001, 200),  (default, 1, 301002, 200),  (default, 1, 301003, 200),  (default, 1, 102001, 200),  (default, 1, 102002, 200),  (default, 1, 102003, 200),  (default, 1, 102004, 200),  (default, 1, 102005, 200),  (default, 1, 102006, 200),  (default, 1, 102007, 200),  (default, 1, 102008, 200),  (default, 1, 102009, 200),  (default, 1, 102010, 200),  (default, 1, 102011, 200),  (default, 1, 102012, 200),  (default, 1, 103001, 400),  (default, 1, 103002, 400),  (default, 1, 103003, 400),  (default, 1, 103004, 400),  (default, 1, 103005, 400),  (default, 1, 103006, 400),  (default, 1, 103007, 400),  (default, 1, 103008, 400);
INSERT INTO evcInsurerCheckupBonus VALUES (default, 2, 101001, 500),  (default, 2, 101002, 500),  (default, 2, 101003, 500),  (default, 2, 101004, 500),  (default, 2, 201001, 500),  (default, 2, 201002, 500),  (default, 2, 201003, 500),  (default, 2, 201004, 500),  (default, 2, 201005, 500),  (default, 2, 201006, 500),  (default, 2, 201007, 500),  (default, 2, 301001, 500),  (default, 2, 301002, 500),  (default, 2, 301003, 500),  (default, 2, 102001, 500),  (default, 2, 102002, 500),  (default, 2, 102003, 500),  (default, 2, 102004, 500),  (default, 2, 102005, 500),  (default, 2, 102006, 500),  (default, 2, 102007, 500),  (default, 2, 102008, 500),  (default, 2, 102009, 500),  (default, 2, 102010, 500),  (default, 2, 102011, 500),  (default, 2, 102012, 500),  (default, 2, 103001, 500),  (default, 2, 103002, 500),  (default, 2, 103003, 500),  (default, 2, 103004, 500),  (default, 2, 103005, 500),  (default, 2, 103006, 500),  (default, 2, 103007, 500),  (default, 2, 103008, 500);
INSERT INTO evcInsurerCheckupBonus VALUES (default, 3, 101001, 150),  (default, 3, 101002, 150),  (default, 3, 101003, 150),  (default, 3, 101004, 150),  (default, 3, 201001, 150),  (default, 3, 201002, 150),  (default, 3, 201003, 150),  (default, 3, 201004, 150),  (default, 3, 201005, 150),  (default, 3, 201006, 150),  (default, 3, 201007, 150),  (default, 3, 301001, 150),  (default, 3, 301002, 150),  (default, 3, 301003, 150),  (default, 3, 102001, 250),  (default, 3, 102002, 250),  (default, 3, 102003, 250),  (default, 3, 102004, 250),  (default, 3, 102005, 250),  (default, 3, 102006, 250),  (default, 3, 102007, 250),  (default, 3, 102008, 250),  (default, 3, 102009, 250),  (default, 3, 102010, 250),  (default, 3, 102011, 250),  (default, 3, 102012, 250),  (default, 3, 103001, 150),  (default, 3, 103002, 150),  (default, 3, 103003, 150),  (default, 3, 103004, 150),  (default, 3, 103005, 150),  (default, 3, 103006, 150),  (default, 3, 103007, 150),  (default, 3, 103008, 150);
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

INSERT INTO evcUserCheckup (evcUserCheckupId, userId, checkupId, evcUserCheckupDate, evcUserCheckupNotes) VALUES
(default, 12, 103008, '2020-01-01', 'Alles bestens'),(default, 12, 103005, '2010-01-01', 'Alles super'),
(default, 12, 201006, '2000-01-01', 'Unauffällig'),(default, 12, 201007, '1990-01-01', 'Keine Probleme');
-------------------------------------------------------------------------------------------------
CREATE TABLE evcDoctorCheckup(
evcDoctorCheckupId INT AUTO_INCREMENT,
doctorId INT,
checkupId INT,
PRIMARY KEY (evcDoctorCheckupId),
FOREIGN KEY (doctorId) REFERENCES evcDoctor(doctorId),
FOREIGN KEY (checkupId) REFERENCES checkup(checkupId)
);

#INSERT INTO evcDoctorCheckup (evcDoctorCheckupId, doctorId, checkupId) VALUES
#(default, 1, 101001), (default, 1, 101002), (default, 1, 101003);
INSERT INTO evcDoctorCheckup (evcDoctorCheckupId, doctorId, checkupId) VALUES
(default, 1, 101001), (default, 1, 101002), (default, 1, 101003), (default, 1, 102001), (default, 1, 102002),
(default, 1, 102003), (default, 1, 102004), (default, 1, 102005), (default, 1, 102006), (default, 1, 102007),
(default, 1, 102008), (default, 1, 102009), (default, 1, 102010), (default, 1, 102011),(default, 1, 102012),
(default, 1, 103001), (default, 1, 103002), (default, 1, 103003), (default, 1, 103004),
(default, 1, 103005), (default, 1, 103006), (default, 1, 103007), (default, 1, 103008),
(default, 1, 104001), (default, 1, 301002), (default, 1, 301001), (default, 1, 301003),

(default, 2, 101004), (default, 2, 102002),

(default, 3, 101001), (default, 3, 102002), (default, 3, 201001), (default, 3, 201003),
(default, 3, 201004), (default, 3, 201005), (default, 3, 201006), (default, 3, 201007),
(default, 3, 301001), (default, 3, 301002), (default, 3, 301003),

(default, 4, 102001), (default, 4, 102002), (default, 4, 101004), (default, 4, 102003), (default, 4, 102004),
(default, 4, 102005), (default, 4, 102006), (default, 4, 102007), (default, 4, 102008), (default, 4, 101003),
(default, 4, 102009), (default, 4, 102010), (default, 4, 102011), (default, 4, 102012),

(default, 5, 102001), (default, 5, 102002), (default, 5, 102003), (default, 5, 102004),
(default, 5, 102005), (default, 5, 102006), (default, 5, 102007), (default, 5, 102008),
(default, 5, 102009),

(default, 6, 101001), (default, 6, 101002), (default, 6, 301003), (default, 6, 301001),
(default, 6, 301002), (default, 6, 201004), (default, 6, 101003),

(default, 7, 103001), (default, 7, 103002), (default, 7, 103003), (default, 7, 103004),
(default, 7, 103005), (default, 7, 103006), (default, 7, 103007), (default, 7, 103008),
(default, 7, 104001), (default, 7, 101001), (default, 7, 101002),

(default, 8, 201002), (default, 8, 201003), (default, 8, 201004), (default, 8, 201006),

(default, 9, 102001), (default, 9, 102005), (default, 9, 102007), (default, 9, 201006),
(default, 9, 201002), (default, 9, 301001), (default, 9, 301002), (default, 9, 301003),

(default, 10, 101001), (default, 10, 101002), (default, 10, 201002), (default, 10, 301001),
(default, 10, 301002), (default, 10, 301003), (default, 10, 201004), (default, 10, 201005),
(default, 10, 201006), (default, 10, 201007);
-------------------------------------------------------------------------------------------------
