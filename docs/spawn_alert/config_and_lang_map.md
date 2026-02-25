# Cartographie configs + lang (Spawn Alert)

## Configs

## `config/cobblemon-spawn-alerts/main.json`

Rôle: filtres **client** de déclenchement de message d'apparition (spawn).

Clés importantes (actuel):

- `alertAllShinies: true`
- `alertAllLegendaries: true`
- `alertAllMythicals: true`
- `alertAllUltraBeasts: true`
- `alertAllParadox: true`
- `alertAllStarter: true`
- `alertAllHA: false`
- `alertAllNotInDex: false`
- `alertAllUncaught: false`
- `alertEverything: false`
- `ivHunting.enabled: false`
- `evHunting.enabled: false`
- `levelFilter.enabled: false`

Utilisation réelle dans le code:
- **Utilisées** dans `AlertHandler.alert(...)` pour décider si un message d’apparition est affiché côté client.
- Les booléens de catégories sont lus explicitement (shiny, legendary, mythical, ultrabeast, paradox, starter, HA, not-in-dex, uncaught, everything).

---

## `config/cobblemon-spawn-alerts/server.json`

Rôle: filtres **serveur** de broadcast réseau (quels packets envoyer aux clients).

Clés importantes (actuel):

- `enableSpawnCommandAlerts: true`
- `alertShinies: true`
- `alertLegendaries: true`
- `alertMythicals: true`
- `alertUltraBeasts: true`
- `alertParadox: true`
- `alertStarters: true`
- `alertHiddenAbility: false`
- `broadcastIVs: false`
- `broadcastEVs: false`
- `broadcastNature: false`
- `broadcastAbility: false`

Utilisation réelle dans le code:
- **Utilisées** dans `AlertUtil.shouldGlobalAlert(...)`, `CobblemonSpawnAlerts.createAlertData(...)`, `CobblemonSpawnAlerts.createDespawnData(...)`.
- Les flags `broadcast*` contrôlent la quantité d'info envoyée (IV/EV/Nature/Ability) dans les packets de spawn.

---

## `config/cobblemon-spawn-alerts/pokemon.json`

Rôle: profil client par Pokémon / groupe de Pokémon.

Entrée active actuelle: `default (You can modify anything BELOW this, but dont delete it!)`.

Clés importantes:

- `enabled: true`
- `alwaysAlert: true`
- `alertShiny: true`
- `alertHiddenAbility: true`
- `alertDespawned: true`
- `showLegendary: true`
- `statDisplayModes`: `level/ivs/evs/nature/ability/gender/coordinates/biome/nearestPlayer`
- `customAlertMessage: "MAIN_MESSAGE"`
- `sounds`: map de catégories (`shiny`, `legendary`, `mythical`, `ultrabeast`, `paradox`, `starter`, `unregistered`, `uncaught`, `ivs`, `evs`)
- `customAlertSound`
- `autoGlow`
- `journeyMap.*`

Utilisation réelle dans le code:
- **Utilisées**:
  - `enabled`, `alwaysAlert`, `alertShiny`, `alertHiddenAbility`, `alertDespawned`
  - `statDisplayModes` (pilotage d’affichage MAIN_MESSAGE/HOVER/DISABLED)
  - `customAlertMessage` (si non vide, remplace le template principal)
  - `sounds` (sons conditionnels par cause)
  - `autoGlow`, `journeyMap.*`
- **Clé non utilisée (morte)**:
  - `showLegendary` n’est pas lue dans `AlertHandler`.

---

## `config/cobblemon-spawn-alerts/message_templates.json`

Rôle: mapping de templates vers clés de langue.

Clés structurantes:
- Message principal: `fullSpawnMessage`, `despawnMessage`
- Raisons de disparition: `despawnReason_Despawned`, `despawnReason_Captured`, `despawnReason_Fainted`
- Fragments injectés: `shiny`, `hidden_ability`, `level`, `ivs`, `evs`, `nature`, `ability`, `gender`, `coords`, `biome`, `nearest_player`, `legendary`, `mythical`, `ultrabeast`, `paradox`, etc.

Utilisation réelle:
- **Toutes utilisées** dans `AlertHandler.applyDynamicReplacements(...)` + `AlertHandler.alertDespawned(...)`.

---

## Lang

## Fichier embarqué

- `mods/cobblemon_spawn_alerts-fabric-1.11.2.jar!/assets/cobblemon_spawn_alerts/lang/en_us.json`
- Pas de `fr_fr.json` embarqué dans ce JAR.

## Keys de langue utilisées

Toutes les clés référencées par `message_templates.json` sont des entrées `cobblemon-spawn-alerts.*` (ex: `default_spawn_message`, `default_despawn_message`, `despawn_reason_*`, `legendary`, `paradox`, `shiny`, etc.).

## Sens de `MAIN_MESSAGE` vs `DISABLED`

`MAIN_MESSAGE` / `HOVER` / `DISABLED` ne sont **pas** des clés de langue.
Ce sont des valeurs de l’enum `StatDisplayMode`.

- `MAIN_MESSAGE`: injecte le fragment dans le texte principal.
- `HOVER`: injecte dans les hover texts.
- `DISABLED`: n’injecte pas ce fragment.

Donc remplacer `DISABLED` par `MAIN_MESSAGE` agit sur **la composition du texte**, pas sur la logique d’émission réseau serveur.
