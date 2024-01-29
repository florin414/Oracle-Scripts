-- Adaugare coloana data_modificare in tabela Film
ALTER TABLE Film ADD (data_modificare TIMESTAMP);

-- Trigger pentru validare și modificare înainte de inserarea unui film
CREATE OR REPLACE TRIGGER ValidareFilm
BEFORE INSERT ON Film
FOR EACH ROW
BEGIN
    -- Validare an: nu permite inserarea filmelor cu an mai mic de 1900
    IF :NEW.an < 1900 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Anul filmului nu poate fi mai mic de 1900.');
    END IF;

    -- Validare rating: asigură că rating-ul este între 0 și 10
    IF :NEW.rating < 0 OR :NEW.rating > 10 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Rating-ul filmului trebuie să fie între 0 și 10.');
    END IF;
END ValidareFilm;
/

-- Trigger pentru actualizarea datei ultimei modificări a unui film
CREATE OR REPLACE TRIGGER ActualizareDataModificare
BEFORE UPDATE ON Film
FOR EACH ROW
BEGIN
    -- Actualizare data_modificare la data curentă
    :NEW.data_modificare := SYSTIMESTAMP;
END ActualizareDataModificare;
/

-- Trigger pentru a preveni ștergerea unui utilizator cu evaluări de filme
CREATE OR REPLACE TRIGGER ProtectieStergereUtilizator
BEFORE DELETE ON Utilizator
FOR EACH ROW
DECLARE
    v_nr_evaluari NUMBER;
BEGIN
    -- Verifică dacă utilizatorul are evaluări de filme
    SELECT COUNT(*)
    INTO v_nr_evaluari
    FROM EvaluareFilm
    WHERE id_utilizator = :OLD.id;

    -- Dacă are evaluări, nu permite ștergerea
    IF v_nr_evaluari > 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Nu se poate șterge utilizatorul cu evaluări de filme asociate.');
    END IF;
END ProtectieStergereUtilizator;
/
