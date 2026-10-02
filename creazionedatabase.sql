-- usa il database indicato
USE ScuolaDb;
-- con il GO facciamo andare avanti l'esecuzione con il codice sotto GO 
GO 


-- I TIPI DI DATI IN SQL SERVER

/*
    I TIPI DI DATI DI SQL
        INT      = INTERO
        CHAR     = CARATTERE (A)
        VARCHAR  = TESTO (STRINGA) 
        NVARCHAR = TESTO (STRINGA) 
        FLOAT    = DECIMALI (10, 2)
        DATE     = DATA 
*/

-- CREAZIONE TABELLE 
CREATE TABLE Studenti(

    -- ID univoco dello studente
    -- INT = numero intero
    -- PRIMARY KEY = chiave primaria (identifica ogni riga)
    -- IDENTITY(1,1) = auto incremento (parte da 1 e aumenta di 1)
    StudentiID INT NOT NULL PRIMARY KEY IDENTITY(1,1),

    -- Nome dello studente
    -- NVARCHAR(50) = testo Unicode (supporta caratteri speciali)
    -- NOT NULL = campo obbligatorio
    Nome NVARCHAR(50) NOT NULL,

    -- Cognome dello studente
    Cognome NVARCHAR(50) NOT NULL,

    -- Data di nascita
    -- DATE = formato YYYY-MM-DD
    -- NULL = opzionale
    DataNascita DATE NULL,

    -- Email
    -- UNIQUE = non possono esistere duplicati
    -- NOT NULL = obbligatorio
    Email NVARCHAR(150) UNIQUE NOT NULL,

    -- Numero di telefono
    -- VARCHAR = testo normale (no Unicode)
    Telefono VARCHAR(50) UNIQUE NOT NULL,

    -- Codice Fiscale
    -- CHAR(16) = lunghezza fissa di 16 caratteri
    CodiceFiscale CHAR(16) UNIQUE NOT NULL
);

-- Restituire tutte le righe della tabella studenti
-- Select * from Studenti  = restituisce tutte le righe della tabella studenti 


--CREAZIONE TABELLA CORSI 
CREATE TABLE Corsi(
    CorsoID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NomeCorso NVARCHAR(100) NOT NULL,
    Descrizione NVARCHAR(255) NULL,
    Crediti INT,
    Durata INT
    );

--CREAZIONE TABELLA DOCENTI 

CREATE TABLE Docenti (
    DocenteId INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    Nome NVARCHAR(50) NOT NULL,
    Cognome NVARCHAR(50) NOT NULL,
    Email NVARCHAR(150) UNIQUE NULL, 
    Specializzazione NVARCHAR(50) NOT NULL 
    ); 

-- Creazione della tabella Aule
CREATE TABLE Aule(
    AulaId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    NomeAula NVARCHAR(150) NOT NULL,
    Capacita INT NOT NULL
);

--PRIMARY E FOREIGN KEY

--seleziono solo lo studente con ID uguale a 3

SELECT * 
FROM students 
WHERE StudentiID = 3 ;

EXEC sp_rename 'Students.StudentiID', 'StudenteId';

CREATE TABLE Voti ( 
    VotoId INT NOT NULL PRIMARY KEY IDENTITY (1,1),
    
    --Foreign Key (sono chiavi primarie di altre table)
    StudenteID INT NOT NULL, 
    CorsoID INT NOT NULL,
    --Queste sopra sono le colonne foreign key 

    Voto DECIMAL(4,2) NOT NULL,
    DataVoto DATE NOT NULL,
    Note NVARCHAR(255) NULL, 
    
    Superato BIT NOT NULL, --BIT è tipo booleano restituisce true / false
    FOREIGN KEY (StudenteId) REFERENCES Students(StudenteId),
    FOREIGN KEY (CorsoId) REFERENCES Corsi(CorsoId) 
    );
 
 --   SELECT GETDATE(); Restituisce data e ora attuali 
 
 /* Creazione della tabella iscrizioni relazionale : 
 STUDENTI N ; N Corsi ; 
Uno studente può frequentare diversi corsi , un corso può avere più studenti 
*/

 CREATE TABLE Iscrizioni(

    IscrizioneId INT NOT NULL PRIMARY KEY IDENTITY (1,1),

    StudenteId INT NOT NULL,
    CorsoId INT NOT NULL,
    DataIscrizione DATE DEFAULT GETDATE(),
    Stato NVARCHAR(30) NOT NULL DEFAULT 'Attiva',

    FOREIGN KEY (StudenteId) REFERENCES Students(StudenteId), 
    FOREIGN KEY (CorsoId) REFERENCES Corsi(CorsoId) ,
    
    CONSTRAINT UQ_Iscrizione_Studente_Corso
        UNIQUE (StudenteId,CorsoId) 
    );

    --Tabella per collegare docenti al corso
    CREATE TABLE DocentiCorso(
    DocenteCorso INT PRIMARY KEY IDENTITY(1,1),
    DocenteId INT NOT NULL,
    CorsoId INT NOT NULL,
    
    DataRegistrazione DATE NULL,
    DataAssegnazione DATE NULL,
    Ruolo NVARCHAR(50) NULL,

    FOREIGN KEY (DocenteId) REFERENCES Docenti(DocenteId),
    FOREIGN KEY (CorsoId) REFERENCES Corsi(CorsoId),

    -- EVITA DI ASSEGNARE DUE VOLTE LO STESSO DOCENTE ALLLO STESSO CORSO
    CONSTRAINT UQ_Docente_Corso
        UNIQUE (DocenteId, CorsoId)
);
    
    CREATE TABLE Lezioni (
        LezioneId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
        CorsoId INT NOT NULL, 
        AulaId INT NOT NULL,

        Titolo NVARCHAR(100) NOT NULL,
        Descrizione NVARCHAR(MAX) NULL,
        DataLezione DATE NOT NULL,
        OraInizio TIME NOT NULL, 
        OraFine TIME NOT NULL, 
        Durata INT NULL,

        FOREIGN KEY (CorsoId) REFERENCES Corsi(CorsoId),
        FOREIGN KEY (AulaId) REFERENCES Aule(AulaId) 
        );

        --aggiornamentoS