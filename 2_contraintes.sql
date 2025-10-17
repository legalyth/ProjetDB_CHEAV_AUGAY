
-- Script de contraintes

-- PARTIE 1 : CONTRAINTES D'INTÉGRITÉ RÉFÉRENTIELLE


-- Contraintes pour CERTIFICAT_MEDICAL
ALTER TABLE CERTIFICAT_MEDICAL
ADD CONSTRAINT fk_certificat_adherent 
    FOREIGN KEY (id_adherent) REFERENCES ADHERENT(id_adherent)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- Contraintes pour BADGE
ALTER TABLE BADGE
ADD CONSTRAINT fk_badge_adherent 
    FOREIGN KEY (id_adherent) REFERENCES ADHERENT(id_adherent)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- Contraintes pour ABONNEMENT
ALTER TABLE ABONNEMENT
ADD CONSTRAINT fk_abonnement_adherent 
    FOREIGN KEY (id_adherent) REFERENCES ADHERENT(id_adherent)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE ABONNEMENT
ADD CONSTRAINT fk_abonnement_type 
    FOREIGN KEY (id_type_abonnement) REFERENCES TYPE_ABONNEMENT(id_type_abonnement)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

ALTER TABLE ABONNEMENT
ADD CONSTRAINT fk_abonnement_duree 
    FOREIGN KEY (id_duree) REFERENCES DUREE(id_duree)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

-- Contraintes pour PRESENCE
ALTER TABLE PRESENCE
ADD CONSTRAINT fk_presence_adherent 
    FOREIGN KEY (id_adherent) REFERENCES ADHERENT(id_adherent)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- Contraintes pour SPECIALITE_COACH
ALTER TABLE SPECIALITE_COACH
ADD CONSTRAINT fk_specialite_coach_coach 
    FOREIGN KEY (id_coach) REFERENCES COACH(id_coach)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE SPECIALITE_COACH
ADD CONSTRAINT fk_specialite_coach_specialite 
    FOREIGN KEY (id_specialite) REFERENCES SPECIALITE(id_specialite)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- Contraintes pour COURS_COLLECTIF
ALTER TABLE COURS_COLLECTIF
ADD CONSTRAINT fk_cours_type 
    FOREIGN KEY (id_type_cours) REFERENCES TYPE_COURS(id_type_cours)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

ALTER TABLE COURS_COLLECTIF
ADD CONSTRAINT fk_cours_coach 
    FOREIGN KEY (id_coach) REFERENCES COACH(id_coach)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

ALTER TABLE COURS_COLLECTIF
ADD CONSTRAINT fk_cours_salle 
    FOREIGN KEY (id_salle) REFERENCES SALLE(id_salle)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

-- Contraintes pour RESERVATION
ALTER TABLE RESERVATION
ADD CONSTRAINT fk_reservation_adherent 
    FOREIGN KEY (id_adherent) REFERENCES ADHERENT(id_adherent)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE RESERVATION
ADD CONSTRAINT fk_reservation_cours 
    FOREIGN KEY (id_cours) REFERENCES COURS_COLLECTIF(id_cours)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- Contraintes pour SESSION_COACHING
ALTER TABLE SESSION_COACHING
ADD CONSTRAINT fk_session_adherent 
    FOREIGN KEY (id_adherent) REFERENCES ADHERENT(id_adherent)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE SESSION_COACHING
ADD CONSTRAINT fk_session_coach 
    FOREIGN KEY (id_coach) REFERENCES COACH(id_coach)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

-- Contraintes pour SUIVI_NUTRITIONNEL
ALTER TABLE SUIVI_NUTRITIONNEL
ADD CONSTRAINT fk_suivi_adherent 
    FOREIGN KEY (id_adherent) REFERENCES ADHERENT(id_adherent)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- Contraintes pour ACHAT
ALTER TABLE ACHAT
ADD CONSTRAINT fk_achat_adherent 
    FOREIGN KEY (id_adherent) REFERENCES ADHERENT(id_adherent)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE ACHAT
ADD CONSTRAINT fk_achat_produit 
    FOREIGN KEY (id_produit) REFERENCES PRODUIT(id_produit)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;


-- PARTIE 2 : CONTRAINTES D'UNICITÉ


-- Email unique pour chaque adhérent
ALTER TABLE ADHERENT
ADD CONSTRAINT uq_email_adherent UNIQUE (email_adherent);

-- Numéro de badge unique
ALTER TABLE BADGE
ADD CONSTRAINT uq_numero_badge UNIQUE (numero_badge_acces);

