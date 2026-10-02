use ScuolaDb;
go



SELECT 
	s.Nome + ' ' + s.Cognome AS Studente,
	s.CodiceFiscale as CF,
	ISNULL(CONVERT(VARCHAR, i.DataIscrizione, 105), ' Data non definita ') as [Data Iscrizione]

FROM students AS s

 Left JOIN Iscrizioni i 
	ON i.StudenteId = s.StudenteId;

/* Restituire i voti medi degli studenti,
   Campi da visualizzare: Nome completo,CF,Voto
*/ 

SELECT 
	CONCAT(s.Nome,' ',s.Cognome) AS Studente,
	s.CodiceFiscale as CF,
	CAST(AVG (v.Voto)AS INT) as [Media Voti]  --CAST(INT) converte da decimale in intero 

From students as s
JOIN Voti as v
ON s.StudenteId = v.StudenteID

GROUP BY s.Nome,s.Cognome,s.CodiceFiscale;

--i corsi senza iscritti
SELECT 
    ISNULL(c.NomeCorso, 'Non definito') AS Corso,
    CAST(ISNULL(c.Crediti, 0) as INT) as Crediti,
    CAST(ISNULL(c.Durata,  0) as INT) as Durata
FROM Students s 
LEFT JOIN Iscrizioni i
    ON i.StudenteId = s.StudenteId
LEFT JOIN Corsi c
    ON c.CorsoId = i.CorsoId
WHERE c.CorsoId IS NOT NULL
ORDER by s.Nome ASC;