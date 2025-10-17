
-- Script d'interrogation de la base de données


/*
SCÉNARIO D'UTILISATION:
Le directeur de la salle de sport souhaite analyser l'activité de son établissement
pour prendre des décisions stratégiques concernant:
- La gestion des adhérents et la fidélisation
- L'optimisation des cours collectifs
- La performance des coachs
- Les ventes de produits
- La rentabilité des différents types d'abonnements
*/

-- PARTIE 1: PROJECTIONS ET SÉLECTIONS (5 requêtes)


-- Requête 1: Liste des adhérents femmes âgées de plus de 25 ans, triée par nom
-- Données recherchées: Identifier les adhérentes dans une tranche d'âge spécifique pour une campagne marketing ciblée
SELECT nom_adherent, prenom_adherent, email_adherent, 
       TIMESTAMPDIFF(YEAR, date_naissance_adherent, CURDATE()) AS age
FROM ADHERENT
WHERE genre_adherent = 'Femme' 
  AND TIMESTAMPDIFF(YEAR, date_naissance_adherent, CURDATE()) > 25
ORDER BY nom_adherent, prenom_adherent;

-- Requête 2: Liste des abonnements premium ou étudiant actifs en ce moment (BETWEEN, IN)
-- Données recherchées: Connaître les adhérents qui ont accès aux services premium ou bénéficient de réductions étudiantes
SELECT a.id_abonnement, ad.nom_adherent, ad.prenom_adherent, 
       t.type_abonnement, a.date_debut, a.date_fin
FROM ABONNEMENT a
JOIN ADHERENT ad ON a.id_adherent = ad.id_adherent
JOIN TYPE_ABONNEMENT t ON a.id_type_abonnement = t.id_type_abonnement
WHERE t.type_abonnement IN ('premium', 'étudiant')
  AND CURDATE() BETWEEN a.date_debut AND a.date_fin
ORDER BY a.date_fin;

-- Requête 3: Recherche des coachs dont le prénom commence par 'M' ou 'S' (masques LIKE)
-- Données recherchées: Filtrer les coachs selon un critère de prénom pour une communication interne
SELECT DISTINCT nom_coach, prenom_coach, disponibilite_hebdomadaire_coach
FROM COACH
WHERE prenom_coach LIKE 'M%' OR prenom_coach LIKE 'S%'
ORDER BY prenom_coach;

-- Requête 4: Liste unique des types de cours proposés avec leur nombre maximum de participants
-- Données recherchées: Vue d'ensemble de l'offre de cours pour planification
SELECT DISTINCT tc.type_cours_collectif, 
       MAX(cc.nombre_max_participants_cours) AS capacite_max
FROM TYPE_COURS tc
JOIN COURS_COLLECTIF cc ON tc.id_type_cours = cc.id_type_cours
GROUP BY tc.type_cours_collectif
ORDER BY capacite_max DESC;

-- Requête 5: Produits dont le prix est entre 10€ et 20€ (BETWEEN)
-- Données recherchées: Identifier les produits dans une gamme de prix moyenne pour promotions
SELECT nom_produit_vendu, prix_produit
FROM PRODUIT
WHERE prix_produit BETWEEN 10.00 AND 20.00
ORDER BY prix_produit;


-- PARTIE 2: FONCTIONS D'AGRÉGATION (5 requêtes)


-- Requête 6: Nombre d'adhérents par genre
-- Données recherchées: Statistiques démographiques pour adapter l'offre de cours
SELECT genre_adherent, COUNT(*) AS nombre_adherents
FROM ADHERENT
GROUP BY genre_adherent
ORDER BY nombre_adherents DESC;

-- Requête 7: Chiffre d'affaires total par type d'abonnement
-- Données recherchées: Analyser la rentabilité de chaque formule d'abonnement
SELECT t.type_abonnement, 
       COUNT(a.id_abonnement) AS nombre_abonnements,
       SUM(t.prix_abonnement) AS ca_total,
       AVG(t.prix_abonnement) AS prix_moyen
FROM ABONNEMENT a
JOIN TYPE_ABONNEMENT t ON a.id_type_abonnement = t.id_type_abonnement
GROUP BY t.type_abonnement, t.prix_abonnement
ORDER BY ca_total DESC;

