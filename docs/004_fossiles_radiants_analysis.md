# Rapport d'analyse — 004_fossiles_radiants_analysis

## 1) Résumé du contexte
Objectif fonctionnel attendu : la résurrection de `academy:radiant_fossil` doit produire un Pokémon avec **au moins 3 IV parfaits** (3 stats à 31), les autres IV restant aléatoires.

Constat initial à vérifier : un essai a donné seulement 1 IV parfait, ce qui suggère soit une configuration IV incorrecte/non reconnue, soit l'absence de mapping fossile actif pour cet item.

---

## 2) Inventaire des fichiers `fossils` trouvés dans le repo

### 2.1 Recherche exécutée
- `find . -type f -path '*/fossils/*.json' -o -type f -path '*/fossils/*/*.json' -o -type f -path '*/fossils/*/*/*.json' | sort`

### 2.2 Résultat
Un seul fichier fossile JSON a été trouvé :

1. `datapacks/Academy/data/cobblemon/fossils/shiny_fossil.json`

Contenu brut :

```json
{
 "result": "random_common shiny=yes",
 "fossils": [
   "academy:shiny_fossil"
 ]
}
```

**Observation clé :** aucun fichier `data/**/fossils/*.json` ne référence `academy:radiant_fossil`.

---

## 3) Analyse ciblée du fossile Radiant

## 3.1 Fichier Radiant localisé ?
Aucun fichier fossile machine (dans `data/**/fossils`) n'a été trouvé pour `academy:radiant_fossil`.

- Aucun `radiant_fossil.json` trouvé dans les datapacks.
- Aucun champ `fossils` contenant `academy:radiant_fossil` trouvé dans les fichiers fossils.

## 3.2 Ligne `result`/IVs (`perfectivs` vs `min_perfect_ivs`)
Puisqu'aucun fichier fossile Radiant n'est présent, il n'existe actuellement **aucune** ligne `result` active à inspecter pour ce fossile dans le repo.

Recherche globale IVs :
- `rg -n "perfectivs|min_perfect_ivs" .`
- Résultat : **aucune occurrence** dans le repo.

## 3.3 Conclusion technique sur le comportement observé
Dans l'état du dépôt :
- Le fossile Radiant n'a pas de mapping machine défini dans `data/**/fossils`.
- Donc la règle "3 IV parfaits minimum" ne peut pas être garantie par une config fossile locale (car elle n'existe pas ici).
- Si un comportement "1 IV parfait" est observé en jeu, il vient probablement :
  - d'un autre datapack non présent dans ce repo,
  - d'une ressource serveur non versionnée,
  - ou du comportement par défaut/indirect d'un autre système.

---

## 4) Overrides et conflits potentiels

## 4.1 Occurrences de `academy:radiant_fossil` / `radiant_fossil`
Recherche exécutée :
- `rg -n "academy:radiant_fossil|radiant_fossil" .`

Occurrences trouvées :
- `world/config/cobblemon-economy/config.json` (item boutique, prix 12000)
- Plusieurs fichiers de documentation (`docs/fossils_v2/...`, `docs/diagnostic_radiant_fossils.md`)

## 4.2 Conflits fossils actifs
- Aucun doublon fossils trouvé pour `academy:radiant_fossil`.
- En réalité : **zéro** fichier fossils actif pour cet item dans le repo.

## 4.3 Priorité/ordre de datapack
Le repo seul ne permet pas d'établir l'ordre de chargement exact côté serveur runtime.
Cependant, au vu des fichiers présents ici, il n'y a pas de conflit local entre deux définitions fossils du Radiant : il n'y en a aucune.

---

## 5) Version Cobblemon

## 5.1 Vérification effectuée
- Recherche de JAR Cobblemon explicite :
  - `find . -type f -path '*/mods/*cobblemon*.jar' | sort`
- Inspection des `fabric.mod.json` des mods pour dépendances Cobblemon :
  - script shell lisant `mods/*.jar` + extraction des contraintes `depends.cobblemon`.

## 5.2 Résultat
Aucun JAR coeur Cobblemon explicite (`cobblemon-*.jar` / `cobblemon-fabric-*.jar`) n'est présent dans ce dépôt.

Contraintes de dépendance observées dans d'autres mods :
- `CobblemonTrialsEdition-fabric-1.1.0.jar` -> `cobblemon >=1.7.1`
- `cobblemon-economy-0.0.13.jar` -> `cobblemon >=1.7.1`
- `cobblemon_spawn_alerts-fabric-1.11.2.jar` -> `cobblemon >=1.7.0`
- `Rad Gyms [Cobblemon]-0.3.1-stable.jar` -> `cobblemon >=1.7.0+1.21.1`
- autres dépendances plus larges (`>=1.7`, `*`, `>=1.6`).

## 5.3 Interprétation
- La **version exacte installée** de Cobblemon ne peut pas être confirmée depuis ce repo seul (JAR manquant).
- Les dépendances indiquent néanmoins un environnement attendu en **1.7.x minimum**, très probablement >= 1.7.1.
- Donc `min_perfect_ivs` est **très probablement disponible** (introduit en 1.7.0), mais la confirmation finale nécessite la présence/lecture du JAR Cobblemon réel en production.

---

## 6) Recommandations préliminaires pour le patch de correction

1. **Créer le fichier fossils Radiant manquant** dans le datapack Academy (ex. `datapacks/Academy/data/cobblemon/fossils/radiant_fossil.json`).
2. Définir un `result` avec PokemonProperties incluant `min_perfect_ivs=3` (et conserver tout autre attribut métier souhaité : shiny, niveau, etc.).
   - Exemple de forme attendue :
     - `"result": "<pokemon_or_pool> min_perfect_ivs=3 ..."`
3. Vérifier qu'il n'existe qu'une seule définition active pour `academy:radiant_fossil` dans l'ensemble des datapacks réellement chargés sur le serveur.
4. Si finalement la prod tourne sur Cobblemon < 1.7.0 (à vérifier avec le vrai JAR), prévoir une stratégie alternative (mise à jour Cobblemon ou addon dédié IVs).

---

## 7) Conclusion synthétique
Le bug "Radiant n'assure pas 3 IV parfaits" est, dans ce dépôt, d'abord expliqué par une cause structurelle : **absence de fichier fossils Radiant actif**. Il n'y a donc actuellement aucune configuration `result` appliquant `min_perfect_ivs=3` (ni même `perfectivs=3`).

Le prochain patch de correction devra d'abord ajouter/activer ce mapping fossils, puis appliquer explicitement `min_perfect_ivs=3` dans `result`.
