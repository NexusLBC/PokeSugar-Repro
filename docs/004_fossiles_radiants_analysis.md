# Rapport d'analyse — 004_fossiles_radiants_analysis

## 1. Résumé du contexte
But attendu : la résurrection de `academy:radiant_fossil` via la machine à fossiles Cobblemon doit garantir **au moins 3 IV parfaits** (3 stats à 31), les autres IV restant aléatoires.

Hypothèse à valider : `perfectivs=3` a probablement été utilisé, alors que l'attribut reconnu dans les PokemonProperties Cobblemon (>= 1.7.0) est `min_perfect_ivs=3`.

---

## 2. Liste des fichiers fossils pertinents (`data/**/fossils/**/*.json`)

### 2.1 Commandes exécutées
- `rg --files | rg 'data/.*/fossils/.*\.json$'`
- `cat datapacks/Academy/data/cobblemon/fossils/shiny_fossil.json`

### 2.2 Résultat exhaustif
Un seul fichier fossils a été trouvé dans le dépôt :

### `datapacks/Academy/data/cobblemon/fossils/shiny_fossil.json`
```json
{
 "result": "random_common shiny=yes",
 "fossils": [
   "academy:shiny_fossil"
 ]
}
```

**Constat :** aucun fichier `data/**/fossils/**/*.json` ne contient `academy:radiant_fossil`.

---

## 3. Analyse détaillée du fossile Radiant

### 3.1 Fichier Radiant localisé
Aucun fichier fossils machine ne référence `academy:radiant_fossil` dans ce repo.

- Aucun `radiant_fossil.json` détecté.
- Aucun champ `"fossils"` contenant `academy:radiant_fossil`.

### 3.2 Vérification des attributs IV dans `result`
Commandes exécutées :
- `rg -n "academy:radiant_fossil|radiant_fossil"`
- `rg -n "perfectivs|min_perfect_ivs"`

Résultat :
- `perfectivs=3` : **absent** du repo.
- `min_perfect_ivs=...` : **absent** du repo.
- Aucun `result` Radiant à inspecter (fichier fossils Radiant manquant).

### 3.3 Conclusion technique (état actuel)
Actuellement, le fossile Radiant ne garantit pas 3 IV parfaits **parce qu'il n'existe pas de mapping fossils Radiant actif dans ce dépôt**. Sans entrée `data/**/fossils/...` associée à `academy:radiant_fossil`, aucune propriété IV (`perfectivs` ou `min_perfect_ivs`) ne peut s'appliquer localement à la résurrection.

---

## 4. Overrides et conflits éventuels

### 4.1 Occurrences globales de `academy:radiant_fossil` / `radiant_fossil`
Commande :
- `rg -n "academy:radiant_fossil|radiant_fossil"`

Occurrence de configuration runtime trouvée :
- `world/config/cobblemon-economy/config.json:111` (item en boutique)

Extrait :
```json
{
  "id": "academy:radiant_fossil",
  "name": "Fossile Radiant",
  "price": 12000
}
```

Autres occurrences : documentation (`docs/...`) uniquement.

### 4.2 Vérification de conflits fossils
- Aucun second fichier fossils n'utilise `academy:radiant_fossil`.
- Aucun fichier fossils Radiant n'existe, donc **pas de doublon/override observable dans ce repo**.

### 4.3 Priorité de datapacks
Le repo ne contient pas d'indication runtime fiable de l'ordre de chargement complet serveur. Néanmoins, côté sources présentes ici, il n'y a pas de compétition entre plusieurs définitions fossils Radiant (il n'y en a aucune).

---

## 5. Version de Cobblemon

### 5.1 Vérifications effectuées
Commandes :
- `find mods -maxdepth 1 -type f | sort`
- script Python d'inspection des `fabric.mod.json` dans `mods/*.jar` pour lire `depends.cobblemon`

### 5.2 Résultat
- Aucun JAR coeur Cobblemon (`cobblemon-*.jar` / `cobblemon-fabric-*.jar`) n'est présent dans `mods/` du dépôt.
- Dépendances Cobblemon relevées dans les addons :
  - `CobblemonTrialsEdition-fabric-1.1.0.jar` -> `>=1.7.1`
  - `cobblemon-economy-0.0.13.jar` -> `>=1.7.1`
  - `cobblemon_spawn_alerts-fabric-1.11.2.jar` -> `>=1.7.0`
  - `Rad Gyms [Cobblemon]-0.3.1-stable.jar` -> `>=1.7.0+1.21.1`
  - `rctapi-fabric-1.21.1-0.14.3-beta.jar` -> `>=1.7`
  - `safari-dimension-0.0.11.jar` -> `>=1.6`

### 5.3 Interprétation
- **Version exacte Cobblemon non prouvable** depuis ce repo seul (JAR coeur absent).
- Forte probabilité d'un environnement **>= 1.7.0** (plusieurs dépendances l'exigent), donc `min_perfect_ivs` est probablement supporté.
- Confirmation finale à faire sur le serveur avec le JAR Cobblemon réellement chargé.

---

## 6. Recommandations préliminaires (pour le patch de correction)

1. Ajouter un fichier fossils dédié Radiant (ex. `datapacks/Academy/data/cobblemon/fossils/radiant_fossil.json`).
2. Définir le `result` avec l'attribut reconnu :
   - `"result": "<pokemon_or_pool> min_perfect_ivs=3 ..."`
3. Conserver les autres propriétés métier déjà souhaitées (shiny, niveau, etc.) dans ce même `result`.
4. Vérifier en runtime qu'un seul datapack actif définit `academy:radiant_fossil`.
5. Si la prod est finalement en Cobblemon < 1.7.0, signaler qu'une autre stratégie sera nécessaire (upgrade Cobblemon ou addon IV dédié).

---

## 7. Conclusion synthétique
Le problème observé n'est pas, dans ce dépôt, un mauvais attribut (`perfectivs`) dans le JSON Radiant : c'est d'abord l'**absence totale** de fichier fossils Radiant actif. Le correctif prioritaire sera d'ajouter cette définition et d'utiliser `min_perfect_ivs=3` dans `result` (si version Cobblemon >= 1.7.0 confirmée côté serveur).
