# Données Pokémon custom déjà présentes sur le serveur

## 1. Species complètes custom / embarquées par datapack

### Academy
`datapacks/Academy/data/cobblemon/species/**`
- 38 fichiers
- surtout starters, espèces/formes ajoutées ou complétées
- ces fichiers montrent le modèle complet espèce + learnset

### Journey Mounts
`datapacks/Journey Mounts/data/cobblemon/species/**`
- 3 fichiers observés
- usage spécialisé, surtout lié aux montures

## 2. Species additions

### Academy
`datapacks/Academy/data/cobblemon/species_additions/**`
- 261 fichiers
- scope : très large
- types de modifications observées :
  - nouvelles formes
  - moves dans les formes
  - comportement
  - drops
  - évolutions
  - dimensions/hitbox/échelles

### Journey Mounts
`datapacks/Journey Mounts/data/cobblemon/species_additions/**`
- 236 fichiers
- pattern : ajout de capacité de monture / `riding`
- **preuve que le serveur surcharge déjà des espèces existantes via additions**

## 3. Forms

### Observations
Les formes sont portées :
- soit dans `species/**`
- soit dans `species_additions/**` sous `forms`

### Intérêt
Cela prouve que le serveur modifie déjà des espèces existantes à un niveau plus fin qu'un simple ajout de spawn.

## 4. Spawn files

### Academy
`datapacks/Academy/data/cobblemon/spawn_pool_world/**`
- 41 fichiers
- modifications de pool de spawn, indépendantes des learnsets

### CCC / Safari
- `datapacks/CCC_1.9.2/data/cobblemon/spawn_pool_world/**`
- `mods/safari-dimension-0.0.11.jar` → `data/cobblemon/spawn_pool_world/safari/**`

### Intérêt
Montre un pattern clair : le serveur adapte déjà Cobblemon via datapacks ciblés.

## 5. Rewards / trainer data / autres couches Pokémon

### Rad Gyms / caches
- `datapacks/Academy/data/rad-gyms/**`
- on y trouve des teams, caches, récompenses
- utile pour le contexte de combat, mais pas source canonique du learnset espèce

### Economy / quests / player data
- divers fichiers référencent des espèces Cobblemon, mais pas comme définition de learnset

## 6. Pattern réutilisable détecté

### Pattern 1 — surcharge partielle d'espèce existante
- exemple : Journey Mounts → Toxapex avec `target`
- usage : enrichir une espèce sans la recopier entièrement

### Pattern 2 — ajout de formes et moves dans une species addition
- exemples : Shaymin / Hoopa / Calyrex dans Academy
- usage : enrichissement complexe d'espèce existante

### Pattern 3 — espèce complète via `species/**`
- usage : lorsque l'espèce complète est fournie ou fortement customisée

## 7. Réponse à l'objectif du document

Oui, le serveur **surcharge déjà d'autres aspects des Pokémon** :
- monture/riding
- formes
- comportement
- drops
- évolutions
- spawns
- et au moins certains blocs de learnset liés à des formes

Le **pattern réutilisable le plus propre** pour une future correction de learnset reste donc :
- datapack Cobblemon
- `species_additions`
- ciblage précis par espèce