-- Requête 8: Nombre de réservations par cours, afficher seulement les cours avec plus de 2 réservations (HAVING)
-- Données recherchées: Identifier les cours les plus populaires pour optimiser la planification
SELECT cc.id_cours, tc.type_cours_collectif, cc.horaire_cours,
       COUNT(r.id_reservation) AS nombre_reservations
FROM COURS_COLLECTIF cc
JOIN TYPE_COURS tc ON cc.id_type_cours = tc.id_type_cours
LEFT JOIN RESERVATION r ON cc.id_cours = r.id_cours
GROUP BY cc.id_cours, tc.type_cours_collectif, cc.horaire_cours
HAVING COUNT(r.id_reservation) > 2
ORDER BY nombre_reservations DESC;

-- Requête 9: Chiffre d'affaires des ventes de produits par adhérent (avec HAVING pour CA > 20€)
-- Données recherchées: Identifier les meilleurs clients en termes d'achats de produits
SELECT ad.id_adherent, ad.nom_adherent, ad.prenom_adherent,
       COUNT(ac.id_achat) AS nombre_achats,
       SUM(ac.quantite_vendue * p.prix_produit) AS ca_total
FROM ADHERENT ad
JOIN ACHAT ac ON ad.id_adherent = ac.id_adherent
JOIN PRODUIT p ON ac.id_produit = p.id_produit
GROUP BY ad.id_adherent, ad.nom_adherent, ad.prenom_adherent
HAVING SUM(ac.quantite_vendue * p.prix_produit) > 20
ORDER BY ca_total DESC;

-- Requête 10: Durée moyenne de présence par adhérent en heures
-- Données recherchées: Analyser le temps moyen passé à la salle pour évaluer l'engagement
SELECT ad.id_adherent, ad.nom_adherent, ad.prenom_adherent,
       COUNT(p.id_presence) AS nombre_visites,
       AVG(TIMESTAMPDIFF(MINUTE, p.date_entree_salle, p.date_sortie_salle)) AS duree_moyenne_minutes
FROM ADHERENT ad
JOIN PRESENCE p ON ad.id_adherent = p.id_adherent
WHERE p.date_sortie_salle IS NOT NULL
GROUP BY ad.id_adherent, ad.nom_adherent, ad.prenom_adherent
ORDER BY duree_moyenne_minutes DESC;


-- PARTIE 3: JOINTURES (5 requêtes)


-- Requête 11: Jointure interne simple - Liste des adhérents avec leur type d'abonnement actuel
-- Données recherchées: Vue complète des adhérents et de leur formule d'abonnement
SELECT ad.nom_adherent, ad.prenom_adherent, ad.email_adherent,
       t.type_abonnement, a.date_debut, a.date_fin
FROM ADHERENT ad
INNER JOIN ABONNEMENT a ON ad.id_adherent = a.id_adherent
INNER JOIN TYPE_ABONNEMENT t ON a.id_type_abonnement = t.id_type_abonnement
WHERE CURDATE() BETWEEN a.date_debut AND a.date_fin;

-- Requête 12: Jointure multiple - Détails complets des cours avec coach, type et salle
-- Données recherchées: Planning complet des cours pour communication aux adhérents
SELECT tc.type_cours_collectif, cc.horaire_cours,
       c.nom_coach, c.prenom_coach,
       s.salle_cours, cc.nombre_max_participants_cours
FROM COURS_COLLECTIF cc
INNER JOIN TYPE_COURS tc ON cc.id_type_cours = tc.id_type_cours
INNER JOIN COACH c ON cc.id_coach = c.id_coach
INNER JOIN SALLE s ON cc.id_salle = s.id_salle
ORDER BY cc.horaire_cours;

