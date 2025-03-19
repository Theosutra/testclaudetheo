{% docs __overview__ %}
# Projet de Modélisation Géographique

Ce projet dbt utilise DuckDB pour créer un modèle de données géographiques pour la France métropolitaine.

## Structure du projet

Le projet est organisé selon l'architecture suivante :
- **Staging** : Tables brutes importées des sources externes
- **Intermediate** : Tables dimensionnelles et de faits transformées
- **Export** : Export des données en format Parquet

## Sources de données
- Données géographiques administratives de l'INSEE
- Données spatiales (shapefiles)
- Données historiques de population

## Objectifs
- Créer un modèle en étoile pour l'analyse géographique
- Permettre l'analyse des données géographiques et démographiques
- Faciliter l'exportation des données pour utilisation dans des outils SIG
{% enddocs %}

{% docs __dimension_tables__ %}
# Tables de Dimension

Les tables de dimension contiennent les entités géographiques principales :
- Régions
- Départements
- Arrondissements
- Communes

Chaque table de dimension comprend :
- Un identifiant unique
- Des codes officiels INSEE
- Des noms d'entités
- Des géométries spatiales (format WKT)
- Des représentations GeoJSON pour la visualisation
{% enddocs %}

{% docs __fact_tables__ %}
# Tables de Faits

## Table fct_geo
Table qui relie toutes les entités géographiques entre elles, permettant des analyses à différents niveaux d'agrégation.

## Table dwh_population
Table qui contient les données historiques de population pour chaque commune, avec des liens vers les dimensions géographiques.
{% enddocs %}

{% docs __spatial_data__ %}
# Données Spatiales

Les données spatiales sont importées depuis des fichiers Shapefile (.shp) et traitées avec l'extension spatiale de DuckDB.

Fonctions spatiales utilisées :
- ST_AsGeoJSON : Pour convertir les géométries en GeoJSON
- ST_Read : Pour lire les fichiers Shapefile

Les géométries sont conservées dans leur format natif pour les analyses spatiales et converties en GeoJSON pour la visualisation web.
{% enddocs %}

{% docs __population_data__ %}
# Données de Population

Les données historiques de population proviennent de l'INSEE et couvrent la période de 2006 à 2022.

Ces données permettent d'analyser l'évolution démographique au niveau communal et peuvent être agrégées aux niveaux supérieurs.
{% enddocs %}

{% docs __export_pattern__ %}
# Export des Données

Les modèles dans le dossier `export` sont configurés pour exporter les données au format Parquet, optimisé pour la lecture par des outils d'analyse comme Python/Pandas, R, ou des systèmes d'information géographique.

Options de configuration :
- Compression : zstd
- Taille des groupes de lignes : 24000
{% enddocs %}

{% docs __snapshots__ %}
# Snapshots

Les snapshots permettent de suivre les changements historiques dans les tables de dimension et de faits.

Stratégie utilisée :
- Basée sur l'horodatage (timestamp)
- Chaque snapshot inclut l'horodatage, l'année et le mois pour faciliter les requêtes

Les snapshots sont stockés dans le schéma 'snapshots' et comprennent :
- Toutes les tables de dimension
- Toutes les tables de faits
{% enddocs %}

{% docs dwh_region %}
# Dimension Région Métropolitaine

Cette table contient toutes les régions de France métropolitaine.

## Colonnes
- **id_region** : Identifiant unique de la région (UUID)
- **code_region** : Code INSEE de la région
- **nom_region** : Nom officiel de la région
- **geom** : Géométrie de la région (format WKT)
- **geojson** : Représentation GeoJSON de la géométrie

## Source
Les données proviennent des fichiers administratifs INSEE et des shapefiles IGN.
{% enddocs %}

{% docs dwh_departement %}
# Dimension Département Métropolitain

Cette table contient tous les départements de France métropolitaine.

## Colonnes
- **id_departement** : Identifiant unique du département (UUID)
- **code_departement** : Code INSEE du département
- **nom_departement** : Nom officiel du département
- **geom** : Géométrie du département (format WKT)
- **geojson** : Représentation GeoJSON de la géométrie

## Source
Les données proviennent des fichiers administratifs INSEE et des shapefiles IGN.
{% enddocs %}

{% docs dwh_arrondissement %}
# Dimension Arrondissement Métropolitain

Cette table contient tous les arrondissements de France métropolitaine.

## Colonnes
- **id_arrondissement** : Identifiant unique de l'arrondissement (UUID)
- **code_arrondissement** : Code INSEE de l'arrondissement
- **nom_arrondissement** : Nom officiel de l'arrondissement
- **geom** : Géométrie de l'arrondissement (format WKT)
- **geojson** : Représentation GeoJSON de la géométrie

## Source
Les données proviennent des fichiers administratifs INSEE et des shapefiles IGN.
{% enddocs %}

{% docs dwh_commune %}
# Dimension Commune Métropolitaine

Cette table contient toutes les communes de France métropolitaine.

## Colonnes
- **id_commune** : Identifiant unique de la commune (UUID)
- **code_commune** : Code INSEE de la commune
- **nom_commune** : Nom officiel de la commune
- **geom** : Géométrie de la commune (format WKT)
- **geojson** : Représentation GeoJSON de la géométrie

## Source
Les données proviennent des fichiers administratifs INSEE et des shapefiles IGN.
{% enddocs %}


{% docs dwh_population %}
# Table de Faits Population

Cette table contient les données historiques de population pour chaque commune.

## Colonnes
- **id_fctpop** : Identifiant unique (UUID)
- **id_commune** : Référence à la dimension commune
- **id_region** : Référence à la dimension région
- **id_departement** : Référence à la dimension département
- **population_XXXX** : Population pour l'année XXXX (de 2006 à 2022)

## Utilisation
Utilisez cette table pour analyser l'évolution démographique des communes françaises et réaliser des agrégations à différents niveaux.
{% enddocs %}