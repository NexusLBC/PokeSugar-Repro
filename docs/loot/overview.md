# Vue d'ensemble du système de loot

## 1) Vanilla / Minecraft
- Présence de nombreuses overrides `minecraft:*` dans les datapacks Academy, Trek et Stellarity (chests, gameplay, entities, etc.).
- Les répertoires `minecraft:chests/*` et `minecraft:gameplay/*` concentrent les modifications de progression générale.

## 2) Cobblemon
- Les loot tables Cobblemon dans Academy passent surtout par `academy:cobblemon/*` (objets de progression Pokémon, fossiles standards).
- Les fossiles standards sont regroupés dans `academy:cobblemon/fossils` avec poids égaux.
- Le mapping machine de résurrection custom trouvé: `data/cobblemon/fossils/shiny_fossil.json` pour `academy:shiny_fossil`.

## 3) Custom Academy
- `academy:basic*`, `academy:basic_gym*`, `academy:radgyms*`, `academy:gimmicks*` structurent la progression serveur.
- `academy:basic_gym/t0` contient un pool explicite pour `academy:shiny_fossil`, `academy:ha_fossil`, `academy:max_iv_fossil`.

## 4) Structures tierces
- Trek et Stellarity apportent un volume important de loot de structures (coffres, archaeology, villages, mobs).
- `rad-gyms` s'appuie sur des processor lists injectant des `loot_table` par type de gym.

## Comment modifier le loot proprement (sans changer les rates ici)
1. Modifier en priorité une table cible (éviter les changements globaux simultanés).
2. Toujours recalculer la somme des poids du pool après modification.
3. Pour buff un item rare, ajuster aussi les entrées `empty` et alternatives du même pool.
4. Vérifier les appels indirects (`entry` de type `loot_table` + `worldgen/... loot_table`).
5. Tester en jeu par source (coffre/bloc/mob/marchand) après chaque mini-lot de changements.
