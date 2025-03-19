# Modélisation Spatiale avec DBT et DuckDB

{{ doc('__overview__') }}

## Architecture du Projet

```
modelisation_dbt/
├── models/
│   ├── staging/           # Données brutes
│   │   ├── geo/           # Données administratives INSEE
│   │   └── spatial/       # Données géométriques
│   ├── intermediate/      # Tables dimensionnelles et de faits
│   └── export/            # Export en format Parquet
├── snapshots/             # Snapshots pour le suivi historique
├── macros/                # Macros réutilisables
└── data/                  # Données locales et exports
    └── spatial/           # Fichiers Shapefile
```

## Modèle de Données

{{ doc('__dimension_tables__') }}

{{ doc('__fact_tables__') }}

## Sources de Données

{{ doc('__spatial_data__') }}

{{ doc('__population_data__') }}

## Export et Utilisation

{{ doc('__export_pattern__') }}

## Gestion des Changements

{{ doc('__snapshots__') }}

## Exécution du Projet

Pour exécuter ce projet :

1. Configurer le profil dans `profiles.yml` avec les paramètres DuckDB appropriés
2. Installer les dépendances : `dbt deps`
3. Exécuter les modèles : `dbt run`
4. Exécuter les tests : `dbt test`
5. Générer la documentation : `dbt docs generate`
6. Servir la documentation localement : `dbt docs serve`
7. Exécuter les snapshots : `dbt snapshot`