# Analyse approfondie V2 — prix du Card Grader

## 1) Où la clé `gradingCurrencyCost` est réellement trouvée

### 1.1 Config JSON du serveur
- Fichier trouvé : `config/academy/npc.json`
- Valeur actuelle observée :
  - `"gradingCurrencyCost": 10000`
- Ce fichier contient aussi :
  - `cardGraderNpcName`
  - `gradingTimeMillis`

### 1.2 Dans les JAR du modpack
Recherche binaire dans les JAR (`mods/*.jar`) :
- **Occurrence de `gradingCurrencyCost` trouvée uniquement dans le JAR academy**:
  - `mods/academy-mc1.21.1-v2.2.0+build.532-fabric.jar`
  - classe : `abeshutt/staracademy/config/NPCConfig.class`
- Aucune occurrence de `gradingCurrencyCost` trouvée dans les autres mods.

Recherche complémentaire (`Card Grader`) :
- trouvée dans `assets/academy/lang/en_us.json` (texte d’UI/traduction), pas comme source de prix.

### 1.3 Configs monde / serverconfig / defaultconfigs
- Pas de `defaultconfigs/` dans ce repo.
- `world/serverconfig/` existe mais ne contient pas de config academy (uniquement `openpartiesandclaims-*`).
- `world/data/academy/` contient des `.dat` (données sauvegardées), dont `card_grading.dat`.
- Aucun `academy-server.toml`, `academy-common.toml` ou équivalent détecté.

---

## 2) Comment le coût est lu et appliqué (chaîne d’exécution)

## 2.1 Source config academy : JSON fichier `config/academy/*.json`
Décompilation de `abeshutt.staracademy.config.FileConfig` :
- `getConfigFile()` construit explicitement le chemin :
  - `config/academy/<path>.json`
- Pour `NPCConfig`, `getPath()` retourne `"npc"`.
- Donc la lecture du coût se fait depuis :
  - `config/academy/npc.json`

Important :
- Si le fichier manque, `read()` fait `reset()` puis écrit un nouveau fichier (valeurs par défaut).
- Les valeurs par défaut de `NPCConfig.reset()` incluent :
  - `gradingCurrencyCost = 10000`
  - `gradingTimeMillis = 5000`
  - `safariCurrencyCost = 10000`

Conclusion intermédiaire :
- `config/academy/npc.json` n’est **pas un leurre** : c’est bien une source active du mod academy.

## 2.2 Classe qui applique le coût du Card Grader
Décompilation de `abeshutt.staracademy.entity.CardGraderNPCEntity` :
- Lors de l’interaction avec le PNJ grader :
  - vérifie `Platform.isModLoaded("numismatic-overhaul")`.
  - récupère les fonds joueur via `CurrencyComponent.getValue()`.
  - compare au coût via `ModConfigs.NPC.getGradingCurrencyCost()`.
  - si insuffisant : message "broke".
  - sinon : débite via `pushTransaction(-cost)` + `commitTransactions()`.

Donc le coût affiché / appliqué côté transaction du grader provient bien de :
- `ModConfigs.NPC.getGradingCurrencyCost()`
- donc indirectement `config/academy/npc.json` chargé dans `ModConfigs.NPC`.

## 2.3 Temps de grading (et données monde)
Décompilation de `abeshutt.staracademy.world.data.save.CardGradingData` :
- `getTimeLeft()` calcule :
  - `entry.time + ModConfigs.NPC.getGradingTimeMillis() - now`
- `world/data/academy/card_grading.dat` stocke des entrées de grading (UUID, stack, time),
  mais pas de clé de coût globale à surcharger.

Donc :
- les `.dat` monde stockent l’état des demandes en cours,
- pas une config alternative de prix.

---

## 3) Priorité / ordre d’application identifié