-- Un coach ne peut avoir qu'une seule fois la même spécialité
ALTER TABLE SPECIALITE_COACH
ADD CONSTRAINT uq_coach_specialite UNIQUE (id_coach, id_specialite);


-- PARTIE 3 : CONTRAINTES DE VÉRIFICATION (CHECK)

-- Contraintes sur ADHERENT
ALTER TABLE ADHERENT
ADD CONSTRAINT chk_age_minimum
CHECK (TIMESTAMPDIFF(YEAR, date_naissance_adherent, CURDATE()) >= 16);

ALTER TABLE ADHERENT
ADD CONSTRAINT chk_genre_valide
CHECK (genre_adherent IN ('Homme', 'Femme', 'Autre'));

ALTER TABLE ADHERENT
ADD CONSTRAINT chk_email_format
CHECK (email_adherent LIKE '%@%.%');

ALTER TABLE ADHERENT
ADD CONSTRAINT chk_telephone_format
CHECK (numero_telephone_adherent REGEXP '^0[0-9]{9}$');

-- Contraintes sur CERTIFICAT_MEDICAL
ALTER TABLE CERTIFICAT_MEDICAL
ADD CONSTRAINT chk_dates_certificat
CHECK (date_expiration_certificat > date_emission_certificat);

ALTER TABLE CERTIFICAT_MEDICAL
ADD CONSTRAINT chk_duree_certificat
CHECK (TIMESTAMPDIFF(MONTH, date_emission_certificat, date_expiration_certificat) <= 12);

-- Contraintes sur TYPE_ABONNEMENT
ALTER TABLE TYPE_ABONNEMENT
ADD CONSTRAINT chk_prix_abonnement_positif
CHECK (prix_abonnement > 0);

ALTER TABLE TYPE_ABONNEMENT
ADD CONSTRAINT chk_type_abonnement_valide
CHECK (type_abonnement IN ('standard', 'premium', 'étudiant'));

-- Contraintes sur DUREE
ALTER TABLE DUREE
ADD CONSTRAINT chk_duree_valide
CHECK (duree_abonnement IN ('mensuel', 'annuel'));

-- Contraintes sur ABONNEMENT
ALTER TABLE ABONNEMENT
ADD CONSTRAINT chk_dates_abonnement
CHECK (date_fin > date_debut);

-- Contraintes sur PRESENCE
ALTER TABLE PRESENCE
ADD CONSTRAINT chk_dates_presence
CHECK (date_sortie_salle IS NULL OR date_sortie_salle > date_entree_salle);

ALTER TABLE PRESENCE
ADD CONSTRAINT chk_duree_presence_max
CHECK (date_sortie_salle IS NULL OR 
       TIMESTAMPDIFF(HOUR, date_entree_salle, date_sortie_salle) <= 8);

-- Contraintes sur COURS_COLLECTIF
ALTER TABLE COURS_COLLECTIF
ADD CONSTRAINT chk_participants_cours
CHECK (nombre_max_participants_cours > 0 AND nombre_max_participants_cours <= 50);

ALTER TABLE COURS_COLLECTIF
ADD CONSTRAINT chk_horaire_cours
CHECK (horaire_cours >= '06:00:00' AND horaire_cours <= '23:00:00');

-- Contraintes sur RESERVATION
ALTER TABLE RESERVATION
ADD CONSTRAINT chk_date_reservation_future
CHECK (date_reservation <= DATE_ADD(CURDATE(), INTERVAL 3 MONTH));

-- Contraintes sur SESSION_COACHING
ALTER TABLE SESSION_COACHING
ADD CONSTRAINT chk_duree_session
CHECK (duree_session_coaching >= 15 AND duree_session_coaching <= 180);

ALTER TABLE SESSION_COACHING
ADD CONSTRAINT chk_date_session_recente
CHECK (date_session_coaching >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR));

-- Contraintes sur PRODUIT
ALTER TABLE PRODUIT
ADD CONSTRAINT chk_prix_produit_positif
CHECK (prix_produit > 0);

ALTER TABLE PRODUIT
ADD CONSTRAINT chk_prix_produit_max
CHECK (prix_produit <= 500);

-- Contraintes sur ACHAT
ALTER TABLE ACHAT
ADD CONSTRAINT chk_quantite_positive
CHECK (quantite_vendue > 0);

ALTER TABLE ACHAT
ADD CONSTRAINT chk_quantite_raisonnable
CHECK (quantite_vendue <= 100);

