-- Script SQL cu 15 interogări complexe

-- 1. Top 5 filme cu cele mai multe evaluări și media rating-ului
SELECT f.titlu, COUNT(ef.id) AS numar_evaluari, AVG(ef.rating) AS rating_mediu
FROM Film f
LEFT JOIN EvaluareFilm ef ON f.id = ef.id_film
GROUP BY f.id, f.titlu
ORDER BY numar_evaluari DESC, rating_mediu DESC
FETCH FIRST 5 ROWS ONLY;

-- Explicatie: Aceasta interogare returnează top 5 filme cu cele mai multe evaluări și media rating-ului acestora.

-- 2. Actorii care au jucat în filme de același gen
SELECT a.nume, f.gen
FROM Actor a
JOIN Distributie d ON a.id = d.id_actor
JOIN Film f ON d.id_film = f.id
WHERE EXISTS (
    SELECT 1
    FROM Distributie d2
    JOIN Film f2 ON d2.id_film = f2.id
    WHERE a.id = d2.id_actor AND f2.gen = f.gen
);

-- Explicatie: Aceasta interogare găsește actorii care au jucat în filme de același gen.

-- 3. Filmele cu cel mai mic și cel mai mare rating mediu
SELECT f.titlu, AVG(ef.rating) AS rating_mediu
FROM Film f
LEFT JOIN EvaluareFilm ef ON f.id = ef.id_film
GROUP BY f.id, f.titlu
HAVING AVG(ef.rating) = (SELECT MIN(AVG(ef2.rating)) FROM EvaluareFilm ef2 GROUP BY ef2.id_film)
   OR AVG(ef.rating) = (SELECT MAX(AVG(ef3.rating)) FROM EvaluareFilm ef3 GROUP BY ef3.id_film);

-- Explicatie: Aceasta interogare găsește filmele cu cel mai mic și cel mai mare rating mediu.

-- 4. Utilizatori care au evaluat toate categoriile de filme
SELECT u.nume
FROM Utilizator u
CROSS JOIN CategorieFilm cf
WHERE NOT EXISTS (
    SELECT 1
    FROM FilmCategorie fc
    LEFT JOIN EvaluareFilm ef ON fc.id_film = ef.id_film AND u.id = ef.id_utilizator
    WHERE cf.id = fc.id_categorie AND ef.id IS NULL
);

-- Explicatie: Aceasta interogare identifică utilizatorii care au evaluat toate categoriile de filme.

-- 5. Top 3 cele mai populare limbi de dublaj și numărul de filme
SELECT d.limba, COUNT(f.id) AS numar_filme
FROM Dublaj d
JOIN FilmDublaj fd ON d.id = fd.id_dublaj
JOIN Film f ON fd.id_film = f.id
GROUP BY d.id, d.limba
ORDER BY numar_filme DESC
FETCH FIRST 3 ROWS ONLY;

-- Explicatie: Aceasta interogare returnează top 3 limbi de dublaj cu cel mai mare număr de filme asociate.

-- 6. Filmele cu distribuție formată din actori cu înălțimea peste 1.80
SELECT f.titlu
FROM Film f
JOIN Distributie d ON f.id = d.id_film
JOIN Actor a ON d.id_actor = a.id
WHERE a.inaltime > 1.80;

-- Explicatie: Aceasta interogare găsește filmele cu distribuție formată din actori cu înălțimea peste 1.80.

-- 7. Utilizatori care au evaluat toate filmele dintr-o categorie specifică
SELECT u.nume, cf.nume AS categorie
FROM Utilizator u
CROSS JOIN CategorieFilm cf
WHERE NOT EXISTS (
    SELECT 1
    FROM FilmCategorie fc
    LEFT JOIN EvaluareFilm ef ON fc.id_film = ef.id_film AND u.id = ef.id_utilizator
    WHERE cf.id = fc.id_categorie AND ef.id IS NULL
);

-- Explicatie: Aceasta interogare identifică utilizatorii care au evaluat toate filmele dintr-o categorie specifică.

-- 8. Categoriile de filme cu cel mai mare număr de evaluări pozitive (rating >= 4.0)
SELECT cf.nume, COUNT(ef.id) AS numar_evaluari_pozitive
FROM CategorieFilm cf
JOIN FilmCategorie fc ON cf.id = fc.id_categorie
JOIN Distributie d ON fc.id_film = d.id_film
JOIN EvaluareFilm ef ON d.id_film = ef.id_film AND ef.rating >= 4.0
GROUP BY cf.id, cf.nume
ORDER BY numar_evaluari_pozitive DESC;

