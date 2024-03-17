USE Djuriska

------- Uppgift 1. Skapa tabellerna ---------
/*
CREATE TABLE Owners.Kund (
  kundID INT NOT NULL IDENTITY PRIMARY KEY,
  fnamn NVARCHAR(20) NOT NULL,
  enamn NVARCHAR(20) NOT NULL,
  persnr VARCHAR(13) NULL,
  gatuadr NVARCHAR(25) NULL,
  postnr VARCHAR(5) NULL,
  ort NVARCHAR(25) NULL,
  rabatt DECIMAL (5,2) DEFAULT (0) NOT NULL
)
ON FG_Owners
GO
*/

/*
CREATE TABLE Animals.Art (
  artID INT NOT NULL IDENTITY PRIMARY KEY,
  namn NVARCHAR(25) NOT NULL
 )
ON FG_Animals
GO
*/

/*
CREATE TABLE Animals.Ras (
  rasID INT NOT NULL IDENTITY PRIMARY KEY,
  namn NVARCHAR(25) NOT NULL,
  artID INT NOT NULL 
)
ON FG_Animals
GO 
*/

/*
CREATE TABLE Animals.Djur (
  djurID INT NOT NULL IDENTITY PRIMARY KEY,
  namn NVARCHAR(25) NOT NULL,
  rasID INT NOT NULL,
  kundID INT NOT NULL 
)
ON FG_Animals
GO 
*/



--------- Uppgift 2. Import av data ---------

/*
INSERT INTO Owners.Kund (fnamn, enamn, persnr, gatuadr, postnr, ort) VALUES ('Camilla','Dalheim','581012-8125','Övägen 81',10186,'Bromma');

INSERT INTO Animals.Art (namn) VALUES ('katt');

INSERT INTO Animals.Ras (namn, artID) VALUES ('korat', 1);

INSERT INTO Animals.Djur (namn, rasID, kundID) VALUES ('Ramses',42,8);

*/

--------- Uppgift 3. SELECT, satser -----------

--a) Implicit join (from/where)
/*
SELECT D.djurID, 
D.namn AS DjurNamn, 
R.namn AS RasNamn, 
A.namn AS ArtNamn
FROM Animals.Djur D, Animals.Ras R, Animals.Art A
WHERE
	D.rasID = R.rasID
	AND R.artID = A.artID
ORDER BY A.namn, R.namn, D.namn;
*/

-- (inner) join --
/*
SELECT D.djurID, 
D.namn AS DjurNamn, 
R.namn AS RasNamn, 
A.namn AS ArtNamn
FROM Animals.Djur AS D
	INNER JOIN Animals.Ras AS R ON D.rasID = R.rasID
	INNER JOIN Animals.Art AS A ON R.artID = A.artID
ORDER BY A.namn, R.namn, D.namn;

*/


--b) Implicit join (from/where)

/*
SELECT D.djurID, 
D.namn AS DjurNamn, 
R.namn AS RasNamn, 
A.namn AS ArtNamn
FROM Animals.Djur D, Animals.Ras R, Animals.Art A
WHERE
	D.rasID = R.rasID
	AND R.artID = A.artID
	AND D.namn = 'Carl';

*/

-- (inner) join --
/*
SELECT D.djurID, 
D.namn AS DjurNamn, 
R.namn AS RasNamn, 
A.namn AS ArtNamn
FROM Animals.Djur AS D
	INNER JOIN Animals.Ras AS R ON D.rasID = R.rasID
	INNER JOIN Animals.Art AS A ON R.artID = A.artID
WHERE D.namn = 'Carl';

*/

--c) Implicit join (from/where)
/*
SELECT K.kundID, 
K.fnamn AS KundFnamn, 
K.enamn AS KundEnamn,
COUNT(D.djurID) AS AntalDjur
FROM Animals.Djur D, Owners.Kund K
WHERE D.kundID = K.kundID
GROUP BY K.kundID, K.fnamn, K.enamn;

*/

-- (inner) join --
/*
SELECT K.kundID, 
K.fnamn AS KundFnamn, 
K.enamn AS KundEnamn,
COUNT(D.djurID) AS AntalDjur
FROM Animals.Djur D 
	INNER JOIN Owners.Kund K ON D.kundID = K.kundID
GROUP BY K.kundID, K.fnamn, K.enamn;

*/


---	Tar fram alla djur som tillhör kunden med högst antal djur, t.ex  ’Berit Rihs’ (10 st. Djur)
/*
SELECT D.djurID, D.namn AS DjurNamn, R.namn AS RasNamn
FROM Animals.Djur D
	INNER JOIN Animals.Ras R ON D.rasID = R.rasID
	INNER JOIN Owners.Kund K ON D.kundID = K.kundID
WHERE K.fnamn = 'Berit';

*/

--d) Implicit join (from/where)