ALTER TABLE ACHAT
ADD CONSTRAINT chk_date_achat_passee
CHECK (date_achat <= CURDATE());


-- PARTIE 4 : INDEX POUR OPTIMISER LES PERFORMANCES


-- Index sur les colonnes fréquemment recherchées
CREATE INDEX idx_adherent_email ON ADHERENT(email_adherent);
CREATE INDEX idx_adherent_nom ON ADHERENT(nom_adherent, prenom_adherent);
CREATE INDEX idx_badge_numero ON BADGE(numero_badge_acces);

-- Index sur les clés étrangères pour les jointures
CREATE INDEX idx_certificat_adherent ON CERTIFICAT_MEDICAL(id_adherent);
CREATE INDEX idx_abonnement_adherent ON ABONNEMENT(id_adherent);
CREATE INDEX idx_abonnement_dates ON ABONNEMENT(date_debut, date_fin);
CREATE INDEX idx_presence_adherent ON PRESENCE(id_adherent);
CREATE INDEX idx_presence_dates ON PRESENCE(date_entree_salle, date_sortie_salle);

-- Index sur les tables de liaison
CREATE INDEX idx_reservation_adherent ON RESERVATION(id_adherent);
CREATE INDEX idx_reservation_cours ON RESERVATION(id_cours);
CREATE INDEX idx_reservation_date ON RESERVATION(date_reservation);
CREATE INDEX idx_session_adherent ON SESSION_COACHING(id_adherent);
CREATE INDEX idx_session_coach ON SESSION_COACHING(id_coach);
CREATE INDEX idx_achat_adherent ON ACHAT(id_adherent);
CREATE INDEX idx_achat_produit ON ACHAT(id_produit);
CREATE INDEX idx_achat_date ON ACHAT(date_achat);

-- Index composites pour les requêtes complexes
CREATE INDEX idx_cours_type_horaire ON COURS_COLLECTIF(id_type_cours, horaire_cours);
CREATE INDEX idx_specialite_coach_composite ON SPECIALITE_COACH(id_coach, id_specialite);


-- PARTIE 5 : TRIGGERS POUR ASSURER LA COHÉRENCE

-- Trigger : Vérifier qu'un adhérent a un certificat médical valide avant de créer un abonnement
DELIMITER //
CREATE TRIGGER trg_verif_certificat_avant_abonnement
BEFORE INSERT ON ABONNEMENT
FOR EACH ROW
BEGIN
    DECLARE cert_valide INT;
    
    SELECT COUNT(*) INTO cert_valide
    FROM CERTIFICAT_MEDICAL
    WHERE id_adherent = NEW.id_adherent
      AND date_expiration_certificat >= NEW.date_debut;
    
    IF cert_valide = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'L''adhérent doit avoir un certificat médical valide pour souscrire un abonnement';
    END IF;
END//
DELIMITER ;

-- Trigger : Vérifier que le nombre de réservations ne dépasse pas la capacité du cours
DELIMITER //
CREATE TRIGGER trg_verif_capacite_cours
BEFORE INSERT ON RESERVATION
FOR EACH ROW
BEGIN
    DECLARE nb_reservations INT;
    DECLARE capacite_max INT;
    
    SELECT COUNT(*) INTO nb_reservations
    FROM RESERVATION
    WHERE id_cours = NEW.id_cours
      AND date_reservation = NEW.date_reservation;
    
    SELECT nombre_max_participants_cours INTO capacite_max
    FROM COURS_COLLECTIF
    WHERE id_cours = NEW.id_cours;
    
    IF nb_reservations >= capacite_max THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Le cours est complet, impossible d''ajouter une réservation';
    END IF;
END//
DELIMITER ;

-- Trigger : Vérifier qu'un adhérent a un abonnement actif pour réserver un cours
DELIMITER //
CREATE TRIGGER trg_verif_abonnement_actif_reservation
BEFORE INSERT ON RESERVATION
FOR EACH ROW
BEGIN
    DECLARE abo_actif INT;
    
    SELECT COUNT(*) INTO abo_actif
    FROM ABONNEMENT
    WHERE id_adherent = NEW.id_adherent
      AND NEW.date_reservation BETWEEN date_debut AND date_fin;
    
    IF abo_actif = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'L''adhérent doit avoir un abonnement actif pour réserver un cours';
    END IF;
END//
DELIMITER ;

