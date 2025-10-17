
-- Script d'insertion de données


-- Insertion dans ADHERENT (15 adhérents)

INSERT INTO ADHERENT (nom_adherent, prenom_adherent, adresse_adherent, email_adherent, numero_telephone_adherent, date_naissance_adherent, genre_adherent) VALUES
('Martin', 'Sophie', '12 rue de la Paix, Paris', 'sophie.martin@email.fr', '0612345678', '1995-03-15', 'Femme'),
('Dubois', 'Thomas', '25 avenue Victor Hugo, Lyon', 'thomas.dubois@email.fr', '0623456789', '1988-07-22', 'Homme'),
('Bernard', 'Emma', '8 boulevard Saint-Michel, Marseille', 'emma.bernard@email.fr', '0634567890', '2000-11-30', 'Femme'),
('Petit', 'Lucas', '45 rue du Commerce, Toulouse', 'lucas.petit@email.fr', '0645678901', '1992-05-18', 'Homme'),
('Robert', 'Chloé', '3 place de la République, Nice', 'chloe.robert@email.fr', '0656789012', '1998-09-25', 'Femme'),
('Richard', 'Antoine', '17 rue Gambetta, Nantes', 'antoine.richard@email.fr', '0667890123', '1985-12-10', 'Homme'),
('Durand', 'Léa', '33 avenue des Champs, Bordeaux', 'lea.durand@email.fr', '0678901234', '2001-02-14', 'Femme'),
('Moreau', 'Hugo', '9 rue de Rivoli, Strasbourg', 'hugo.moreau@email.fr', '0689012345', '1990-08-07', 'Homme'),
('Simon', 'Julie', '21 boulevard Haussmann, Lille', 'julie.simon@email.fr', '0690123456', '1996-04-20', 'Femme'),
('Laurent', 'Maxime', '14 rue Lafayette, Rennes', 'maxime.laurent@email.fr', '0601234567', '1987-06-12', 'Homme'),
('Lefebvre', 'Clara', '6 avenue Foch, Montpellier', 'clara.lefebvre@email.fr', '0612345670', '2002-01-05', 'Femme'),
('Michel', 'Nathan', '28 rue Nationale, Grenoble', 'nathan.michel@email.fr', '0623456780', '1993-10-28', 'Homme'),
('Garcia', 'Inès', '11 place Bellecour, Dijon', 'ines.garcia@email.fr', '0634567891', '1999-03-17', 'Femme'),
('Martinez', 'Dylan', '40 rue de la Liberté, Angers', 'dylan.martinez@email.fr', '0645678902', '1991-07-09', 'Homme'),
('Rodriguez', 'Camille', '5 boulevard de la Marne, Toulon', 'camille.rodriguez@email.fr', '0656789013', '2003-12-22', 'Autre');

-- Insertion dans CERTIFICAT_MEDICAL (15 certificats)

INSERT INTO CERTIFICAT_MEDICAL (date_emission_certificat, date_expiration_certificat, id_adherent) VALUES
('2024-01-15', '2025-01-15', 1),
('2024-02-20', '2025-02-20', 2),
('2024-03-10', '2025-03-10', 3),
('2024-01-05', '2025-01-05', 4),
('2024-04-12', '2025-04-12', 5),
('2024-02-28', '2025-02-28', 6),
('2024-05-18', '2025-05-18', 7),
('2024-03-25', '2025-03-25', 8),
('2024-06-08', '2025-06-08', 9),
('2024-04-15', '2025-04-15', 10),
('2024-07-01', '2025-07-01', 11),
('2024-05-20', '2025-05-20', 12),
('2024-08-10', '2025-08-10', 13),
('2024-06-30', '2025-06-30', 14),
('2024-09-15', '2025-09-15', 15);

-- Insertion dans BADGE (15 badges)

INSERT INTO BADGE (numero_badge_acces, id_adherent) VALUES
('BADGE-0001', 1),
('BADGE-0002', 2),
('BADGE-0003', 3),
('BADGE-0004', 4),
('BADGE-0005', 5),
('BADGE-0006', 6),
('BADGE-0007', 7),
('BADGE-0008', 8),
('BADGE-0009', 9),
('BADGE-0010', 10),
('BADGE-0011', 11),
('BADGE-0012', 12),
('BADGE-0013', 13),
('BADGE-0014', 14),
('BADGE-0015', 15);

-- Insertion dans TYPE_ABONNEMENT (3 types)

INSERT INTO TYPE_ABONNEMENT (type_abonnement, options_additionnelles, prix_abonnement) VALUES
('standard', NULL, 39.90),
('premium', 'coaching, nutrition', 79.90),
('étudiant', NULL, 29.90);

-- Insertion dans DUREE (2 durées)

INSERT INTO DUREE (duree_abonnement) VALUES
('mensuel'),
('annuel');


-- Insertion dans ABONNEMENT (20 abonnements)

