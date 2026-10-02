USE ScuolaDb;
GO

--primo passo con select 
SELECT * from Students

/*
-- Secondo passo con 'SELECT'

    Esempio: 
        select 
            colonna1, 
            colonna2, 
            ...
        from tabella 
*/

SELECT 
    Nome,
    Cognome,
    Codicefiscale
    FROM Students ; 

--concatenazione di 2 colonne (+) 
--Alias = AS per definire il nome di una colonna

SELECT 
     Nome +' '+ Cognome AS [Nome Completo],
     Codicefiscale AS [CF],
     Email AS [Indirizzo mail]
FROM Students ; 

SELECT * FROM Students

--Where filtra a seconda della condizione 

-- IS NULL è NULLO / IS NOT NULL non è NULLO con il filtro WHERE   

--esempio 
SELECT 
     Nome +' '+ Cognome AS [Nome Completo],
     Codicefiscale AS [CF],
     Email AS [Indirizzo mail],
     Data_Nascita AS [Data di nascita]
FROM Students 
WHERE Data_Nascita IS NOT NULL ;

/* 
Restituire la lista degli studenti che non hanno la data di nascita
Campi da visualizzare: Nome completo , email , data di nascita, codice fiscale */
SELECT 
     Nome +' '+ Cognome AS [Nome Completo],
     Codicefiscale AS [CF],
     Email AS [Indirizzo mail],
     Data_Nascita AS [Data di nascita]
FROM Students 
WHERE Data_Nascita IS NULL ;

--ORDER BY ordina le colonne 
SELECT 
     Nome +' '+ Cognome AS [Nome Completo], --AS attiva ALIASS cioè rinomina la colonna aliass di colonna
     Codicefiscale AS [CF],
     Email AS [Indirizzo mail],
     Data_Nascita AS [Data di nascita]
FROM Students 
WHERE Data_Nascita IS NULL 
ORDER BY [Nome Completo] DESC;


