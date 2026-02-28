# Fichiers pertinents — Problème #5 Spawn Alerts

## Configs serveur/client

- `config/cobblemon-spawn-alerts/server.json` — Flags serveur des catégories broadcastées au spawn/despawn (`alertShinies`, `alertStarters`, etc.).
- `config/cobblemon-spawn-alerts/main.json` — Filtres client des alertes spawn (`alertAllShinies`, `alertAllParadox`, `alertAllStarter`, etc.).
- `config/cobblemon-spawn-alerts/pokemon.json` — Règles par Pokémon/catégorie (`alwaysAlert`, `alertShiny`, `alertDespawned`).
- `config/cobblemon-spawn-alerts/message_templates.json` — Templates de messages spawn/despawn.
- `config/cobblemontrialsedition.toml` — Config du mod Trials Edition (spawner/trials), vérifiée pour exclure une couche d’annonce concurrente.

## Mod principal (JAR) — Cobblemon Spawn Alerts

- `mods/cobblemon_spawn_alerts-fabric-1.11.2.jar!/fabric.mod.json` — Métadonnées mod (`modid`, version, description).
- `mods/cobblemon_spawn_alerts-fabric-1.11.2.jar!/io/github/stainlessstasis/core/CobblemonSpawnAlerts.class` — Enregistrement des events Cobblemon (spawn/capture/faint) et création packets.
- `mods/cobblemon_spawn_alerts-fabric-1.11.2.jar!/io/github/stainlessstasis/FabricPlatformHelper.class` — Routage serveur des packets spawn/despawn vers joueurs (tracking vs global).
- `mods/cobblemon_spawn_alerts-fabric-1.11.2.jar!/io/github/stainlessstasis/util/AlertUtil.class` — Condition serveur `shouldGlobalAlert` (shiny/legendary/paradox/starter/HA).
- `mods/cobblemon_spawn_alerts-fabric-1.11.2.jar!/io/github/stainlessstasis/util/RarityUtil.class` — Classification statique des catégories (dont starters).
- `mods/cobblemon_spawn_alerts-fabric-1.11.2.jar!/io/github/stainlessstasis/alert/AlertHandler.class` — Filtrage/affichage client des alertes spawn et despawn.
- `mods/cobblemon_spawn_alerts-fabric-1.11.2.jar!/io/github/stainlessstasis/network/PacketHandlers.class` — Handlers client des packets (`PokemonDataPacket`, `AlertDataPacket`, `DespawnDataPacket`).
- `mods/cobblemon_spawn_alerts-fabric-1.11.2.jar!/io/github/stainlessstasis/config/AbstractConfigManager.class` — Résolution du dossier config `cobblemon-spawn-alerts`.
- `mods/cobblemon_spawn_alerts-fabric-1.11.2.jar!/io/github/stainlessstasis/config/ClientConfigManager.class` — Chargement `main.json`, `pokemon.json`, `message_templates.json`.
- `mods/cobblemon_spawn_alerts-fabric-1.11.2.jar!/io/github/stainlessstasis/config/CommonConfigManager.class` — Chargement `server.json`.

## Autres mods vérifiés pour inventaire

- `mods/CobblemonTrialsEdition-fabric-1.1.0.jar!/fabric.mod.json` — Mod orienté spawners/trials; aucune logique d’alert spawn/capture/faint identifiée dans la config locale.

## Datapacks / scripts

- `datapacks/` (scan global) — aucun script/règle identifié modifiant explicitement les events d’annonces spawn de `cobblemon_spawn_alerts`.
- `kubejs/` — dossier absent dans ce repo (aucun override KubeJS détecté pour ces alertes).
