# Cartographie utile du repo

## 1. Dossiers clés audités

### Datapacks
- `datapacks/Academy/`
  - datapack majeur ; contient des données Cobblemon directes :
    - `data/cobblemon/species/**`
    - `data/cobblemon/species_additions/**`
    - `data/cobblemon/spawn_pool_world/**`
- `datapacks/Journey Mounts/`
  - contient aussi :
    - `data/cobblemon/species/**`
    - `data/cobblemon/species_additions/**`
  - mais les preuves trouvées portent sur la couche monture/riding, pas sur les learnsets.
- `datapacks/CCC_1.9.2/`
  - principalement des fichiers de spawn Cobblemon déjà exploités dans d'autres docs du repo.
- autres datapacks (`stellarity`, `MoreRecipesDatapack`, etc.) : sans rôle direct prouvé sur les learnsets Pokémon.

### Configs
- `config/cobblemon/main.json`
  - config générale Cobblemon.
- `config/simpletms/`
  - logique globale TM/TR et listes de moves TM/TR.
- `config/academy/`
  - nombreuses configs Academy (spawn, safari, starters, etc.), mais pas de base d'override de learnset détectée.
- `config/global_packs.toml`
  - point critique : charge globalement les datapacks et resourcepacks du repo.

### Defaultconfigs
- Aucun dossier `defaultconfigs/` significatif trouvé dans la racine du repo.

### Scripts / KubeJS / CraftTweaker / Groovy
- Aucun dossier `kubejs/` trouvé.
- Aucun dossier `scripts/` pertinent pour des overrides Cobblemon trouvé à la racine.
- Pas de pattern CraftTweaker/Groovy/ZenScript servant à muter les learnsets in-game.

### Server config versionnée
- `world/serverconfig/` existe, mais aucun fichier Cobblemon/Academy/SimpleTMs utile aux learnsets n'y a été trouvé.

### Resourcepacks
- `resourcepacks/Academy/`
- `resourcepacks/CCC_1.9.2/`
- `resourcepacks/Journey Mounts/`
- `resourcepacks/Radiants/`
- rôle observé : assets/bedrock/textures/models/forms visuelles, pas source canonique des learnsets.

### Mods / jars
- `mods/academy-mc1.21.1-v2.2.0+build.532-fabric.jar`
- `mods/CobblemonTrialsEdition-fabric-1.1.0.jar`
- `mods/Rad Gyms [Cobblemon]-0.3.1-stable.jar`
- `mods/cobblemon-economy-0.0.13.jar`
- `mods/cobblemon_knowlogy-fabric-1.5.0-1.21.1.jar`
- `mods/cobblemon_spawn_alerts-fabric-1.11.2.jar`
- le **jar Cobblemon de base n'est pas présent sous un nom évident dans `mods/`**, mais la dépendance Cobblemon est confirmée par le jar `CobblemonTrialsEdition`.

### Docs existantes liées à Cobblemon / Academy / Pokémon
- `docs/pokemon/`
- `docs/spawn/`
- `docs/problem-01*`
- `docs/gym_rewards/`
- utiles pour le contexte gameplay/spawn, mais elles ne décrivent pas le pipeline réel de chargement des learnsets.

### Autres dossiers liés à Pokémon
- `showdown/`
  - contient une base de données Showdown complète, y compris des `learnsets.js` côté simulateur.
  - **attention : ce n'est pas une preuve que ces learnsets gouvernent l'apprentissage in-game Cobblemon**.
- `world/pokemon/`
  - stockage runtime des Pokémon (party/pc), pas source de définition canonique d'espèce.
- `world/cobblemonplayerdata/`
  - données joueur / dex / captures, pas source de learnset global.

## 2. Carte fonctionnelle par rôle

### Source probable de données Pokémon canoniques
- `datapacks/Academy/data/cobblemon/species/**`
- `datapacks/Academy/data/cobblemon/species_additions/**`
- `datapacks/Journey Mounts/data/cobblemon/species/**`
- `datapacks/Journey Mounts/data/cobblemon/species_additions/**`

### Source de spawns
- `datapacks/Academy/data/cobblemon/spawn_pool_world/**`
- `datapacks/CCC_1.9.2/data/cobblemon/spawn_pool_world/**`
- `mods/safari-dimension-0.0.11.jar` → `data/cobblemon/spawn_pool_world/safari/**`

### Source de réglages globaux, mais pas de learnset par espèce
- `config/cobblemon/main.json`
- `config/simpletms/main.json`
- `config/simpletms/moves/*.json`
- `config/academy/*.json`

### Source visuelle / formes / modèles
- `resourcepacks/*/assets/cobblemon/**`

## 3. Jars prioritaires audités

### Academy
- `mods/academy-mc1.21.1-v2.2.0+build.532-fabric.jar`
- contient :
  - compat Cobblemon
  - configs Academy
  - mixins Cobblemon
  - pas de dossier interne `data/cobblemon/species/**` trouvé
  - pas de système explicite de `species_additions` embarqué dans le jar trouvé

### Cobblemon base
- non localisé comme jar autonome dans `mods/`
- **indice direct** : `mods/CobblemonTrialsEdition-fabric-1.1.0.jar` déclare la dépendance `"cobblemon": ">=1.7.1"`
- `config/cobblemon/main.json` déclare aussi `"lastSavedVersion": "1.7.1"`
- donc l'environnement est bien construit autour de Cobblemon 1.7.1

### Addons Pokémon pertinents
- `CobblemonTrialsEdition`
- `Rad Gyms [Cobblemon]`
- `cobblemon-economy`
- `cobblemon_knowlogy`
- `cobblemon_spawn_alerts`
- aucun n'a fourni de preuve directe d'un override de learnset par fichier plus pertinent que `species_additions`.

## 4. Ce qui est le plus utile pour la suite

### Pour corriger un learnset
- prioriser :
  - `datapacks/Academy/data/cobblemon/species_additions/**`
  - ou un nouveau datapack dédié reproduisant la même structure

### Pour comprendre un spawn
- regarder :
  - `data/cobblemon/spawn_pool_world/**`

### Pour comprendre les TM/TR
- regarder :
  - `config/simpletms/main.json`
  - `config/simpletms/moves/*.json`

### Pour éviter les faux positifs
- ne pas traiter comme source canonique de learnset :
  - `showdown/**`
  - `world/pokemon/**`
  - `world/cobblemonplayerdata/**`
  - les resourcepacks purement visuels
