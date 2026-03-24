# Cibles pour le prochain patch

## 1. Meilleurs fichiers/dossiers à modifier pour changer un learnset

### Cible recommandée n°1
Créer un datapack dédié, par exemple :
- `datapacks/<patch_name>/data/cobblemon/species_additions/generation7/toxapex.json`

### Pourquoi
- le mécanisme existe déjà dans le repo
- le ciblage par espèce est naturel via `target`
- cela évite de mélanger le patch learnset avec Journey Mounts ou Academy cœur

### Cible recommandée n°2
Si nécessaire, s'inspirer de :
- `datapacks/Academy/data/cobblemon/species_additions/**`
- `datapacks/Journey Mounts/data/cobblemon/species_additions/**`

## 2. Approche recommandée pour Toxapex

### Ce que l'audit a trouvé
- Toxapex existe déjà comme cible valide de `species_additions` dans Journey Mounts
- ce fichier ne touche qu'à `riding`
- donc Toxapex est déjà branché sur le pipeline de fusion partielle

### Recommandation
- créer un **nouveau** `species_additions` dédié au learnset de Toxapex
- ne pas détourner Journey Mounts pour cela
- ne pas toucher aux teams de gym ou fichiers showdown comme source de vérité

### Local ou global ?
- **local au Pokémon**
- préférable pour limiter les effets de bord

## 3. Approche recommandée pour n'importe quel Pokémon

### Stratégie standard
1. vérifier si l'espèce existe déjà dans Cobblemon de base
2. créer un `species_additions/<generation>/<pokemon>.json`
3. cibler `target`
4. ne modifier que le minimum nécessaire
5. documenter explicitement le but du patch

### Si une forme spécifique est concernée
- patcher la forme concernée dans `forms`
- éviter une redéfinition complète inutile

## 4. Risques de conflit avec les mises à jour du modpack

### Risque faible à moyen
- si le patch est isolé dans son propre datapack
- si l'espèce ciblée n'est pas simultanément modifiée par plusieurs packs sur les mêmes champs

### Risque moyen à fort
- si Academy, Journey Mounts et un futur patch modifient tous exactement la même portion de donnée pour la même espèce
- surtout si la priorité de packs n'est pas explicitement maîtrisée

### Risque élevé
- patch Java/mod custom
- patch runtime opaque
- modifications directes d'un jar tiers

## 5. Recommandation opérationnelle finale

### Pour Toxapex
- préparer un datapack dédié de correction
- cibler `cobblemon:toxapex` via `species_additions`
- valider ensuite en jeu que la fusion garde les autres ajouts existants (notamment monture si applicable)

### Pour l'ensemble du serveur
- standardiser toutes les futures corrections Pokémon sur un **pack de patchs Cobblemon** séparé
- cela donnera un point unique de maintenance pour les overrides d'espèces et de learnsets
