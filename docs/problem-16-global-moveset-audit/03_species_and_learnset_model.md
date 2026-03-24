# Modèle réel espèces / learnsets observé

## 1. Où vivent les données espèces ?

### Données d'espèces complètes
Les données complètes d'espèce observées dans ce repo vivent dans :
- `data/cobblemon/species/**`

Exemples :
- starters ajoutés/complétés par Academy
- quelques espèces Journey Mounts

Ces fichiers contiennent en une seule structure JSON :
- identité de l'espèce
- stats
- types
- abilities
- behaviour
- drops
- évolutions
- et **learnset** via le champ `moves`

## 2. Où vivent les learnsets ?

### Réponse réelle
Les learnsets ne sont pas stockés ici dans un dossier séparé `learnsets/`.
Le modèle observé est :
- **champ `moves` dans le JSON de l'espèce ou de la forme**

### Format du champ `moves`
Le tableau `moves` agrège plusieurs catégories :
- `niveau:move` → ex. `1:thundershock`
- `egg:move`
- `tm:move`
- `tutor:move`

### Conséquence importante
Il n'y a pas, dans ce repo, de séparation opérationnelle visible entre :
- level-up learnset
- egg moves
- tutor moves
- TM/TR compatibility

Tout est sérialisé ensemble dans `moves`, avec des préfixes de catégorie.

## 3. Où vivent les overrides / extensions ?

### Dossier observé
- `data/cobblemon/species_additions/**`

### Modèle observé
Un fichier d'addition contient :
- `"target": "cobblemon:<species>"`
- puis un sous-ensemble de champs à ajouter/fusionner

Exemples de champs observés :
- `forms`
- `moves` (à l'intérieur de formes ajoutées)
- `evolutions`
- `behaviour`
- `riding`
- `baseScale`
- `hitbox`
- `drops`

## 4. Séparation éventuelle entre species, form, learnset, move pool, tutor, TM, egg moves, level-up

### Ce qui est directement prouvé
- **species** : `data/cobblemon/species/**`
- **species additions / partial overrides** : `data/cobblemon/species_additions/**`
- **forms** : intégrées soit dans le fichier espèce, soit dans un `species_additions` via `forms`
- **learnset** : `moves`
- **level-up / egg / tm / tutor** : codés comme sous-types dans `moves`

### Ce qui n'a pas été trouvé comme source séparée
- pas de dossier `learnsets/`
- pas de dossier `movesets/`
- pas de fichier TM/TR par espèce dans `config/`
- pas de patch script par espèce

### Nuance sur TM/TR
Le mod SimpleTMs a ses propres listes globales de moves TM/TR, mais cela ressemble à une couche de gameplay/objets TM/TR et non à la source canonique des learnsets Cobblemon par espèce.

## 5. Système de chargement estimé

### Pipeline reconstruit
1. Minecraft charge les datapacks déclarés par l'instance.
2. `config/global_packs.toml` force le chargement du dossier `datapacks/`.
3. Cobblemon consomme les ressources `data/cobblemon/**` présentes dans ces datapacks.
4. Les fichiers `species/**` apportent des espèces complètes.
5. Les fichiers `species_additions/**` ciblent des espèces existantes et fusionnent des champs supplémentaires ou alternatifs.
6. Les mods add-ons (Academy, Journey Mounts, etc.) exploitent ce pipeline en déposant leurs propres ressources Cobblemon.

## 6. Ordre de priorité estimé

### Preuve directe
- les datapacks sont chargés depuis `datapacks/`
- `species_additions` contient des fragments incomplets, ce qui implique un modèle de fusion sur une base préexistante

### Inférence probable
- **base mod Cobblemon** : fournit l'espèce de référence
- **datapack species** : peut fournir une espèce complète additionnelle ou redéfinie
- **datapack species_additions** : fusionne/étend la base
- **Academy** : ajoute/complète des espèces via ce système
- **Journey Mounts** : ajoute des blocs `riding` via ce système
- **scripts/configs** : pas de preuve d'intervention après coup sur le learnset

### Hypothèse prudente
L'ordre exact entre plusieurs datapacks concurrents n'est pas documenté noir sur blanc dans le repo. Il faut donc considérer la priorité fine multi-pack comme **probable mais non totalement prouvée** sans audit du code Cobblemon lui-même.

## 7. Ce que ce modèle implique pour un patch futur

### Pour modifier un learnset d'une espèce vanilla Cobblemon
Le meilleur modèle observé est :
- **ne pas patcher une config globale**
- **ne pas patcher un script runtime**
- **utiliser un datapack Cobblemon**, idéalement via `species_additions`

### Pour modifier une forme spécifique
- cibler la `form` dans la structure d'addition si le patch vise une forme précise

### Pour Toxapex
- le repo prouve déjà que Toxapex est une cible valide de `species_additions` via Journey Mounts
- il est donc réaliste d'utiliser le même point d'accroche pour un patch learnset futur
