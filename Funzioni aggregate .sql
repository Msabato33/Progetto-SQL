-- Le Funzioni Aggregate in SQL Server
/*
    Le funzioni aggregate permettono di
    effetuare calcoli sulle righe
    
    Le principali sono:
    
    |COUNT()    | Conta           |
    |-----------|---------------|
    |SUM()        | SOMMA         |
    |-----------|---------------|
    |AVG()        | Media         |
    |-----------|---------------|
    |MIN()        | Valore Minim |
    |-----------|---------------|
    |MAX()        | Valore Massimo|
    |-----------|---------------|
    
*/


-- 1 Totole righe degli studenti
SELECT 
    COUNT(*) AS [Numero Totale degli Studenti]
FROM students;

-- 2 COUNRT / UNION ALL
SELECT 
    'Students' AS Tabella, 
    COUNT(*) AS NumeroRighe 
FROM students

UNION ALL

SELECT 
    'Corsi',
    COUNT(*)
FROM Corsi

UNION ALL

SELECT 
    'Docenti',
    COUNT(*) AS 
FROM Docenti

UNION ALL

SELECT 
    'Docenti Corso',
    COUNT(*)
FROM DocentiCorso

UNION ALL

SELECT 
    'Aule',
    COUNT(*)
FROM Aule

UNION ALL

SELECT 
    'Iscrizioni',
    COUNT(*)
FROM Iscrizioni

UNION ALL

SELECT 
    'Lezioni',
    COUNT(*)
FROM Lezioni

UNION ALL

SELECT 
    'Voti',
    COUNT(*)
FROM Voti;


----------------------------

--- Restituire la somma totale dei crediti della tabella 'Corsi' 

SELECT DISTINCT 
    SUM(Crediti) AS TotaleCrediti
FROM Corsi;

--4 Restituire la media dei crediti 
SELECT 
 AVG(Durata) AS 'Media Durata' 
 FROM Corsi;

 --5 Trovare il minimo dei crediti 
 Select
    MIN(Crediti) AS 'Valore minimo crediti'
FROM Corsi;

--5 Trovare il massimo dei crediti 
 Select
    MAX(Crediti) AS 'Valore massimo crediti'
FROM Corsi;


/*  
    GROUP BY 
    Il "group by" serve per raggruppare i record. 
    per esempio, voglio sapere quanti docenti abbiamo specializzazione
    
*/

SELECT 
    Specializzazione,
    COUNT(*) AS 'Totale Docenti'
    FROM Docenti 
    GROUP BY Specializzazione; 


  SELECT 
    Nome + '' + Cognome AS 'Nome Completo',
    COUNT(*) AS 'Nome Docenti con D'
    FROM Docenti 
    GROUP BY 'Nome Completo'; 


    --


SELECT 
    Nome + ' ' + Cognome AS [Nome Docente],
    Specializzazione,
    COUNT(*) AS [Totale Docenti]
FROM Docenti
WHERE Specializzazione LIKE 'D%'
GROUP BY Nome, Cognome, Specializzazione
ORDER BY [Nome Docente] ASC;


--- ESERCIZI SOLO

-- CONTEGGIO DI TUTTI I CORSI RINOMINANDO LA COLONNA IN [Numero totale Corsi]
--SOMMA DEI CREDITI RINOMINANDO LA COLONNA IN [SOMMA DEI CREDITI]

SELECT
    COUNT(*) AS  [Numero totale Corsi],
    SUM(Crediti) AS [Somma dei crediti]
    FROM Corsi;

--Estrarre la colonna specializzazione in ordine alfabetico e a fianco quanti professori ci sono per ciascuna materia 

SELECT
    Specializzazione,
    COUNT(DocenteID) AS [Totale Docenti] 
    FROM Docenti
    GROUP BY Specializzazione
    ORDER BY Specializzazione ASC;

--Voglio estrarre la colonna ID_Studente  e a fianco la media dei suoi voti.

    SELECT 
        StudenteID,
    AVG (Voto) AS [Media Voti]
    FROM Voti
    GROUP BY StudenteID;

