
-- Script de création de la base de données

CREATE database salle_de_sport;
use salle_de_sport;

-- Suppression des tables si elles existent déjà
DROP TABLE IF EXISTS ACHAT;
DROP TABLE IF EXISTS PRODUIT;
DROP TABLE IF EXISTS SUIVI_NUTRITIONNEL;
DROP TABLE IF EXISTS SESSION_COACHING;
DROP TABLE IF EXISTS RESERVATION;
DROP TABLE IF EXISTS COURS_COLLECTIF;
DROP TABLE IF EXISTS SPECIALITE_COACH;
DROP TABLE IF EXISTS COACH;
DROP TABLE IF EXISTS SPECIALITE;
DROP TABLE IF EXISTS SALLE;
DROP TABLE IF EXISTS TYPE_COURS;
DROP TABLE IF EXISTS PRESENCE;
DROP TABLE IF EXISTS ABONNEMENT;
DROP TABLE IF EXISTS DUREE;
DROP TABLE IF EXISTS TYPE_ABONNEMENT;
DROP TABLE IF EXISTS BADGE;
DROP TABLE IF EXISTS CERTIFICAT_MEDICAL;
DROP TABLE IF EXISTS ADHERENT;


-- Table ADHERENT

CREATE TABLE ADHERENT (
    id_adherent INT AUTO_INCREMENT,
    nom_adherent VARCHAR(50) NOT NULL,
    prenom_adherent VARCHAR(50) NOT NULL,
    adresse_adherent VARCHAR(100) NOT NULL,
    email_adherent VARCHAR(100) NOT NULL,
    numero_telephone_adherent VARCHAR(15) NOT NULL,
    date_naissance_adherent DATE NOT NULL,
    genre_adherent VARCHAR(10) NOT NULL,
    PRIMARY KEY (id_adherent)
);


-- Table CERTIFICAT_MEDICAL

CREATE TABLE CERTIFICAT_MEDICAL (
    id_certificat INT AUTO_INCREMENT,
    date_emission_certificat DATE NOT NULL,
    date_expiration_certificat DATE NOT NULL,
    id_adherent INT NOT NULL,
    PRIMARY KEY (id_certificat)
);


-- Table BADGE

CREATE TABLE BADGE (
    id_badge INT AUTO_INCREMENT,
    numero_badge_acces VARCHAR(20) NOT NULL,
    id_adherent INT NOT NULL,
    PRIMARY KEY (id_badge)
);


-- Table TYPE_ABONNEMENT

CREATE TABLE TYPE_ABONNEMENT (
    id_type_abonnement INT AUTO_INCREMENT,
    type_abonnement VARCHAR(20) NOT NULL,
    options_additionnelles VARCHAR(50),
    prix_abonnement DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_type_abonnement)
);


-- Table DUREE

CREATE TABLE DUREE (
    id_duree INT AUTO_INCREMENT,
    duree_abonnement VARCHAR(10) NOT NULL,
    PRIMARY KEY (id_duree)
);


-- Table ABONNEMENT

CREATE TABLE ABONNEMENT (
    id_abonnement INT AUTO_INCREMENT,
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
    id_adherent INT NOT NULL,
    id_type_abonnement INT NOT NULL,
    id_duree INT NOT NULL,
    PRIMARY KEY (id_abonnement)
);


-- Table PRESENCE

CREATE TABLE PRESENCE (
    id_presence INT AUTO_INCREMENT,
    date_entree_salle DATETIME NOT NULL,
    date_sortie_salle DATETIME,
    id_adherent INT NOT NULL,
    PRIMARY KEY (id_presence)
);


-- Table TYPE_COURS

CREATE TABLE TYPE_COURS (
    id_type_cours INT AUTO_INCREMENT,
    type_cours_collectif VARCHAR(30) NOT NULL,
    PRIMARY KEY (id_type_cours)
);


-- Table SALLE

CREATE TABLE SALLE (
    id_salle INT AUTO_INCREMENT,
    salle_cours VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_salle)
);


-- Table SPECIALITE

CREATE TABLE SPECIALITE (
    id_specialite INT AUTO_INCREMENT,
    specialite_coach VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_specialite)
);


-- Table COACH

CREATE TABLE COACH (
    id_coach INT AUTO_INCREMENT,
    nom_coach VARCHAR(50) NOT NULL,
    prenom_coach VARCHAR(50) NOT NULL,
    disponibilite_hebdomadaire_coach VARCHAR(100),
    PRIMARY KEY (id_coach)
);


-- Table SPECIALITE_COACH

CREATE TABLE SPECIALITE_COACH (
    id_specialite_coach INT AUTO_INCREMENT,
    id_coach INT NOT NULL,
    id_specialite INT NOT NULL,
    PRIMARY KEY (id_specialite_coach)
);


-- Table COURS_COLLECTIF

CREATE TABLE COURS_COLLECTIF (
    id_cours INT AUTO_INCREMENT,
    horaire_cours TIME NOT NULL,
    nombre_max_participants_cours INT NOT NULL,
    id_type_cours INT NOT NULL,
    id_coach INT NOT NULL,
    id_salle INT NOT NULL,
    PRIMARY KEY (id_cours)
);

-- Table RESERVATION

CREATE TABLE RESERVATION (
    id_reservation INT AUTO_INCREMENT,
    date_reservation DATE NOT NULL,
    id_adherent INT NOT NULL,
    id_cours INT NOT NULL,
    PRIMARY KEY (id_reservation)
);

-- Table SESSION_COACHING

CREATE TABLE SESSION_COACHING (
    id_session INT AUTO_INCREMENT,
    date_session_coaching DATE NOT NULL,
    duree_session_coaching INT NOT NULL,
    id_adherent INT NOT NULL,
    id_coach INT NOT NULL,
    PRIMARY KEY (id_session)
);

-- Table SUIVI_NUTRITIONNEL

CREATE TABLE SUIVI_NUTRITIONNEL (
    id_suivi INT AUTO_INCREMENT,
    objectifs_nutritionnels_adherent VARCHAR(200),
    id_adherent INT NOT NULL,
    PRIMARY KEY (id_suivi)
);

-- Table PRODUIT
CREATE TABLE PRODUIT (
    id_produit INT AUTO_INCREMENT,
    nom_produit_vendu VARCHAR(50) NOT NULL,
    prix_produit DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_produit)
);

-- Table ACHAT

CREATE TABLE ACHAT (
    id_achat INT AUTO_INCREMENT,
    quantite_vendue INT NOT NULL,
    date_achat DATE NOT NULL,
    id_adherent INT NOT NULL,
    id_produit INT NOT NULL,
    PRIMARY KEY (id_achat)
);
