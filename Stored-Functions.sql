-- Funcție pentru calculul duratei totale a unui film în minute
CREATE OR REPLACE FUNCTION DurataTotalaFilm(p_id_film NUMBER)
RETURN NUMBER
IS
    v_durata_totala NUMBER;
BEGIN
    SELECT SUM(durata)
    INTO v_durata_totala
    FROM Film
    WHERE id = p_id_film;

    RETURN v_durata_totala;
END DurataTotalaFilm;
/


-- Funcție pentru numărul de evaluări pozitive ale unui film
CREATE OR REPLACE FUNCTION EvaluariPozitiveFilm(p_id_film NUMBER)
RETURN NUMBER
IS
    v_nr_evaluari NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_nr_evaluari
    FROM EvaluareFilm
    WHERE id_film = p_id_film AND rating > 7;

    RETURN v_nr_evaluari;
END EvaluariPozitiveFilm;
/


-- Funcție pentru returnarea unei liste de actori în funcție de țara natală
CREATE OR REPLACE FUNCTION ListaActoriDupaTara(p_tara_natala VARCHAR2)
RETURN VARCHAR2
IS
    v_lista_actori VARCHAR2(4000);
BEGIN
    SELECT LISTAGG(nume, ', ') WITHIN GROUP (ORDER BY nume)
    INTO v_lista_actori
    FROM Actor
    WHERE tara_natala = p_tara_natala;

    RETURN v_lista_actori;
END ListaActoriDupaTara;
/
