# Diagnostic — fossiles Radiant Cobblemon

## Portée vérifiée
- Recherche globale dans `config/`, `datapacks/`, `data/`, `resourcepacks/` sur `fossil`, `radiant`, `cobblemon:fossil`, `radiant_fossil`, `shiny_fossil`.
- Vérification des tags d'items (`data/**/tags/item*/*.json`) et des fichiers Cobblemon liés aux fossiles/machine.
- Vérification des loot tables/trades présents dans le repo.

## Résultats clés

### 1) IDs fossiles identifiés dans ce repo
- Fossiles standards Cobblemon (loot pool) :
  - `cobblemon:sail_fossil`, `cobblemon:fossilized_bird`, `cobblemon:dome_fossil`, `cobblemon:claw_fossil`, `cobblemon:fossilized_drake`, `cobblemon:plume_fossil`, `cobblemon:root_fossil`, `cobblemon:jaw_fossil`, `cobblemon:fossilized_fish`, `cobblemon:old_amber_fossil`, `cobblemon:skull_fossil`, `cobblemon:cover_fossil`, `cobblemon:armor_fossil`, `cobblemon:helix_fossil`, `cobblemon:fossilized_dino`.
- Fossile custom shiny :
  - `academy:shiny_fossil` (défini dans `data/cobblemon/fossils/shiny_fossil.json` avec résultat `random_common shiny=yes`).
- Fossiles custom aussi lootés :
  - `academy:ha_fossil`, `academy:max_iv_fossil`.
- **Aucun ID de type `*radiant*fossil*` trouvé** dans les datapacks/configs.

### 2) Tags items / compat machine
- Aucun tag d'item fossile custom n'est défini dans les datapacks du repo pour inclure des fossiles radiant.
- Le seul mapping fossile custom côté Cobblemon trouvé est `data/cobblemon/fossils/shiny_fossil.json` (shiny uniquement).
- Aucun fichier `data/cobblemon/fossils/*radiant*.json` trouvé.

### 3) Machine à fossiles / logique de résurrection
- Références machine trouvées (`restoration_tank`, `fossil_analyzer`) dans des fichiers de spawn pool et d'advancements, mais **pas de logique custom radiant** (pas de recipe/script/whitelist radiant dans le repo).
- La config Cobblemon (`config/cobblemon/main.json`) contient `maxInsertedFossilItems`, mais aucune option `radiant`/`radiant fossil`.

### 4) Loot/trades
- Les loot tables donnent bien des fossiles standard Cobblemon et des fossiles custom (shiny/ha/max_iv).
- Aucune entrée loot/trade radiant fossil n'a été trouvée dans les datapacks du repo.

## Tableau synthèse (Radiant)
| Point vérifié | Résultat |
|---|---|
| Radiant fossil ID présent dans le repo | NON |
| Radiant fossil présent dans des tags items | NON |
| Radiant fossil présent dans `data/cobblemon/fossils/` (compat machine custom) | NON |
| IDs radiant cohérents loot/trade ↔ machine | NON VÉRIFIABLE (aucun ID radiant trouvé) |
| Option config désactivant explicitement radiant fossils | NON TROUVÉE |

## Conclusion
### CAS retenu: **CAS 1 – Problème de config/datapack (très probable)**
Le datapack serveur contient un branchement explicite pour un fossile shiny custom (`academy:shiny_fossil`) mais **aucun branchement équivalent pour des fossiles radiant**. Si vos "fossiles radiant" sont des items custom analogues, leur absence de mapping sous `data/cobblemon/fossils/` explique qu'ils ne soient pas pris en charge par la machine.

## Point d'attention
Si vos fossiles radiant proviennent d'un autre mod/plugin non versionné dans ce repo (ou d'un datapack externe non présent ici), alors une part du diagnostic sort du périmètre Git actuel.

## Corrections proposées (pour patch ultérieur)
1. Ajouter des définitions `data/cobblemon/fossils/*.json` pour chaque item radiant fossil attendu (même logique que `shiny_fossil.json`, adaptée au résultat voulu).
2. Vérifier que les items radiant réellement distribués (loot/marchands) correspondent **exactement** aux IDs attendus dans ces fichiers.
3. Si un plugin externe distribue les radiant fossils, documenter ses IDs et harmoniser avec les fichiers `data/cobblemon/fossils/`.
