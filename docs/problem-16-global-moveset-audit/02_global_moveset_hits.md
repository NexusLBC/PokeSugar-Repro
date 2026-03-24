# Inventaire global des occurrences utiles liées aux learnsets / movesets

> Méthode : inventaire **curé** des hits réellement utiles à la question des learnsets et overrides. Les hits purement décoratifs, logs joueurs, assets visuels, ou données Showdown non prouvées in-game ont été écartés.

## Hits de très forte importance

### 1) `datapacks/Academy/data/cobblemon/species/generation1/pikachu.json`
- **Extrait court :** `"moves": [ "1:thundershock", ... "egg:bestow", ... "tm:agility", ... "tutor:thunderbolt" ]`
- **Rôle supposé :** preuve directe que le learnset Cobblemon est stocké dans `moves` au sein du JSON d'espèce.
- **Confiance :** forte.
- **Importance :** forte.

### 2) `datapacks/Academy/data/cobblemon/species_additions/generation4/shaymin.json`
- **Extrait court :** `"target": "cobblemon:shaymin"` puis dans `forms[0]`, `"moves": [ ... ]`
- **Rôle supposé :** preuve directe qu'un `species_additions` peut injecter des formes et leurs learnsets sans redéfinir une espèce complète.
- **Confiance :** forte.
- **Importance :** forte.

### 3) `datapacks/Academy/data/cobblemon/species_additions/generation6/hoopa.json`
- **Extrait court :** `"target": "cobblemon:hoopa"` avec `forms` puis `"moves": [ ... ]`
- **Rôle supposé :** second exemple indépendant de surcharge/extension learnset via `species_additions`.
- **Confiance :** forte.
- **Importance :** forte.

### 4) `datapacks/Academy/data/cobblemon/species_additions/generation8/calyrex.json`
- **Extrait court :** `"target": "cobblemon:calyrex"` et plusieurs formes contenant `"moves": [ ... ]`
- **Rôle supposé :** montre que le système d'extension est utilisé à grande échelle pour des formes complexes.
- **Confiance :** forte.
- **Importance :** forte.

### 5) `datapacks/Journey Mounts/data/cobblemon/species_additions/generation7/toxapex.json`
- **Extrait court :** `"target": "cobblemon:toxapex"` puis bloc `"riding"`
- **Rôle supposé :** preuve directe que `species_additions` sert bien de mécanisme de fusion partielle sur une espèce existante ; ici pour la monture, pas pour les moves.
- **Confiance :** forte.
- **Importance :** forte.

### 6) `config/global_packs.toml`
- **Extrait court :** `[datapacks] required = ["datapacks/", "global_packs/required_data/"]`
- **Rôle supposé :** preuve que les datapacks du repo sont effectivement injectés dans le chargement.
- **Confiance :** forte.
- **Importance :** forte.

## Hits de moyenne importance

### 7) `config/cobblemon/main.json`
- **Extrait court :** `"lastSavedVersion": "1.7.1"`, `"exportSpawnConfig": true`, `"exportStarterConfig": true`
- **Rôle supposé :** confirme l'environnement Cobblemon 1.7.1 et montre des exports de spawn/starter, mais pas d'override de learnset par config.
- **Confiance :** forte.
- **Importance :** moyenne.

### 8) `config/simpletms/main.json`
- **Extrait court :** `"tmMovesLearnable": true`, `"eggMovesLearnable": true`, `"tutorMovesLearnable": true`, `"levelMovesLearnable": true`
- **Rôle supposé :** système consommant les catégories de learnset Cobblemon ; ce n'est pas la source canonique du learnset espèce par espèce.
- **Confiance :** forte.
- **Importance :** moyenne.

### 9) `config/simpletms/moves/default_tm_moves.json`
- **Extrait court :** liste de `moveName`
- **Rôle supposé :** catalogue global TM pour le mod SimpleTMs ; ne remplace pas le learnset Cobblemon lui-même.
- **Confiance :** forte.
- **Importance :** moyenne.