-- Requête 13: Jointure externe (LEFT JOIN) - Tous les adhérents et leurs sessions de coaching (y compris ceux qui n'en ont pas)
-- Données recherchées: Identifier les adhérents qui n'ont jamais pris de coaching personnalisé
SELECT ad.nom_adherent, ad.prenom_adherent,
       COUNT(sc.id_session) AS nombre_sessions_coaching
FROM ADHERENT ad
LEFT JOIN SESSION_COACHING sc ON ad.id_adherent = sc.id_adherent
GROUP BY ad.id_adherent, ad.nom_adherent, ad.prenom_adherent
ORDER BY nombre_sessions_coaching DESC;

-- Requête 14: Jointure multiple complexe - Réservations avec détails adhérent, cours, coach
-- Données recherchées: Liste complète des réservations pour gestion quotidienne
SELECT r.date_reservation, ad.nom_adherent, ad.prenom_adherent,
       tc.type_cours_collectif, cc.horaire_cours,
       c.nom_coach, c.prenom_coach
FROM RESERVATION r
INNER JOIN ADHERENT ad ON r.id_adherent = ad.id_adherent
INNER JOIN COURS_COLLECTIF cc ON r.id_cours = cc.id_cours
INNER JOIN TYPE_COURS tc ON cc.id_type_cours = tc.id_type_cours
INNER JOIN COACH c ON cc.id_coach = c.id_coach
WHERE r.date_reservation >= '2024-09-01'
ORDER BY r.date_reservation, cc.horaire_cours;

-- Requête 15: Jointure avec agrégation - Coachs et leur nombre de spécialités
-- Données recherchées: Évaluer la polyvalence des coachs
SELECT c.nom_coach, c.prenom_coach,
       COUNT(sc.id_specialite) AS nombre_specialites,
       GROUP_CONCAT(s.specialite_coach SEPARATOR ', ') AS liste_specialites
FROM COACH c
LEFT JOIN SPECIALITE_COACH sc ON c.id_coach = sc.id_coach
LEFT JOIN SPECIALITE s ON sc.id_specialite = s.id_specialite
GROUP BY c.id_coach, c.nom_coach, c.prenom_coach
ORDER BY nombre_specialites DESC;


-- PARTIE 4: REQUÊTES IMBRIQUÉES (5 requêtes)


-- Requête 16: Adhérents qui ont réservé au moins un cours de yoga (sous-requête avec IN)
-- Données recherchées: Cibler les pratiquants de yoga pour des offres spécifiques
SELECT ad.nom_adherent, ad.prenom_adherent, ad.email_adherent
FROM ADHERENT ad
WHERE ad.id_adherent IN (
    SELECT DISTINCT r.id_adherent
    FROM RESERVATION r
    INNER JOIN COURS_COLLECTIF cc ON r.id_cours = cc.id_cours
    INNER JOIN TYPE_COURS tc ON cc.id_type_cours = tc.id_type_cours
    WHERE tc.type_cours_collectif = 'yoga'
);

-- Requête 17: Adhérents qui n'ont jamais acheté de produits (NOT IN)
-- Données recherchées: Identifier les adhérents à cibler pour promouvoir la boutique
SELECT ad.nom_adherent, ad.prenom_adherent, ad.email_adherent
FROM ADHERENT ad
WHERE ad.id_adherent NOT IN (
    SELECT DISTINCT id_adherent
    FROM ACHAT
);

-- Requête 18: Coachs qui animent des cours avec plus de 20 participants maximum (ANY)
-- Données recherchées: Identifier les coachs capables de gérer de grands groupes
SELECT c.nom_coach, c.prenom_coach
FROM COACH c
WHERE c.id_coach = ANY (
    SELECT cc.id_coach
    FROM COURS_COLLECTIF cc
    WHERE cc.nombre_max_participants_cours > 20
);

-- Requête 19: Trouver les adhérents qui ont un abonnement premium (EXISTS)
-- Données recherchées: Liste des adhérents premium pour services VIP
SELECT ad.nom_adherent, ad.prenom_adherent, ad.email_adherent
FROM ADHERENT ad
WHERE EXISTS (
    SELECT 1
    FROM ABONNEMENT a
    INNER JOIN TYPE_ABONNEMENT t ON a.id_type_abonnement = t.id_type_abonnement
    WHERE a.id_adherent = ad.id_adherent
      AND t.type_abonnement = 'premium'
      AND CURDATE() BETWEEN a.date_debut AND a.date_fin
);

-- Requête 20: Produits plus chers que tous les produits de type textile (ALL)
-- Données recherchées: Identifier les produits premium (compléments alimentaires haut de gamme)
SELECT nom_produit_vendu, prix_produit
FROM PRODUIT
WHERE prix_produit > ALL (
    SELECT prix_produit
    FROM PRODUIT
    WHERE nom_produit_vendu LIKE '%shirt%' 
       OR nom_produit_vendu LIKE '%Bouteille%'
       OR nom_produit_vendu LIKE '%Serviette%'
       OR nom_produit_vendu LIKE '%Gants%'
)
ORDER BY prix_produit DESC;