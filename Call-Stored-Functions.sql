DECLARE
    v_nr_evaluari NUMBER;
BEGIN
    v_nr_evaluari := EvaluariPozitiveFilm(2); -- Înlocuiește 2 cu ID-ul filmului dorit
    DBMS_OUTPUT.PUT_LINE('Numărul de evaluări pozitive: ' || v_nr_evaluari);
END;
/

DECLARE
    v_lista_actori VARCHAR2(4000);
BEGIN
    v_lista_actori := ListaActoriDupaTara('SUA'); -- Înlocuiește 'SUA' cu țara dorită
    DBMS_OUTPUT.PUT_LINE('Lista actorilor din SUA: ' || v_lista_actori);
END;
/