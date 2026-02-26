# Fossils mapping problems (v2)

Comparaison entre :
1) fossiles présents dans les canaux d'obtention (loot/shop),
2) fossiles référencés par `data/cobblemon/fossils/*.json`.

## 1) Fossiles loot/shop sans fichier `fossils/*.json`

### Spéciaux Academy
- `academy:ha_fossil` (présent en loot `basic_gym/t0.json`) → **mapping manquant**.
- `academy:max_iv_fossil` (présent en loot `basic_gym/t0.json`) → **mapping manquant**.

### Standards Cobblemon
- Les 15 fossiles standards (`cobblemon:*_fossil` + `cobblemon:fossilized_*`) sont lootables via `academy:cobblemon/fossils` mais n'ont pas de fichier local dans ce datapack. Ce n'est **pas forcément une erreur** si la logique est fournie par Cobblemon en interne; à confirmer avec le JAR du mod Cobblemon principal (non présent dans ce repo).

## 2) Fichiers `fossils/*.json` pointant vers un item_id non réel
- Aucun cas détecté dans le repo.
- `datapacks/Academy/data/cobblemon/fossils/shiny_fossil.json` pointe vers `academy:shiny_fossil`, item cohérent avec loot + assets Academy.

## 3) Fossiles spéciaux dont la config ne reflète pas le rôle attendu
- `academy:ha_fossil` : rôle HA attendu, mais **aucune config machine**.
- `academy:max_iv_fossil` : rôle IV max attendu, mais **aucune config machine**.
- `academy:radiant_fossil` : rôle radiant attendu, mais **aucune config machine** et pas de source loot/trade trouvée dans les datapacks du repo.

## 4) Contrôle radiant
- Aucun fichier `data/cobblemon/fossils/*radiant*.json` trouvé.
- Aucun loot/trade datapack donnant `academy:radiant_fossil` trouvé.