-- Explicatie: Aceasta interogare găsește categoriile de filme cu cel mai mare număr de evaluări pozitive.

-- 9. Top 5 actori cu cele mai multe filme și media rating-ului acestora
SELECT a.nume, COUNT(DISTINCT d.id_film) AS numar_filme, AVG(ef.rating) AS rating_mediu
FROM Actor a
LEFT JOIN Distributie d ON a.id = d.id_actor
LEFT JOIN EvaluareFilm ef ON d.id_film = ef.id_film
GROUP BY a.id, a.nume
ORDER BY numar_filme DESC, rating_mediu DESC
FETCH FIRST 5 ROWS ONLY;

-- Selectarea informațiilor despre utilizatorul, abonamentul și platformele sale
SELECT
    u.id AS utilizator_id,
    u.nume AS nume_utilizator,
    u.email AS email_utilizator,
    a.id AS abonament_id,
    a.nume AS nume_abonament,
    a.pret AS pret_abonament,
    p.id AS platforma_id,
    p.nume AS nume_platforma
FROM
    Utilizator u
JOIN
    UtilizatorAbonamentPlatforma uap ON u.id = uap.id_utilizator
JOIN
    Abonament a ON uap.id = a.id
JOIN
    PlatformaStreaming p ON uap.id_platforma = p.id
WHERE
    u.id = 1;

-- Explicatie: Aceasta interogare identifică utilizatorii care au evaluat filme în toate limbile disponibile.

-- 11. Filmele cu cel mai mare număr de evaluări pozitive (rating >= 4.5)
SELECT f.titlu, COUNT(ef.id) AS numar_evaluari
FROM Film f
LEFT JOIN EvaluareFilm ef ON f.id = ef.id_film AND ef.rating >= 4.5
GROUP BY f.id, f.titlu
ORDER BY numar_evaluari DESC
FETCH FIRST 1 ROW ONLY;

-- Explicatie: Aceasta interogare returnează filmul cu cel mai mare număr de evaluări pozitive (rating >= 4.5).

-- 12. Actorii care au jucat în filme cu rating peste 4.0
SELECT DISTINCT a.nume
FROM Actor a
JOIN Distributie d ON a.id = d.id_actor
JOIN Film f ON d.id_film = f.id
WHERE EXISTS (
    SELECT 1
    FROM EvaluareFilm ef
    WHERE d.id_film = ef.id_film AND ef.rating > 4.0
);

-- Explicatie: Aceasta interogare găsește actorii care au jucat în filme cu rating peste 4.0.

-- 13. Top 3 utilizatori cu cele mai multe evaluări și media rating-ului dat
SELECT u.nume, COUNT(ef.id) AS numar_evaluari, AVG(ef.rating) AS rating_mediu
FROM Utilizator u
LEFT JOIN EvaluareFilm ef ON u.id = ef.id_utilizator
GROUP BY u.id, u.nume
ORDER BY numar_evaluari DESC, rating_mediu DESC
FETCH FIRST 3 ROWS ONLY;

-- Explicatie: Aceasta interogare returnează top 3 utilizatori cu cele mai multe evaluări și media rating-ului acestora.

-- 14. Categorii de filme cu cei mai mulți actori unici
SELECT cf.nume, COUNT(DISTINCT d.id_actor) AS numar_actori
FROM CategorieFilm cf
JOIN FilmCategorie fc ON cf.id = fc.id_categorie
JOIN Distributie d ON fc.id_film = d.id_film
GROUP BY cf.id, cf.nume
ORDER BY numar_actori DESC;

-- Explicatie: Aceasta interogare găsește categoriile de filme cu cei mai mulți actori unici.

-- 15. Filmele cu cel mai lung și cel mai scurt titlu
SELECT f.titlu, LENGTH(f.titlu) AS lungime_titlu
FROM Film f
WHERE LENGTH(f.titlu) = (SELECT MIN(LENGTH(f2.titlu)) FROM Film f2)
   OR LENGTH(f.titlu) = (SELECT MAX(LENGTH(f3.titlu)) FROM Film f3);

-- Explicatie: Aceasta interogare găsește filmele cu cel mai lung și cel mai scurt titlu.

