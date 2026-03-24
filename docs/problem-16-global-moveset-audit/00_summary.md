# Audit global des movesets Pokémon et détection d'overrides

## Résumé exécutif

### Réponse courte
- **Source principale des learnsets in-game sur ce serveur :** les fichiers JSON Cobblemon sous `data/cobblemon/species/**`, où le learnset est porté par le champ `moves` directement dans la définition d'espèce ou de forme.
- **Surcharges trouvées :** **oui, partiellement et proprement via fichiers datapack**. Le repo contient déjà un système d'extension/surcharge basé sur `data/cobblemon/species_additions/**`.
- **Format exact :** JSON avec un champ `target` pointant vers une espèce existante, puis des champs partiels à fusionner (`forms`, `moves`, `evolutions`, `behaviour`, `riding`, etc.).
- **Rôle d'Academy :** Academy est surtout une **couche de contenu** qui exploite ce pipeline Cobblemon via son datapack `datapacks/Academy/data/cobblemon/**`. Je n'ai pas trouvé de preuve directe que le jar Academy introduise son propre loader spécifique aux learnsets.
- **Rôle des configs/scripts :** aucune preuve qu'un `serverconfig`, un fichier `config/`, ou des scripts runtime réécrivent les learnsets Cobblemon. Les configs Cobblemon/SimpleTMs consomment ou exposent les learnsets, mais ne définissent pas un système concurrent de surcharge par Pokémon.
- **Reproductibilité :** **oui**, le mécanisme le plus réaliste et le plus propre à reproduire plus tard est un **datapack Cobblemon** utilisant `species_additions` (ou un fichier `species` complet si l'espèce est entièrement custom).
- **Point d'entrée prioritaire pour Toxapex :** créer ou ajuster un fichier `data/cobblemon/species_additions/.../toxapex.json` dans un datapack serveur dédié, plutôt qu'un patch Java, un script, ou une config globale.

## Preuves directes principales

### 1) Les learnsets sont encodés dans `moves` à l'intérieur des fichiers d'espèces
Exemple net avec Pikachu dans le datapack Academy :
- la définition d'espèce contient un tableau `moves` mêlant niveau, egg, tm et tutor (`"1:thundershock"`, `"egg:bestow"`, `"tm:agility"`, `"tutor:thunderbolt"`).
- Cela montre que **level-up, egg, TM et tutor ne sont pas séparés en plusieurs fichiers dans ce repo** ; ils sont sérialisés dans une même liste canonique.

### 2) Le repo contient déjà un mécanisme d'override par fichier via `species_additions`
Deux preuves distinctes et complémentaires :
- `datapacks/Academy/data/cobblemon/species_additions/**` contient **261 fichiers** ciblant des espèces Cobblemon existantes.
- `datapacks/Journey Mounts/data/cobblemon/species_additions/generation7/toxapex.json` cible explicitement `cobblemon:toxapex`, mais n'ajoute que des données de monture (`riding`). Cela prouve que **`species_additions` fusionne des fragments partiels sur une espèce existante** sans redéfinir toute l'espèce.

### 3) `species_additions` peut aussi porter des moves
Exemples directs :
- `shaymin.json`, `hoopa.json`, `calyrex.json` dans `datapacks/Academy/data/cobblemon/species_additions/**` contiennent des sections `forms` avec leurs propres tableaux `moves`.
- Donc le mécanisme ne sert pas seulement aux montures ou au comportement : il peut porter de la donnée de learnset dès lors que celle-ci fait partie d'une forme ou d'une extension d'espèce.

## Ce que je tranche

### Existe-t-il déjà un système de surcharge des movesets Pokémon par fichier ?
**Oui, mais sous la forme d'un système de surcharge/extension des données d'espèce Cobblemon, pas d'un fichier "moveset override" séparé.**

### Sous quelle forme ?
- **Datapack**
- arborescence Cobblemon standard : `data/cobblemon/species/**` et surtout `data/cobblemon/species_additions/**`
- format JSON

### Avec quelle priorité ?
- **Preuve directe :** le repo charge les datapacks globaux via `config/global_packs.toml`.
- **Inférence probable :** Cobblemon charge d'abord la définition d'espèce de base, puis fusionne les `species_additions` qui ciblent cette espèce. C'est la seule explication cohérente au fait que des fichiers comme le Toxapex de Journey Mounts ne contiennent qu'un fragment `riding` et restent utilisables.
- **Hypothèse prudente :** si plusieurs datapacks fournissent des `species_additions` sur la même espèce, l'ordre exact dépend du chargeur de packs Minecraft/Cobblemon. Le repo ne contient pas de documentation interne explicitant une priorité fine pack-par-pack.

### Academy modifie-t-il ce système ?
- **Preuve directe :** Academy fournit énormément de données Pokémon via son datapack (`species`, `species_additions`, `spawn_pool_world`).
- **Preuve directe :** le jar Academy contient des classes de compatibilité Cobblemon et quelques mixins UI/battle/entity, mais je n'ai pas trouvé de ressource interne ni de chaîne explicite indiquant un loader custom de `species_additions` ou de learnsets.
- **Conclusion :** Academy semble **s'appuyer sur le système Cobblemon existant** plutôt que le remplacer.

### Un serverconfig peut-il surcharger les learnsets ?
**Aucune preuve trouvée.**
- `config/cobblemon/main.json` expose des réglages généraux, pas un mapping par espèce.
- `world/serverconfig/` ne contient pas de fichiers Cobblemon/Academy/SimpleTMs exploitables pour des learnsets.
- `config/simpletms/main.json` déclare des bascules globales (`tmMovesLearnable`, `eggMovesLearnable`, `tutorMovesLearnable`, `levelMovesLearnable`, etc.), mais pas d'override par Pokémon.

### Peut-on reproduire ensuite ce mécanisme pour modifier n'importe quel Pokémon ?
**Oui, vraisemblablement via datapack Cobblemon.**
La voie la plus sûre est :
1. créer un datapack dédié au patch ;
2. ajouter `data/cobblemon/species_additions/<generation>/toxapex.json` ;
3. cibler `"target": "cobblemon:toxapex"` ;
4. modifier le champ/les champs voulus dans la structure compatible Cobblemon.

## Recommandation prioritaire
1. **Ne pas toucher Journey Mounts** pour le learnset de Toxapex, sauf si on modifie réellement la couche monture.
2. **Créer un datapack de patch Pokémon séparé** et y placer un `species_additions` ciblant Toxapex.
3. Réutiliser le **même modèle JSON que Cobblemon/Academy** : le learnset passe par `moves`, avec préfixes `niveau:move`, `egg:move`, `tm:move`, `tutor:move`.
4. Faire le patch au plus local possible pour limiter les conflits lors des futures mises à jour du modpack.

## Bloc de conclusion demandé

- Source principale des learnsets : fichiers `data/cobblemon/species/**` avec learnset stocké dans `moves`.
- Overrides trouvés : oui, via `data/cobblemon/species_additions/**`.
- Format des overrides : JSON Cobblemon ciblant une espèce avec `target`, puis fusion de champs partiels (`forms`, `moves`, `behaviour`, `riding`, etc.).
- Rôle d’Academy : fournit surtout des données Cobblemon (species/species_additions/spawns) via datapack ; pas de preuve directe d’un loader custom de learnsets dans le jar.
- Rôle éventuel des configs : réglages globaux uniquement ; aucune preuve d’override par espèce dans les configs/serverconfig.
- Rôle éventuel des scripts : aucun système de script d’override de learnset trouvé.
- Reproductible pour d’autres Pokémon : oui, via datapack Cobblemon et `species_additions`.
- Serverconfig par-dessus possible : non prouvé ; très probablement non pour un override fin par espèce.
- Méthode recommandée pour une future modif de Toxapex : datapack dédié avec `data/cobblemon/species_additions/.../toxapex.json`.
- Niveau de confiance global : moyen à élevé.