### 10) `config/simpletms/moves/default_tr_moves.json`
- **Extrait court :** liste de `moveName`
- **Rôle supposé :** catalogue global TR ; même remarque que ci-dessus.
- **Confiance :** forte.
- **Importance :** moyenne.

### 11) `mods/academy-mc1.21.1-v2.2.0+build.532-fabric.jar`
- **Extrait court :** présence de classes `abeshutt/staracademy/compat/cobblemon/...`, `abeshutt/staracademy/mixin/cobblemon/...`
- **Rôle supposé :** Academy interagit avec Cobblemon, mais sans preuve directe de loader custom learnset.
- **Confiance :** moyenne à forte.
- **Importance :** moyenne.

### 12) `mods/CobblemonTrialsEdition-fabric-1.1.0.jar`
- **Extrait court :** dépendance Fabric `"cobblemon": ">=1.7.1"`
- **Rôle supposé :** confirme que l'instance est bien structurée autour de Cobblemon ; ne dit rien directement sur les learnsets.
- **Confiance :** forte.
- **Importance :** moyenne.

### 13) `datapacks/Academy/data/cobblemon/species/**`
- **Extrait court :** 38 fichiers présents.
- **Rôle supposé :** espèces/custom species complètes embarquées par datapack Academy.
- **Confiance :** forte.
- **Importance :** moyenne.

### 14) `datapacks/Academy/data/cobblemon/species_additions/**`
- **Extrait court :** 261 fichiers présents.
- **Rôle supposé :** gisement principal d'overrides/compléments de données d'espèces déjà existantes.
- **Confiance :** forte.
- **Importance :** forte.

### 15) `datapacks/Journey Mounts/data/cobblemon/species_additions/**`
- **Extrait court :** 236 fichiers présents.
- **Rôle supposé :** gros usage du même mécanisme pour la monture/riding ; utile pour prouver la fusion partielle, mais hors learnset sauf preuve contraire.
- **Confiance :** forte.
- **Importance :** moyenne.

## Hits contextuels à ne pas surinterpréter

### 16) `showdown/data/**/learnsets.js`
- **Extrait court :** base de données learnsets côté simulateur Showdown.
- **Rôle supposé :** utile pour le simulateur/battle sim uniquement si intégré ; aucune preuve directe ici que c'est la source in-game d'apprentissage Cobblemon.
- **Confiance :** moyenne.
- **Importance :** moyenne mais **non canonique** pour le serveur sans preuve supplémentaire.

### 17) `docs/problem-01/...` et `docs/spawn/...`
- **Extrait court :** multiples références à espèces Cobblemon, dont Mareanie/Toxapex.
- **Rôle supposé :** documentation interne du serveur, surtout sur les spawns/récompenses.
- **Confiance :** forte.
- **Importance :** faible à moyenne pour le sujet learnset.

### 18) `datapacks/Academy/data/rad-gyms/gyms/poison.json`
- **Extrait court :** set combat `toxapex ... moves=liquidation,toxic,haze,recover`
- **Rôle supposé :** moveset de trainer/gym, **pas** learnset canonique de l'espèce.
- **Confiance :** forte.
- **Importance :** moyenne pour le contexte Toxapex, mais faible comme source de learnset.

### 19) `world/pokemon/**` et `world/cobblemonplayerdata/**`
- **Extrait court :** données runtime contenant des espèces capturées.
- **Rôle supposé :** stockage d'état de partie ; pas source de définition globale des learnsets.
- **Confiance :** forte.
- **Importance :** faible.

## Bilan des hits

### Preuve directe
- Les learnsets vivent dans `moves` au niveau espèce/forme.
- Le repo charge des datapacks globaux.
- `species_additions` est déjà massivement utilisé.
- `species_additions` peut fusionner des moves/forms/behaviour/riding sur une espèce existante.

### Inférence probable
- Le mécanisme standard Cobblemon de fusion de données d'espèce est le vrai point d'override à exploiter pour une correction future.

### Hypothèses restantes
- L'ordre exact si plusieurs datapacks écrivent sur le même champ d'une même espèce n'est pas documenté explicitement dans le repo.
