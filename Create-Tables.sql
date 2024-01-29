CREATE TABLE TipAbonament (
    id NUMBER PRIMARY KEY,
    nume VARCHAR2(50) NOT NULL,
    pret NUMBER(8, 2) NOT NULL,
    durata_zile NUMBER,
    descriere_facilitati CLOB
);

CREATE TABLE Abonament (
    id NUMBER PRIMARY KEY,
    nume VARCHAR2(50) NOT NULL,
    pret NUMBER(8, 2) NOT NULL,
    durata_zile NUMBER,
    descriere_facilitati CLOB
);

CREATE TABLE Utilizator (
    id NUMBER PRIMARY KEY,
    nume VARCHAR2(100) NOT NULL,
    email VARCHAR2(255) UNIQUE NOT NULL
);

CREATE TABLE PlatformaStreaming (
    id NUMBER PRIMARY KEY,
    nume VARCHAR2(255) NOT NULL,
    descriere CLOB,
    website VARCHAR2(255),
    disponibilitate_regiuni VARCHAR2(100),
    id_abonament NUMBER UNIQUE,
    CONSTRAINT fk_platforma_abonament FOREIGN KEY (id_abonament) REFERENCES Abonament(id) ON DELETE CASCADE
);

CREATE TABLE UtilizatorAbonamentPlatforma (
    id NUMBER PRIMARY KEY,
    id_utilizator NUMBER,
    id_platforma NUMBER,
    CONSTRAINT fk_utilizator_platforma FOREIGN KEY (id_utilizator) REFERENCES Utilizator(id) ON DELETE CASCADE,
    CONSTRAINT fk_platforma FOREIGN KEY (id_platforma) REFERENCES PlatformaStreaming(id) ON DELETE CASCADE,
    CONSTRAINT uc_utilizator_platforma UNIQUE (id_utilizator, id_platforma)
);

CREATE TABLE CategorieFilm (
    id NUMBER PRIMARY KEY,
    nume VARCHAR2(50) NOT NULL,
    descriere CLOB
);

CREATE TABLE Film (
    id NUMBER PRIMARY KEY,
    an NUMBER,
    rating FLOAT,
    titlu VARCHAR2(255),
    regizor VARCHAR2(255),
    gen VARCHAR2(50),
    durata NUMBER,
    descriere CLOB,
    limbaj_dublaj VARCHAR2(50),
    limbaj_subtitrare VARCHAR2(50)
);

CREATE TABLE Subtitrare (
    id NUMBER PRIMARY KEY,
    limba VARCHAR2(50) NOT NULL,
    continut CLOB
);

CREATE TABLE Dublaj (
    id NUMBER PRIMARY KEY,
    limba VARCHAR2(50) NOT NULL,
    continut CLOB
);

CREATE TABLE FilmSubtitrare (
    id_film NUMBER,
    id_subtitrare NUMBER,
    PRIMARY KEY (id_film, id_subtitrare),
    CONSTRAINT fk_film_subtitrare_film FOREIGN KEY (id_film) REFERENCES Film(id) ON DELETE CASCADE,
    CONSTRAINT fk_film_subtitrare_subtitrare FOREIGN KEY (id_subtitrare) REFERENCES Subtitrare(id) ON DELETE CASCADE
);

CREATE TABLE FilmDublaj (
    id_film NUMBER,
    id_dublaj NUMBER,
    PRIMARY KEY (id_film, id_dublaj),
    CONSTRAINT fk_film_dublaj_film FOREIGN KEY (id_film) REFERENCES Film(id) ON DELETE CASCADE,
    CONSTRAINT fk_film_dublaj_dublaj FOREIGN KEY (id_dublaj) REFERENCES Dublaj(id) ON DELETE CASCADE
);

CREATE TABLE Actor (
    id NUMBER PRIMARY KEY,
    nume VARCHAR2(100) NOT NULL,
    data_nasterii DATE,
    tara_natala VARCHAR2(50),
    inaltime NUMBER,
    gen VARCHAR2(10),
    CONSTRAINT uc_actor_nume UNIQUE (nume)
);

CREATE TABLE Distributie (
    id_film NUMBER,
    id_actor NUMBER,
    rol_jucat VARCHAR2(100) NOT NULL,
    CONSTRAINT pk_distributie PRIMARY KEY (id_film, id_actor),
    CONSTRAINT fk_distributie_film FOREIGN KEY (id_film) REFERENCES Film(id) ON DELETE CASCADE,
    CONSTRAINT fk_distributie_actor FOREIGN KEY (id_actor) REFERENCES Actor(id) ON DELETE CASCADE
);

CREATE TABLE EvaluareFilm (
    id NUMBER PRIMARY KEY,
    id_film NUMBER,
    id_utilizator NUMBER,
    CONSTRAINT fk_evaluare_film FOREIGN KEY (id_film) REFERENCES Film(id) ON DELETE CASCADE,
    CONSTRAINT fk_evaluare_utilizator FOREIGN KEY (id_utilizator) REFERENCES Utilizator(id) ON DELETE CASCADE,
    comentariu VARCHAR2(255),
    rating NUMBER
);

CREATE TABLE FilmCategorie (
    id NUMBER PRIMARY KEY,
    id_film NUMBER,
    id_categorie NUMBER,
    CONSTRAINT fk_film_categorie_film FOREIGN KEY (id_film) REFERENCES Film(id) ON DELETE CASCADE,
    CONSTRAINT fk_film_categorie_categorie FOREIGN KEY (id_categorie) REFERENCES CategorieFilm(id) ON DELETE CASCADE
);
