-- Creare secvență pentru ID-ul filmului
CREATE SEQUENCE SEQ_FILM START WITH 1 INCREMENT BY 1;

-- Procedura stocată pentru adăugarea unui film nou
CREATE OR REPLACE PROCEDURE AdaugaFilm (
    p_an NUMBER,
    p_rating FLOAT,
    p_titlu VARCHAR2,
    p_regizor VARCHAR2,
    p_gen VARCHAR2,
    p_durata NUMBER,
    p_descriere CLOB,
    p_limbaj_dublaj VARCHAR2,
    p_limbaj_subtitrare VARCHAR2
) AS
    v_id_film NUMBER; -- Variabila pentru a stoca ID-ul unic al filmului
BEGIN
    -- Generare ID unic pentru film
    SELECT SEQ_FILM.NEXTVAL INTO v_id_film FROM DUAL;

    -- Inserare film nou
    INSERT INTO Film (
        id, an, rating, titlu, regizor, gen, durata, descriere, limbaj_dublaj, limbaj_subtitrare
    ) VALUES (
        v_id_film, p_an, p_rating, p_titlu, p_regizor, p_gen, p_durata, p_descriere, p_limbaj_dublaj, p_limbaj_subtitrare
    );

    COMMIT; -- Confirmă operațiunile de inserare în baza de date
    DBMS_OUTPUT.PUT_LINE('Film adăugat cu succes. ID Film: ' || v_id_film);
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK; -- În caz de eroare, face rollback pentru a anula modificările
        DBMS_OUTPUT.PUT_LINE('Eroare la adăugarea filmului: ' || SQLERRM); -- Afișează un mesaj de eroare
END AdaugaFilm;
/

-- Procedura stocată pentru actualizarea rating-ului unui film
CREATE OR REPLACE PROCEDURE ActualizeazaRatingFilm (
    p_id_film NUMBER,
    p_nou_rating FLOAT
) AS
BEGIN
    -- Actualizare rating film
    UPDATE Film
    SET rating = p_nou_rating
    WHERE id = p_id_film;

    COMMIT; -- Confirmă operațiunile de actualizare în baza de date
    DBMS_OUTPUT.PUT_LINE('Rating-ul filmului actualizat cu succes. ID Film: ' || p_id_film);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK; -- În cazul în care filmul nu există, face rollback
        DBMS_OUTPUT.PUT_LINE('Filmul cu ID ' || p_id_film || ' nu există.');
    WHEN OTHERS THEN
        ROLLBACK; -- În caz de eroare, face rollback pentru a anula modificările
        DBMS_OUTPUT.PUT_LINE('Eroare la actualizarea rating-ului filmului: ' || SQLERRM); -- Afișează un mesaj de eroare
END ActualizeazaRatingFilm;
/
