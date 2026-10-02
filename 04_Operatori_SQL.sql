/*

	OPERATORI PRINCIPALI DI SQL 
	 = Uguale 
	<> Diverso da 
	!= Diverso  da
	< Minore 
	> Maggiore 
	<= Minore Uguale 
	>= Maggiore Uguale 

*/ 

--1 UGUALE: 
-- restituisce solo lo studente con id 4 
SELECT 
	StudenteId,
	Nome,
	Cognome,
	Email
FROM students
WHERE StudenteId = 4 ; 

-- Restituire tutti gli studenti tranne con Id (5) 

SELECT 
	StudenteId,
	Nome,
	Cognome,
	Email
FROM students 
WHERE StudenteId != 5;

-- Restituire i corsi che hanno piu di 5 crediti 

Select 
	 *
From Corsi 
Where
	Crediti > 5;

--I corsi con crediti minori di 5 crediti 
Select DISTINCT 
	NomeCorso,
	Descrizione,
	Crediti

From Corsi 
Where
	Crediti < 5;

-- Restituire la lista dei corsi con almeno 5 crediti e durata maggiore di 50 ore 

SELECT DISTINCT 
	*
FROM Corsi
WHERE Crediti >= 5 AND Durata > 50;

-- Restituire la lista dei corsi con almeno 5 crediti o durata maggiore di 50 ore

SELECT DISTINCT 
	*
FROM Corsi
WHERE Crediti >= 5 OR
Durata > 50;

--Restituire la lista dei corsi con 5 crediti oppure con 3 crediti 

SELECT DISTINCT 
CorsoID,NomeCorso,Descrizione,Crediti 
FROM Corsi 
WHERE Crediti = 5 OR
Crediti = 3; 


/* ==================================
FILTRO DEGLI STUDENTI PER NOME 
=====================================*/

SELECT * 
FROM students 
WHERE Nome = 'Anna';

/* ==================================
FILTRO DEGLI STUDENTI PER COGNOME 
=====================================*/

SELECT * 
FROM students 
WHERE Cognome = 'rossi'; 


	SELECT 
		Nome + ' ' + Cognome AS 'Nome Completo',
		Data_Nascita
	FROM 
		students
	WHERE
		Data_Nascita BETWEEN '2001-01-01' AND '2002-12-31' ; 

--TOP Seleziona solo i primi 10 studenti che non hanno inserito la data di nascita 
	SELECT TOP 10 * 
	FROM students
	WHERE Data_Nascita IS NOT NULL;

--IN Effettua la ricerca nella lista nelle () 
	SELECT TOP 5 *
	FROM	
		Corsi
	WHERE Crediti IN (6,5)
	ORDER BY Crediti ASC;


--Restituisci la lista dei primi 5 corsi con una durata compresa tra 30 e 50 ore in ordine crescente

	SELECT TOP 5
	*
	FROM Corsi 
	WHERE Durata BETWEEN 30 AND 50 
	ORDER BY NomeCorso ASC;

--Restutire la lista degli studenti nati tra anno 2000 e 2002 

	SELECT * FROM students
	WHERE Data_Nascita 
	BETWEEN '01-01-2000' AND '31-12-2002';

--LIKE 
	SELECT *
	FROM Corsi
	WHERE NomeCorso LIKE 'c%';