-- Trigger : Vérifier qu'un adhérent a un abonnement actif pour entrer dans la salle
DELIMITER //
CREATE TRIGGER trg_verif_abonnement_actif_presence
BEFORE INSERT ON PRESENCE
FOR EACH ROW
BEGIN
    DECLARE abo_actif INT;
    
    SELECT COUNT(*) INTO abo_actif
    FROM ABONNEMENT
    WHERE id_adherent = NEW.id_adherent
      AND DATE(NEW.date_entree_salle) BETWEEN date_debut AND date_fin;
    
    IF abo_actif = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'L''adhérent doit avoir un abonnement actif pour accéder à la salle';
    END IF;
END//
DELIMITER ;

-- Trigger : Calculer automatiquement la date de fin selon la durée choisie
DELIMITER //
CREATE TRIGGER trg_calcul_date_fin_abonnement
BEFORE INSERT ON ABONNEMENT
FOR EACH ROW
BEGIN
    DECLARE type_duree VARCHAR(10);
    
    SELECT duree_abonnement INTO type_duree
    FROM DUREE
    WHERE id_duree = NEW.id_duree;
    
    IF type_duree = 'mensuel' THEN
        SET NEW.date_fin = DATE_ADD(NEW.date_debut, INTERVAL 1 MONTH);
    ELSEIF type_duree = 'annuel' THEN
        SET NEW.date_fin = DATE_ADD(NEW.date_debut, INTERVAL 1 YEAR);
    END IF;
END//
DELIMITER ;


-- PARTIE 6 : VUES POUR FACILITER LES REQUÊTES

-- Vue : Adhérents avec abonnement actif
CREATE OR REPLACE VIEW v_adherents_actifs AS
SELECT DISTINCT
    ad.id_adherent,
    ad.nom_adherent,
    ad.prenom_adherent,
    ad.email_adherent,
    ad.numero_telephone_adherent,
    t.type_abonnement,
    a.date_debut,
    a.date_fin
FROM ADHERENT ad
INNER JOIN ABONNEMENT a ON ad.id_adherent = a.id_adherent
INNER JOIN TYPE_ABONNEMENT t ON a.id_type_abonnement = t.id_type_abonnement
WHERE CURDATE() BETWEEN a.date_debut AND a.date_fin;

-- Vue : Planning des cours avec détails complets
CREATE OR REPLACE VIEW v_planning_cours AS
SELECT 
    tc.type_cours_collectif,
    cc.horaire_cours,
    CONCAT(c.prenom_coach, ' ', c.nom_coach) AS nom_complet_coach,
    s.salle_cours,
    cc.nombre_max_participants_cours,
    COUNT(r.id_reservation) AS nombre_reservations_actuelles,
    cc.nombre_max_participants_cours - COUNT(r.id_reservation) AS places_disponibles
FROM COURS_COLLECTIF cc
INNER JOIN TYPE_COURS tc ON cc.id_type_cours = tc.id_type_cours
INNER JOIN COACH c ON cc.id_coach = c.id_coach
INNER JOIN SALLE s ON cc.id_salle = s.id_salle
LEFT JOIN RESERVATION r ON cc.id_cours = r.id_cours
GROUP BY cc.id_cours, tc.type_cours_collectif, cc.horaire_cours, 
         c.prenom_coach, c.nom_coach, s.salle_cours, cc.nombre_max_participants_cours
ORDER BY cc.horaire_cours;

-- Vue : Statistiques des adhérents
CREATE OR REPLACE VIEW v_stats_adherents AS
SELECT 
    ad.id_adherent,
    CONCAT(ad.prenom_adherent, ' ', ad.nom_adherent) AS nom_complet,
    COUNT(DISTINCT p.id_presence) AS nombre_visites,
    COUNT(DISTINCT r.id_reservation) AS nombre_reservations,
    COUNT(DISTINCT sc.id_session) AS nombre_sessions_coaching,
    COALESCE(SUM(ac.quantite_vendue * pr.prix_produit), 0) AS ca_produits
FROM ADHERENT ad
LEFT JOIN PRESENCE p ON ad.id_adherent = p.id_adherent
LEFT JOIN RESERVATION r ON ad.id_adherent = r.id_adherent
LEFT JOIN SESSION_COACHING sc ON ad.id_adherent = sc.id_adherent
LEFT JOIN ACHAT ac ON ad.id_adherent = ac.id_adherent
LEFT JOIN PRODUIT pr ON ac.id_produit = pr.id_produit
GROUP BY ad.id_adherent, ad.prenom_adherent, ad.nom_adherent;

