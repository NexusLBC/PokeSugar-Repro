# Analyse du prix du Card Grader

## Résumé
- Le prix actuel du **Card Grader** est défini dans un fichier de configuration JSON du module `academy`.
- La valeur trouvée est `10000` sur la clé `gradingCurrencyCost`.
- Aucune définition équivalente n'a été trouvée dans `datapacks/`, ni dans des scripts KubeJS (dossier absent), ni dans `scripts/` (dossier absent), ni dans `serverconfigs/` (dossier absent).

## Résultats de recherche (ciblés Card Grader)

### 1) Fichier principal identifié
- **Emplacement exact** : `config/academy/npc.json`
- **Type de système** : **JSON de configuration** (probablement lu par le mod/plugin `academy` côté serveur)
- **Ligne contenant `10000` (Card Grader)** :
  - `"gradingCurrencyCost": 10000,` (ligne 4)

### 2) Valeur proche dans le même système
- **Emplacement exact** : `config/academy/npc.json`
- **Type de système** : JSON de configuration `academy`
- **Autre ligne contenant `10000`** :
  - `"safariCurrencyCost": 10000` (ligne 6)
- Cette seconde valeur concerne le safari, pas le Card Grader.

## Comment le prix est appliqué
- Le paramètre `gradingCurrencyCost` dans `config/academy/npc.json` agit comme coût monétaire de l'action de grading liée au NPC défini par `cardGraderNpcName`.
- Le même fichier contient aussi `gradingTimeMillis`, ce qui indique que le système de grading combine un **coût** + un **temps de traitement**.

## Classification du système (selon la demande)
- **Prix défini dans un JSON ?** → **Oui** (`config/academy/npc.json`).
- **Script KubeJS ?** → **Non trouvé** (dossier `kubejs/` absent dans ce repo).
- **Shop NPC ?** → **Indirectement NPC** (clé `cardGraderNpcName` + coût dans `npc.json`), mais ce n'est pas un `shop.json` dédié au grader.
- **Plugin économie ?** → **Pas de preuve explicite** du provider économie dans les fichiers inspectés; seulement l'existence d'un coût numérique consommé par le système `academy`.
- **Datapack custom ?** → **Non** pour ce prix précis (aucune occurrence Card Grader + coût 10000 côté datapack).

## Risques potentiels si la valeur est modifiée
1. **Équilibrage économique** : baisser fortement peut rendre le grading trop accessible; augmenter peut bloquer la progression.
2. **Cohérence gameplay** : le coût est lié à un timer (`gradingTimeMillis`) ; changer seulement le prix peut casser le ratio coût/attente attendu.
3. **Effets indirects serveur** : si d'autres systèmes (UI, messages, quêtes, docs) supposent 10000, des incohérences peuvent apparaître.
4. **Conflit avec autres coûts `academy`** : d'autres coûts existent (ex. `safariCurrencyCost`) dans le même fichier; modifier un seul paramètre peut désaligner l'économie interne.

## Commandes utilisées pour l'analyse
- `rg -n "10000" datapacks config kubejs scripts data serverconfigs -g "*.json" -g "*.js" -g "*.toml" -g "*.yml" -g "*.mcfunction"`
- `rg -n -i "grader|card_grader|cardgrader|\bgrade\b|grading|npc shop|economy|cost|price" datapacks config kubejs scripts data serverconfigs -g "*.json" -g "*.js" -g "*.toml" -g "*.yml" -g "*.mcfunction"`
- `rg -n -i "card_grader|cardgrader|card grader|gradingCurrencyCost|grader|grading|economy|npc shop" -g "*.json" -g "*.js" -g "*.toml" -g "*.yml" -g "*.mcfunction"`
- `nl -ba config/academy/npc.json | sed -n '1,40p'`
