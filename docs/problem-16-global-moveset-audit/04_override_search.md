# Audit dédié à la recherche de surcharges

## Verdict noir sur blanc

- **override trouvé :** oui
- **format exact :** datapack Cobblemon JSON sous `data/cobblemon/species_additions/**`
- **exemple trouvé :** `datapacks/Journey Mounts/data/cobblemon/species_additions/generation7/toxapex.json`
- **portée :** un Pokémon ciblé par fichier, potentiellement des centaines d'espèces au niveau global
- **reproductible ensuite :** oui, avec fortes chances, via le même mécanisme

## 1. Recherche datapacks

### Résultat
Oui, le repo contient déjà un système d'override/extension par **datapack**.

### Preuves directes
- `datapacks/Academy/data/cobblemon/species_additions/**` → 261 fichiers
- `datapacks/Journey Mounts/data/cobblemon/species_additions/**` → 236 fichiers
- format commun : JSON Cobblemon avec `target`

### Exemple 1 : override partiel pur
`datapacks/Journey Mounts/data/cobblemon/species_additions/generation7/toxapex.json`
- cible `cobblemon:toxapex`
- ajoute uniquement `riding`
- ne redéfinit pas l'espèce entière
- cela démontre un **merge partiel**

### Exemple 2 : extension avec learnset
`datapacks/Academy/data/cobblemon/species_additions/generation6/hoopa.json`
- cible `cobblemon:hoopa`
- ajoute une forme `Unbound`
- la forme contient un tableau `moves`
- cela démontre qu'un `species_additions` peut porter de la donnée learnset

## 2. Recherche fichiers json/json5/hocon/toml en config

### Résultat
Aucun système crédible d'override des learnsets par espèce n'a été trouvé dans :
- `config/`
- `world/serverconfig/`
- `defaultconfigs/`

### Détail
- `config/cobblemon/main.json` : réglages globaux Cobblemon uniquement
- `config/simpletms/main.json` : activation globale de catégories d'apprentissage
- `config/simpletms/moves/*.json` : listes globales de moves TM/TR
- `config/academy/*.json` : gameplay/spawns/starters/UI Academy, pas de mapping learnset par espèce

### Conclusion
- **override trouvé en config : non**
- **override global de comportement TM/TR : oui, mais pas de learnset espèce par espèce**

## 3. Recherche scripts / kubejs / crafttweaker / js / groovy

### Résultat
Aucun système de script d'override de learnset n'a été trouvé.

### Conclusion
- **override trouvé par script : non**
- **reproductible par script dans ce repo : non prouvé**

## 4. Recherche ressources incluses dans les jars

### Academy jar
- classes de compatibilité Cobblemon
- mixins Cobblemon
- pas de preuve directe de loader `species_additions` alternatif ou spécifique aux learnsets

### CobblemonTrialsEdition jar
- addon de trial spawners
- pas de logique learnset observée

### Safari Dimension jar
- contient des `spawn_pool_world`
- influence les spawns, pas les learnsets

## 5. Recherche loaders de data côté code Java/Kotlin

### Ce qui a été trouvé
Dans Academy jar :
- `abeshutt/staracademy/compat/cobblemon/*`
- `abeshutt/staracademy/mixin/cobblemon/*`

### Ce qui n'a pas été trouvé
- aucune chaîne claire `species_additions`
- aucun dossier jar `data/cobblemon/species/**`
- aucun loader explicite nommé autour de `learnset`, `moveset`, `override`, `merge`

### Conclusion
- **preuve directe d'un loader custom Academy pour les learnsets : non**
- **inférence probable : Academy exploite le système Cobblemon standard par ressources datapack**

## 6. Réponse synthétique sur le mécanisme exact

### Mécanisme trouvé
- **type :** datapack Cobblemon
- **format :** JSON
- **emplacement :** `data/cobblemon/species_additions/**`
- **clé pivot :** `target`
- **logique observée :** fusion partielle de champs sur une espèce existante

### Priorité
- **preuve directe :** les datapacks du repo sont chargés
- **inférence probable :** la base Cobblemon est chargée puis enrichie par les additions
- **zone d'incertitude :** ordre exact entre plusieurs datapacks concurrents modifiant la même espèce

## 7. Conclusion d'audit override

### Preuve directe
Oui, il existe déjà un **système de surcharge des données d'espèce Pokémon par fichier**.

### Portée exacte
- il ne s'agit pas d'un fichier `learnset_override.json` dédié
- il s'agit d'un système plus général : **override/extension de la donnée espèce Cobblemon**
- comme le learnset fait partie de la donnée espèce, il est théoriquement modifiable par le même canal

### Réponse finale
**Oui : le mécanisme existant à reproduire plus tard est le datapack Cobblemon `species_additions`.**
