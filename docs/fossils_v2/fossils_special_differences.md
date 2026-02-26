# Différences fossiles spéciaux vs standard (v2)

Référence croisée entre :
- l'index d'items fossiles,
- la config machine (`data/cobblemon/fossils/*.json`),
- les loot tables,
- les assets du mod Academy.

| Type de fossile | Item(s) | Effet shiny ? | HA forcé ? | IV max ? | Effet radiant ? | Catégorie de Pokémon | Notes |
|---|---|---|---|---|---|---|---|
| Standard | `cobblemon:*_fossil`, `cobblemon:fossilized_*` (15 IDs lootables) | non (par défaut) | non (par défaut) | non (par défaut) | non (par défaut) | Selon logique Cobblemon de base (non redéfinie ici) | Aucun override local `data/cobblemon/fossils/` pour ces IDs dans le repo. |
| Shiny | `academy:shiny_fossil` | **oui** (`shiny=yes`) | non observé | non observé | non observé | `random_common` | Comportement explicitement défini dans `shiny_fossil.json`. |
| HA | `academy:ha_fossil` | inconnu | **attendu oui**, non prouvé | inconnu | non observé | inconnu | Item distribué en loot, mais aucun mapping `data/cobblemon/fossils/*.json` trouvé, donc pas d'effet HA visible côté datapack. |
| Max IV | `academy:max_iv_fossil` | inconnu | inconnu | **attendu oui**, non prouvé | non observé | inconnu | Item distribué en loot, mais aucun mapping machine trouvé dans le repo. |
| Radiant | `academy:radiant_fossil` | inconnu | inconnu | inconnu | **attendu oui**, non prouvé | inconnu | Item présent dans les assets du mod Academy, mais non vu en loot/trade et sans mapping machine local. |

## Point clé
Si un fossile spécial n'a pas de fichier `data/cobblemon/fossils/<...>.json`, son comportement spécifique (HA, IV max, radiant) n'est pas câblé dans la couche datapack analysée ici.