INSERT INTO ABONNEMENT (date_debut, date_fin, id_adherent, id_type_abonnement, id_duree) VALUES
('2024-01-15', '2025-01-15', 1, 2, 2),
('2024-02-20', '2024-03-20', 2, 1, 1),
('2024-03-10', '2025-03-10', 3, 3, 2),
('2024-01-05', '2024-02-05', 4, 1, 1),
('2024-04-12', '2025-04-12', 5, 2, 2),
('2024-02-28', '2024-03-28', 6, 1, 1),
('2024-05-18', '2024-06-18', 7, 3, 1),
('2024-03-25', '2025-03-25', 8, 1, 2),
('2024-06-08', '2024-07-08', 9, 2, 1),
('2024-04-15', '2025-04-15', 10, 2, 2),
('2024-07-01', '2024-08-01', 11, 3, 1),
('2024-05-20', '2024-06-20', 12, 1, 1),
('2024-08-10', '2025-08-10', 13, 2, 2),
('2024-06-30', '2024-07-30', 14, 1, 1),
('2024-09-15', '2024-10-15', 15, 3, 1),
('2024-03-20', '2024-04-20', 2, 2, 1),
('2024-02-05', '2025-02-05', 4, 2, 2),
('2024-03-28', '2025-03-28', 6, 2, 2),
('2024-06-18', '2025-06-18', 7, 2, 2),
('2024-07-08', '2024-08-08', 9, 1, 1);


-- Insertion dans PRESENCE (30 présences)

INSERT INTO PRESENCE (date_entree_salle, date_sortie_salle, id_adherent) VALUES
('2024-09-01 08:30:00', '2024-09-01 10:15:00', 1),
('2024-09-01 18:00:00', '2024-09-01 19:30:00', 2),
('2024-09-02 07:00:00', '2024-09-02 08:45:00', 3),
('2024-09-02 12:00:00', '2024-09-02 13:20:00', 4),
('2024-09-02 17:30:00', '2024-09-02 19:00:00', 5),
('2024-09-03 09:00:00', '2024-09-03 10:30:00', 1),
('2024-09-03 19:00:00', '2024-09-03 20:45:00', 6),
('2024-09-04 06:30:00', '2024-09-04 08:00:00', 7),
('2024-09-04 18:30:00', '2024-09-04 20:00:00', 8),
('2024-09-05 10:00:00', '2024-09-05 11:30:00', 9),
('2024-09-05 16:00:00', '2024-09-05 17:45:00', 10),
('2024-09-06 08:00:00', '2024-09-06 09:30:00', 2),
('2024-09-06 13:00:00', '2024-09-06 14:20:00', 11),
('2024-09-07 07:30:00', '2024-09-07 09:00:00', 12),
('2024-09-07 18:00:00', '2024-09-07 19:30:00', 3),
('2024-09-08 11:00:00', '2024-09-08 12:30:00', 13),
('2024-09-08 17:00:00', '2024-09-08 18:45:00', 14),
('2024-09-09 09:30:00', '2024-09-09 11:00:00', 15),
('2024-09-09 19:30:00', '2024-09-09 21:00:00', 4),
('2024-09-10 06:00:00', '2024-09-10 07:30:00', 5),
('2024-09-10 12:30:00', '2024-09-10 14:00:00', 1),
('2024-09-11 08:30:00', '2024-09-11 10:00:00', 6),
('2024-09-11 18:30:00', '2024-09-11 20:00:00', 7),
('2024-09-12 10:30:00', '2024-09-12 12:00:00', 8),
('2024-09-12 16:30:00', '2024-09-12 18:00:00', 9),
('2024-09-13 07:00:00', '2024-09-13 08:30:00', 10),
('2024-09-13 19:00:00', '2024-09-13 20:30:00', 11),
('2024-09-14 11:30:00', '2024-09-14 13:00:00', 12),
('2024-09-14 17:30:00', '2024-09-14 19:00:00', 13),
('2024-09-15 08:00:00', '2024-09-15 09:45:00', 14);


-- Insertion dans TYPE_COURS (6 types)

INSERT INTO TYPE_COURS (type_cours_collectif) VALUES
('yoga'),
('pilates'),
('cycling'),
('HIIT'),
('crossfit'),
('zumba');

-- Insertion dans SALLE (3 salles)

INSERT INTO SALLE (salle_cours) VALUES
('Salle A'),
('Salle B'),
('Salle C');


-- Insertion dans SPECIALITE (6 spécialités)

INSERT INTO SPECIALITE (specialite_coach) VALUES
('yoga'),
('musculation'),
('cardio'),
('nutrition'),
('HIIT'),
('pilates');


-- Insertion dans COACH (5 coachs)

