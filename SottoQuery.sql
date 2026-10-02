/*
	COSA SONO LE SOTTOQUERY?
	Una sottoquery è una query dentro un’altra query.
	Serve per:
		filtrare dati usando risultati di altre tabelle
		calcolare valori intermedi
		sostituire JOIN quando vuoi logica più compatta
		creare condizioni avanzate nel WHERE, HAVING, SELECT
*/

-- 1. SOTTOQUERY nel WHERE
-- Obiettivo
--	Trovare gli studenti che hanno preso il voto massimo in tutti i corsi.

-- 🔎 passo 1 Trovare il voto massimo in intero
SELECT CAST(MAX(Voto) AS INT) [Voto Massimo] FROM Voti; -- 30

--passo 2 (subquery) 

SELECT 
CONCAT(s.Nome,' ',s.Cognome) AS Nome,
v.Voto
FROM Students as s
FULL JOIN Voti as v 
	ON s.StudenteId = v.StudenteID 

WHERE v.voto = 
(															 --inizio subquery 
	SELECT																
		MAX(Voto) as [Voto Massimo]
	FROM Voti
);


--2. SOTTOQUERY nel SELECT
-- Obiettivo
-- Mostrare ogni studente con la media dei suoi voti (senza GROUP BY).
-- Passo 1 Restituire la lista di tutti gli studenti

SELECT Nome, Cognome, CodiceFiscale FROM students;

-- Passo 2 medie dei Voti

SELECT 
     AVG(Voto) [Voto Medio]-- 25.900000
FROM Voti;

-- Passo 3 Unire le due query sopra per ottenere il risulato🎉

SELECT 
nome,cognome,CodiceFiscale,

(
	SELECT 
		AVG(Voto) [Media Voti]
	FROM Voti
) 
AS [Media Voti]

FROM students;

--ELENCARE LE PERSONE CHE PRENDONO UN VOTO MAGGIORE UGUALE A 28 
SELECT
	Nome,
	Cognome,
	CodiceFiscale

FROM students 
WHERE StudenteId IN (
	SELECT 
		StudenteId
	FROM Voti
	WHERE Voto >= 28
);

--4) SOTTOQUERY CON EXISTS

SELECT
	Nome,
	Cognome
FROM students as s  
WHERE 
	EXISTS(
	SELECT 1
	FROM Voti as v
	WHERE s.StudenteID = v.StudenteID
);


--Mostrare gli studenti che hanno preso un voto superiore alla media generale 

-- 1) MEDIA VOTI

SELECT 
	AVG(Voto) [La media dei voti] -------> 25.90
FROM Voti 
--query finale 

SELECT
	Nome,
	Cognome
FROM 
	students as s 
JOIN
	Voti as v
ON s.StudenteId = v.StudenteID  
WHERE v.Voto >						--la query principale mostra i voti superiori alla media 
(
SELECT 
	AVG(Voto) [La media dei voti]     --la subquery qui calcola la media 
FROM Voti 
);