Ordre observé côté code academy :
1. `ModConfigs.register(...)` charge les `FileConfig.read()`.
2. `NPCConfig.read()` lit `config/academy/npc.json`.
3. `CardGraderNPCEntity` lit le coût en mémoire via `ModConfigs.NPC.getGradingCurrencyCost()` au moment de l’interaction.

Aucun mécanisme vu dans ce code qui ferait :
- `world/serverconfig` > `config/academy`
- ou `datapack` > `config/academy`
pour ce prix précis.

---

## 4) Pourquoi la modif peut ne pas se voir en jeu malgré tout

Vu la chaîne technique, les causes probables ne sont pas "mauvais fichier logique", mais plutôt opérationnelles :

1. **Changement fait sur la mauvaise instance / mauvais dossier serveur**
   - (ex: modification locale, mais serveur de prod lit un autre volume).

2. **Config modifiée après démarrage sans rechargement effectif**
   - Le mod met la config en mémoire dans `ModConfigs.NPC`.
   - Sans redémarrage ou commande de reload, l’ancienne valeur peut rester active.

3. **Commande de reload non exécutée côté serveur**
   - Le mod expose une commande `academy reload` qui relance `ModConfigs.register(false)`.
   - Sans cela, un changement fichier peut ne pas être appliqué immédiatement.

4. **Cas particulier économie**
   - Si `numismatic-overhaul` n’est pas chargé, le chemin de paiement diffère (dans ce code : pas de débit currency NO),
     mais ce n’est pas une source de "prix alternatif".

---

## 5) Conclusion claire

### Source effectivement utilisée pour le prix du Card Grader
La source effective du coût est :
- **`config/academy/npc.json` -> `gradingCurrencyCost`**
- chargée dans `ModConfigs.NPC`
- consommée par `CardGraderNPCEntity` lors de l’interaction.

### Le fichier `config/academy/npc.json` est-il ignoré ?
- **Non**, il est bien lu.
- Ce n’est pas juste un "default" inactif.
- Les valeurs par défaut servent surtout si le fichier est absent.

### Options réalistes pour modifier le prix
1. **Option standard (recommandée)**
   - Modifier `config/academy/npc.json`.
   - Puis **redémarrer** le serveur ou exécuter **`/academy reload`**.

2. **Vérification admin à faire en priorité**
   - Confirmer que le fichier modifié est bien celui de l’instance en cours.
   - Contrôler que la valeur après reload/redémarrage est réellement prise.

3. **Pas d’indice ici d’une source alternative (toml/datapack/NBT) pour ce coût**
   - donc pas besoin de patch code tant que la piste "instance + reload" n’est pas écartée.

---

## 6) Commandes utilisées pour cette analyse

- `jar tf mods/academy-mc1.21.1-v2.2.0+build.532-fabric.jar | rg -n -i "grader|grading|card|npc|shop|currency|price|cost"`
- `javap -classpath mods/academy-mc1.21.1-v2.2.0+build.532-fabric.jar -p -c abeshutt.staracademy.config.NPCConfig`
- `javap -classpath mods/academy-mc1.21.1-v2.2.0+build.532-fabric.jar -p -c abeshutt.staracademy.config.FileConfig`
- `javap -classpath mods/academy-mc1.21.1-v2.2.0+build.532-fabric.jar -p -c abeshutt.staracademy.config.Config`
- `javap -classpath mods/academy-mc1.21.1-v2.2.0+build.532-fabric.jar -p -c abeshutt.staracademy.entity.CardGraderNPCEntity`
- `javap -classpath mods/academy-mc1.21.1-v2.2.0+build.532-fabric.jar -p -c abeshutt.staracademy.world.data.save.CardGradingData`
- `javap -classpath mods/academy-mc1.21.1-v2.2.0+build.532-fabric.jar -p -c abeshutt.staracademy.command.ReloadCommand`
- `find world -maxdepth 4 -type f | rg "academy|serverconfig|defaultconfig|npc\.json|toml"`
- `gzip -dc world/data/academy/card_grading.dat | strings`
