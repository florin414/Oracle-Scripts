-- Exemplu de apel al procedurii pentru adăugarea unui film nou
BEGIN
    AdaugaFilm(2023, 8.5, 'Nume Film Nou', 'Regizor Nou', 'Gen Nou', 120, 'Descriere Nouă', 'Română', 'Engleză');
END;
/

-- Exemplu de apel al procedurii pentru actualizarea rating-ului unui film
BEGIN
    ActualizeazaRatingFilm(1, 9.0);
END;
/