--quante Specializzazione diverse/uniche ci sono in tutta la tabella?

    SELECT 
        COUNT(DISTINCT Specializzazione) AS [Specializzazione uniche] 
    FROM Docenti; 


--quanti corsi esistono con quel taglio di crediti 

    SELECT 
        Crediti,
    COUNT (CorsoID) AS [Numero di corsi per quei crediti]
    FROM Corsi
    GROUP BY Crediti;

--"Voglio sapere quanti corsi abbiamo per ogni taglio di Crediti... ma non di tutta la scuola. Voglio questa statistica solo per i corsi 
--il cui nome inizia con la parola 'Data' (es. Data Analysis, Database, Data Science)
    
    SELECT 
         Crediti,
    COUNT (CorsoID) AS [Numero di corsi che inizia per Data ]
    FROM Corsi
    WHERE NomeCorso LIKE 'L%'
    GROUP BY Crediti;



   SELECT 
        Nome,Cognome, 
        'Professore' AS [Ruolo] 
   FROM Docenti

   UNION ALL 

   SELECT 
        Nome,Cognome,
        'Alunno' AS [Ruolo]
    FROM Students;

--MOSTRA SOLO LE SPECIALIZZAZIONI CHE HANNO ALMENO 3 
    SELECT 
        Specializzazione,
        COUNT(*) AS [Totale Docenti]
    FROM Docenti
    GROUP BY Specializzazione
    HAVING COUNT(*) >=3;

/* DIFFERENZA FONDAMENTALE TRA:
WHERE: Filtra le righe prima del raggruppamento 

schema in ordine:
SELECT 
FROM
WHERE
GROUP BY 
HAVING 
    (SELECT
    ORDER BY)
    

HAVING: filtra i gruppi dopo il raggruppamento 
*/


-- restituire la lista degli studenti iscritti 

--NOME COMPLETO,DATA NASCITA,CODICE FISCALE,DATA ISCRIZIONE 
SELECT 
    s.Nome+' '+s.Cognome AS [Nome completo] ,
    s.Data_Nascita,
    s.CodiceFiscale,
    i.DataIscrizione
FROM students as s 
 JOIN Iscrizioni as i
ON s.StudenteId = i.StudenteId;

--ESEMPIO 2 :
--Restituisci la lista degli studenti iscritti ad un corso 
SELECT 
    s.Nome+' '+s.Cognome AS [Nome completo] ,
    s.Data_Nascita,
    s.CodiceFiscale,
    i.DataIscrizione,
    c.NomeCorso+' '+C.Descrizione AS [Corso],
    c.Durata AS [Durata Corso]
    
FROM students as s 
 JOIN Iscrizioni as i
ON s.StudenteId = i.StudenteId 
 JOIN Corsi AS c
 ON i.CorsoId=c.CorsoId;


--Studenti non iscritti ad un corso 
SELECT 
    s.Nome+' '+s.Cognome AS [Nome completo] ,
    s.Data_Nascita,
    s.CodiceFiscale,
    i.DataIscrizione

FROM students as s 
JOIN Iscrizioni as i
ON s.StudenteId = i.StudenteId 
WHERE s.Data_Nascita IS NULL; 

/*
Docenti,Corsi,Aule Lezioni
Lezioni<->Studenti<->Corsi
Iscrizioni<->Studenti<-Corsi
DocentiCorsi<-Docenti

Restituire il nome dello:studente,il corso,l'aula, il docente , lezione
*/

Select * from students;
Select * from Iscrizioni; --studente,corso
Select * from Corsi;
Select * from Lezioni; --Corso , Aula
Select * from Docenti; 
Select * from DocentiCorso;--Docente,corso
Select * from Aule;


    SELECT DISTINCT 
    s.nome+ ' ' + s.cognome AS [Nome Completo] , 
    c.NomeCorso , a.NomeAula, d.Nome as [Nome docente],
    l.Titolo
    FROM students AS s

    JOIN Iscrizioni AS i
        ON s.StudenteId = i.StudenteId

    JOIN Corsi AS c
        ON c.CorsoID = i.CorsoId

    JOIN DocentiCorso AS dc
        ON dc.CorsoId = c.CorsoID

    JOIN Docenti AS d
        ON d.DocenteId = dc.DocenteId

    JOIN Lezioni as l
        ON c.CorsoID = l.CorsoId

    JOIN Aule as a
        ON a.AulaId = l.AulaId


