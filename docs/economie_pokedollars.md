# Analyse de l’origine des **PokeDollars**

## Conclusion rapide
La monnaie **PokeDollars** du serveur provient du mod **`cobblemon-economy`** (fichier `mods/cobblemon-economy-0.0.13.jar`) et est gérée via une base SQLite côté monde :

- `world/config/cobblemon-economy/economy.db`
- table `balances`, colonne `balance`

Ce n’est **pas** un scoreboard vanilla, **pas** un item custom de type “pièce” dans les datapacks, et **pas** une capability Forge (le serveur est ici en environnement Fabric pour ce mod).

---

## 1) Origine exacte

### Mod responsable
Le système est porté par la configuration de `cobblemon-economy` présente dans le monde :

- `world/config/cobblemon-economy/config.json`
- `world/config/cobblemon-economy/economy.db`
- `world/config/cobblemon-economy/milestone.json`
- `world/config/cobblemon-economy/transactions.log`

### Paramètres de gain de monnaie (POKE)
Les gains de base sont déclarés dans `config.json` :

- `startingBalance`
- `battleVictoryReward`
- `captureReward`
- `newDiscoveryReward`
- multiplicateurs shiny/legendary/paradox

Les shops utilisent explicitement la devise `"POKE"` (PokeDollars) et, pour certains, `"PCO"` (seconde devise).  
Exemples : shop `karine` en `POKE`, shops `black_market`/`battle_rewards` en `PCO`.

---

## 2) Type de stockage

## Stockage principal
Stockage en **SQLite** dans `world/config/cobblemon-economy/economy.db`.

Schéma observé :

- `balances(uuid TEXT PRIMARY KEY, balance TEXT NOT NULL, pco TEXT NOT NULL, username TEXT)`
- `purchase_limits(...)`
- `capture_counts(...)`
- `capture_milestones(...)`

Donc :

- **PokeDollars** = colonne `balance`
- **PCO** = colonne `pco`

### Portée du stockage
Stockage **par joueur** (clé `uuid`), pas global.

---

## 3) Vérification scoreboard / item / capability / Cobblemon

## Scoreboard
- Aucune commande `scoreboard objectives add`/`players add` liée à pokedollars trouvée dans datapacks/config/scripts.
- `world/data/scoreboard.dat` contient des objectifs, mais rien lié à `pokedollar`, `money`, `currency`, `bal` ou `pco`.

**Conclusion :** PokeDollars n’est pas piloté par un scoreboard vanilla.

## Item custom
- Pas d’item “pokedollar” (JSON/datapack) servant de monnaie.
- Les achats/ventes passent par les shops du mod (prix numériques), pas par consommation d’un item monnaie.

## Capability Forge
- Aucun indice de capability Forge pour cette monnaie dans ce repo.
- Le système observé est un backend SQLite propre au mod `cobblemon-economy`.

## Lien Cobblemon
- Le mod est explicitement orienté Cobblemon (shops, récompenses capture/victoire/découverte, milestones Pokédex).
- `milestone.json` définit des récompenses monétaires de paliers de captures.

---

## 4) Si c’était un scoreboard : création / modification / usages

Après analyse, ce n’est **pas** un scoreboard, donc :

- **Création d’objectif** : non applicable
- **Modification via commandes scoreboard** : non applicable
- **Commandes utilisatrices** : non applicable

À la place, les opérations sont des écritures SQL dans `economy.db`.

---

## 5) Fichiers impliqués

### Noyau économique (actif)
- `world/config/cobblemon-economy/config.json` (règles, rewards, devises shops)
- `world/config/cobblemon-economy/economy.db` (soldes joueurs, limites, compteurs)
- `world/config/cobblemon-economy/milestone.json` (récompenses milestones)
- `world/config/cobblemon-economy/transactions.log` (historique achats)
- `mods/cobblemon-economy-0.0.13.jar` (implémentation)

### Fichiers “money/currency” trouvés mais non source des PokeDollars
- `config/numismatic-overhaul.json5` (autre système monétaire moddé, séparé)
- `datapacks/Academy/data/flan/lang/*.json` (texte UI/locale, pas moteur de stockage PokeDollars)
- `config/quests/...` (`"money"` dans exemples API, pas stockage de la devise Cobblemon Economy)

---

## 6) Mécanique complète (synthèse)

1. Le serveur charge `cobblemon-economy` et sa config monde `world/config/cobblemon-economy/config.json`.
2. Les joueurs ont une entrée par `uuid` dans `economy.db` (`balances.balance` pour PokeDollars).
3. Les événements de jeu Cobblemon (capture, victoire, découverte) créditent la balance selon les valeurs de config.
4. Les achats shops débitent `balance` (si shop en `POKE`) ou `pco` (si shop en `PCO`).
5. Les milestones de capture accordent des bonus selon `milestone.json`.
6. Les transactions d’achats sont journalisées dans `transactions.log`.

---

## 7) Risques à modifier ce système

### Risques techniques
- Modifier `economy.db` à chaud peut corrompre cohérence soldes/limites si le serveur tourne.
- Changer manuellement types/format de `balance` (stocké en texte décimal) peut casser les lectures du mod.
- Changer des IDs de shops ou devises (`POKE`/`PCO`) peut rendre des PNJ/shops incohérents.

### Risques gameplay
- Modifier `battleVictoryReward`, `captureReward`, multiplicateurs ou milestones peut créer inflation/déséquilibre boutique.
- Réduire trop les gains peut bloquer progression économique.
- Basculer des shops de `POKE` vers `PCO` change fortement la boucle de progression joueur.

### Recommandations avant changement
- Sauvegarde complète de `world/config/cobblemon-economy/`.
- Modifs en maintenance serveur arrêté.
- Test sur copie de monde (achat, récompense capture/victoire, lecture `/bal`, shop limits).