/*
SELECT K.fnamn AS KundFnamn, K.enamn AS KundEnamn, COUNT(D.djurID) AS Total_Djur, A.namn AS Arten
FROM Animals.Djur D, Owners.Kund K, Animals.Ras R, Animals.Art A
WHERE K.kundID = D.kundID
AND D.rasID = R.rasID
AND R.artID = A.artID
AND K.fnamn = 'Louise'
AND K.enamn = 'Nilsson'
GROUP BY
K.fnamn, K.enamn, A.namn;

*/

-- (inner) join --
/*
SELECT K.fnamn AS KundFnamn, K.enamn AS KundEnamn, COUNT(D.djurID) AS Total_Djur, A.namn AS Arten
FROM Animals.Djur D
JOIN Owners.Kund K ON K.kundID = D.kundID
JOIN Animals.Ras R ON D.rasID = R.rasID
JOIN Animals.Art A ON R.artID = A.artID
WHERE K.fnamn = 'Louise'
AND K.enamn = 'Nilsson'
GROUP BY
K.fnamn, K.enamn, A.namn;

*/


------- Uppgift 4. Constraints ---------

/*
-- Lägg till Främmande nyckeln för artID i tabellen Animals.Ras
ALTER TABLE Animals.Ras 
ADD CONSTRAINT FK_Ras_artID FOREIGN KEY (artID) REFERENCES Animals.Art (artID) 

*/
/*
-- Lägg till Främmande nycklar för rasID/kundID i tabellen Animals.Djur
ALTER TABLE Animals.Djur 
ADD CONSTRAINT FK_Djur_rasID FOREIGN KEY (rasID) REFERENCES Animals.Ras (rasID)

*/
/*
ALTER TABLE Animals.Djur 
ADD CONSTRAINT FK_Djur_kundID FOREIGN KEY (kundID) REFERENCES Owners.Kund (kundID)

*/

/*
-- Lägg till constraint för personnummer 
ALTER TABLE Owners.Kund 
ADD CONSTRAINT CK_ValidatePersnr
CHECK (persnr LIKE '[0-9][0-9][0-1][0-9][0-3][0-9]-[0-9][0-9][0-9][0-9]');

*/
/*
-- Lägg till constraint för unika personnummer 
ALTER TABLE Owners.Kund
ADD CONSTRAINT UniQ_Persnr UNIQUE (persnr); 

*/
-- Tar bort constraint för det unika personnumret
/*
ALTER TABLE Owners.Kund
DROP CONSTRAINT UniQ_Persnr; 
*/

/*
-- Lägg till constraint för positivt rabattvärde 
ALTER TABLE Owners.Kund
ADD CONSTRAINT CK_PositivRabatt CHECK (rabatt >= 0);

*/




------- Uppgift 5. Lägga till data ---------


-- Lägga till en ras med ett artID som inte finns 
/*
INSERT INTO Animals.Ras (namn, artID)
VALUES ('Bengal', 17);

*/

-- Lägga till rasen 'yorkshireterrier' som en hund
/*
INSERT INTO Animals.Ras (namn, artID)
SELECT 'yorkshireterrier', artID
FROM Animals.Art
WHERE namn = 'hund';

*/

-- Välja alla hundar från Ras-tabellen
/*
SELECT R.rasID, R.namn AS RasNamn, A.namn AS ArtNamn
FROM Animals.Ras R
	INNER JOIN Animals.Art A ON R.artID = A.artID
WHERE A.namn = 'hund'
ORDER BY R.namn; 

*/

-- Lägger till en ny kund 
/*
INSERT INTO Owners.Kund (fnamn, enamn, persnr, gatuadr, postnr, ort, rabatt)
VALUES ('Amina', 'Hallam', '911114-7881', 'Gatuadress 12', '12345', 'Göteborg', 0.10); 

*/

-- Hämtar först kunID som tillhör 'Amina' 'Hallam'

-- SELECT kundID FROM Owners.Kund WHERE fnamn = 'Amina'; 
-- kundID -> 31 


-- Lägger till en ny ras som tillhör artID = 1 
/*
INSERT INTO Animals.Ras (namn, artID)
VALUES ('Bengal', 1); 
*/

-- SELECT rasID FROM Animals.Ras WHERE namn = 'Bengal'; 
-- rasID -> 63

-- Lägger till ett nytt djur som tillhör den nya kunden 
/*
INSERT INTO Animals.Djur (namn, rasID, kundID)
VALUES ('Shrek', 63, 31);

*/


-- Ta fram all info. från den nya kunden samt djurets namn, rasen och arten, med hjälp av INNER JOIN

/*
SELECT K.*, D.namn AS Djurnamnet, R.namn AS Rasen, A.namn AS Arten
FROM Owners.Kund K
	INNER JOIN Animals.Djur D ON k.kundID = D.kundID
	INNER JOIN Animals.Ras R ON D.rasID = R.rasID
	INNER JOIN Animals.Art A ON R.artID = A.artID
	WHERE K.fnamn = 'Amina' AND K.enamn = 'Hallam'; 

*/



