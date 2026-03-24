# Audit spécifique du jar Academy

## 1. Jar trouvé
- **Nom exact :** `mods/academy-mc1.21.1-v2.2.0+build.532-fabric.jar`
- **Version trouvée :** `2.2.0`

## 2. Structure interne utile

### Métadonnées
- `fabric.mod.json`
- identifiant mod : `academy`
- description : integration mod for the Cobblemon Academy modpack

### Packages utiles trouvés
- `abeshutt/staracademy/compat/cobblemon/`
- `abeshutt/staracademy/config/`
- `abeshutt/staracademy/mixin/cobblemon/`
- `abeshutt/staracademy/world/data/`

### Classes particulièrement visibles
- `GameStarterHandler`
- `ECCobblemonConfig`
- `MixinPlayerSpawnerFactory`
- `MixinPokemonBattle`
- `MixinPokemonEntity`
- `MixinFormDexRecord`

## 3. Présence de data Pokémon/species/moves dans le jar

### Résultat
Je n'ai pas trouvé dans le jar Academy :
- de dossier `data/cobblemon/species/**`
- de dossier `data/cobblemon/species_additions/**`
- de ressources internes `learnset`, `moveset`, `species_additions`, `species_overrides`

### Interprétation
Le contenu Pokémon d'Academy semble principalement fourni par le **datapack externe versionné dans le repo**, pas embarqué directement dans le jar lui-même.

## 4. Présence de classes de chargement / modification

### Ce qui est prouvé
Le jar contient des classes de compatibilité Cobblemon et des mixins Cobblemon.

### Ce qui n'est pas prouvé
Je n'ai pas trouvé de trace directe :
- d'un chargeur custom de learnsets
- d'un système explicite de merge `species_additions`
- d'un pipeline alternatif pour les movesets

## 5. Présence de logique d'extension ou fusion des learnsets

### Preuve directe
Aucune preuve directe dans le jar Academy lui-même.

### Inférence probable
Academy :
- enrichit l'écosystème Cobblemon ;
- mais délègue probablement la donnée espèce/learnset au pipeline de ressources Cobblemon déjà standard, via le datapack `datapacks/Academy`.

## 6. Conclusion sur le rôle exact d'Academy

### Ce qu'Academy fait avec certitude
- ajoute des contenus gameplay/config/UI/compatibilité autour de Cobblemon
- fournit des données Pokémon via le datapack Academy du repo
- modifie probablement certains comportements Cobblemon via mixins ciblés

### Ce qu'Academy ne prouve pas faire
- remplacer le système de learnsets par un loader propriétaire
- fournir un format alternatif d'override learnset
- injecter une config serveur par espèce pour les moves

## 7. Verdict
Le **rôle exact d'Academy** dans ce sujet est surtout :
- **couche de contenu prioritaire**
- **consommatrice/productrice de datapacks Cobblemon**
- **pas un remplaçant prouvé du modèle `species` / `species_additions`**