INSERT INTO COACH (nom_coach, prenom_coach, disponibilite_hebdomadaire_coach) VALUES
('Fernandez', 'Marc', 'Lundi-Vendredi: 8h-18h'),
('Lopez', 'Sarah', 'Mardi-Samedi: 10h-20h'),
('Gonzalez', 'Pierre', 'Lundi-Mercredi-Vendredi: 7h-15h'),
('Blanc', 'Marie', 'Lundi-Jeudi: 14h-22h'),
('Rousseau', 'Kevin', 'Mardi-Jeudi-Samedi: 9h-17h');


-- Insertion dans SPECIALITE_COACH (8 relations)

INSERT INTO SPECIALITE_COACH (id_coach, id_specialite) VALUES
(1, 1),
(1, 6),
(2, 3),
(2, 5),
(3, 2),
(4, 4),
(4, 1),
(5, 5);


-- Insertion dans COURS_COLLECTIF (10 cours)

INSERT INTO COURS_COLLECTIF (horaire_cours, nombre_max_participants_cours, id_type_cours, id_coach, id_salle) VALUES
('08:00:00', 20, 1, 1, 1),
('09:30:00', 15, 2, 1, 2),
('18:00:00', 25, 3, 2, 3),
('19:00:00', 20, 4, 2, 1),
('07:00:00', 15, 5, 3, 2),
('12:00:00', 30, 6, 4, 3),
('17:30:00', 20, 1, 4, 1),
('10:00:00', 18, 4, 5, 2),
('20:00:00', 25, 3, 2, 3),
('14:00:00', 20, 2, 1, 1);


-- Insertion dans RESERVATION (25 réservations)

INSERT INTO RESERVATION (date_reservation, id_adherent, id_cours) VALUES
('2024-08-28', 1, 1),
('2024-08-29', 2, 3),
('2024-08-29', 3, 2),
('2024-08-30', 4, 4),
('2024-08-30', 5, 5),
('2024-08-31', 6, 6),
('2024-09-01', 7, 1),
('2024-09-01', 8, 7),
('2024-09-02', 9, 8),
('2024-09-02', 10, 3),
('2024-09-03', 11, 9),
('2024-09-03', 1, 4),
('2024-09-04', 2, 10),
('2024-09-04', 12, 1),
('2024-09-05', 13, 2),
('2024-09-05', 14, 5),
('2024-09-06', 15, 6),
('2024-09-06', 3, 7),
('2024-09-07', 4, 8),
('2024-09-07', 5, 3),
('2024-09-08', 6, 4),
('2024-09-08', 7, 9),
('2024-09-09', 8, 1),
('2024-09-09', 9, 2),
('2024-09-10', 10, 10);


-- Insertion dans SESSION_COACHING (10 sessions)

INSERT INTO SESSION_COACHING (date_session_coaching, duree_session_coaching, id_adherent, id_coach) VALUES
('2024-09-02', 60, 1, 1),
('2024-09-03', 90, 5, 2),
('2024-09-05', 45, 10, 3),
('2024-09-06', 60, 13, 4),
('2024-09-08', 120, 2, 5),
('2024-09-10', 60, 8, 1),
('2024-09-11', 90, 3, 2),
('2024-09-12', 60, 6, 4),
('2024-09-13', 75, 9, 5),
('2024-09-14', 60, 12, 3);


-- Insertion dans SUIVI_NUTRITIONNEL (5 suivis)

INSERT INTO SUIVI_NUTRITIONNEL (objectifs_nutritionnels_adherent, id_adherent) VALUES
('Perte de poids: 5kg, Augmentation apport protéique', 1),
('Prise de masse musculaire, Régime hyperprotéiné', 5),
('Rééquilibrage alimentaire, Réduction des sucres', 10),
('Maintien du poids, Alimentation équilibrée pour sportif', 13),
('Préparation compétition, Optimisation nutrition sportive', 2);


-- Insertion dans PRODUIT (8 produits)

INSERT INTO PRODUIT (nom_produit_vendu, prix_produit) VALUES
('Whey Protéine 1kg', 29.99),
('Créatine 500g', 19.99),
('BCAA 200 gélules', 24.99),
('Barre protéinée (boîte de 12)', 15.99),
('T-shirt salle de sport', 19.90),
('Bouteille shaker 700ml', 9.90),
('Serviette microfibre', 12.90),
('Gants musculation', 14.90);


-- Insertion dans ACHAT (15 achats)

INSERT INTO ACHAT (quantite_vendue, date_achat, id_adherent, id_produit) VALUES
(1, '2024-09-01', 1, 1),
(2, '2024-09-02', 2, 3),
(1, '2024-09-03', 5, 2),
(1, '2024-09-04', 10, 5),
(3, '2024-09-05', 13, 4),
(1, '2024-09-06', 3, 6),
(1, '2024-09-07', 8, 7),
(2, '2024-09-08', 6, 8),
(1, '2024-09-09', 1, 2),
(1, '2024-09-10', 9, 5),
(1, '2024-09-11', 12, 1),
(2, '2024-09-12', 7, 4),
(1, '2024-09-13', 14, 6),
(1, '2024-09-14', 4, 3),
(1, '2024-09-15', 11, 7);