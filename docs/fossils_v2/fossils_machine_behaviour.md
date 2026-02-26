# Fossils machine behaviour (v2)

Analyse de tous les fichiers trouvés sous `data/cobblemon/fossils/*.json` dans le repo et dans les JAR du dossier `mods/`.

## Résultat du scan
- Datapacks repo : **1 fichier trouvé**.
- JAR mods (`mods/*.jar`) : **aucun** `data/**/fossils/*.json` trouvé.

## Détail par fossile mappé

| item_id | fichier_fossil_json | resultat_configuré | remarques |
|---|---|---|---|
| `academy:shiny_fossil` | `datapacks/Academy/data/cobblemon/fossils/shiny_fossil.json` | `random_common shiny=yes` (Pokémon aléatoire de catégorie `common`, shiny forcé) | Shiny explicitement forcé; pas de flag HA, IV max ou radiant dans cette config. |

## Fossiles spéciaux non mappés dans la machine

Les items suivants existent dans le contenu Academy (loot et/ou assets mod) mais n'ont **pas** de fichier `data/cobblemon/fossils/*.json` dans ce repo :
- `academy:ha_fossil`
- `academy:max_iv_fossil`
- `academy:radiant_fossil`

En l'état, leur comportement machine n'est pas défini ici.