--Primo Report Completo 
-- Totale Corsi , Media dei corsi , somma crediti , credito minimo e massimo


SELECT 
    COUNT(*) AS [Totale Corsi],
    AVG(Crediti) AS [Media dei Crediti],
    SUM(Crediti) AS [Totale Crediti],
    MIN(Crediti) AS [Minimo Crediti],
    MAX(Crediti) AS [Massimo Crediti]
FROM Corsi;

-------------------------------------------
--LEFT JOIN MOSTRA I RECORD DELLA TABELLA A SINISTRA 
--ANCHE PER I DATI CHE NON HANNO CORRISPONDENZA ON QUELLA DI DESTRA

SELECT TOP 10*
FROM students as s 
LEFT JOIN Iscrizioni as i
    ON i.StudenteId = s.StudenteId
LEFT JOIN Corsi as c
    ON i.CorsoId = c.CorsoID
WHERE Data_Nascita IS NOT NULL
    AND Data_Nascita <> '2000'
ORDER BY Data_Nascita ASC 


--Restituisce la lista degli studenti non scritti

SELECT
ISNULL(s.Nome + ' ' + S.Cognome, ' Studente non assegnato') AS Studente,
ISNULL(CONVERT(VARCHAR,s.Data_Nascita,105), 'N/D') AS [Data di nascita],
ISNULL(s.Email,'Non Definita') AS Email,
ISNULL(s.CodiceFiscale,'CF0000') AS CF,
ISNULL(s.Telefono,'00000') AS [Numero di telefono],
ISNULL(CONVERT(varchar, i.DataIscrizione,105), 'N/D') AS [Data Iscrizione],
ISNULL(c.NomeCorso ,'Non definito') AS [Nome Corso],
ISNULL(c.Descrizione , 'Non definita') AS Descrizione,
ISNULL(c.crediti,'0') AS Crediti,
ISNULL(CONVERT(varchar, c.durata),'n/d') AS Durata

FROM students as s

LEFT JOIN Iscrizioni AS i
    ON s.StudenteId = i.StudenteId 

LEFT JOIN Corsi AS c
    ON i.CorsoId = c.CorsoID;

------------

--La funzione ISNULL()  restituisce valore specificato se l'espressione è null 
--Convert() 

SELECT 
    Nome , Cognome,
    ISNULL(CONVERT(VARCHAR,Data_Nascita,100), 'Non esiste') AS DataNascita
FROM students
WHERE Data_Nascita IS NULL;


SELECT 
    Titolo + ' '+ Descrizione AS Materia,
    ISNULL(LEFT(CONVERT(VARCHAR,OraInizio,108),2),'N/D') AS Ora  --prende le prime 2 cifre da sinistra(LEFT) di OraInizio

FROM Lezioni;


SELECT 
    Titolo + ' '+ Descrizione AS Materia,
    ISNULL(LEFT(CONVERT(VARCHAR,OraInizio,108),2),'N/D') AS Ora,
    ISNULL(LEFT(CONVERT(VARCHAR,OraInizio,108),5),'N/D') AS Minuti,
    DATEPART(MINUTE,OraInizio) AS Minuti
FROM Lezioni;


--VOGLIO SOLO I MINUTI 
SELECT 
 Titolo + ' '+ Descrizione AS Materia,
 'la lezione inizia alle ' + 
 ISNULL(LEFT(CONVERT(VARCHAR,OraInizio,108),2),'N/D') AS Ora,
 RIGHT('0' + CAST(DATEPART(MINUTE,OraInizio) AS nvarchar(2)), 2 ) as Minuti
FROM Lezioni; 
