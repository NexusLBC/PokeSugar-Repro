# Comportement code du Spawn Alert

## Handler principal

Le pipeline principal est:

1. `CobblemonSpawnAlerts.initServer()` s’abonne à:
   - `POKEMON_ENTITY_SPAWN`
   - `POKEMON_CAPTURED`
   - `BATTLE_FAINTED`
2. Ces events passent via `IPlatformHelper` / `FabricPlatformHelper`.
3. Les clients affichent via `AlertHandler.alert(...)` (spawn) et `AlertHandler.alertDespawned(...)` (despawn/capture/faint).

## Événements réellement gérés

## `onPokemonSpawn` (spawn)

Chemin:
- Event spawn -> `FabricPlatformHelper.onPokemonSpawned(...)`.
- Le helper fait 2 envois:
  - `PokemonDataPacket` à **tous les joueurs qui trackent déjà l’entité**.
  - `AlertDataPacket` (global) à **tous les autres joueurs** uniquement si `AlertUtil.shouldGlobalAlert(...)` est vrai.

Important:
- Le client traite `PokemonDataPacket` via `AlertHandler.alertClientside(...)`.
- `alertClientside(...)` a un early-return sur `PokemonEntity.method_6139()` (UUID entité), ce qui court-circuite l’alerte locale dans la pratique.
- Résultat: les joueurs qui trackent l’entité au spawn peuvent ne recevoir **aucun message de spawn**, alors qu’ils recevront quand même la disparition plus tard.

## `onPokemonDespawn` (despawn/capture/faint)

Chemin:
- Capturé: `POKEMON_CAPTURED` -> `onPokemonDespawned(..., CAPTURED)`.
- K.O. en PvW: `BATTLE_FAINTED` -> `onPokemonDespawned(..., FAINTED)`.
- `DESPAWNED` est supporté par le format/template, mais n’a pas été trouvé comme event explicite dans `initServer()`.

Différence clé:
- `FabricPlatformHelper.onPokemonDespawned(...)` broadcast le `DespawnDataPacket` à **tous les joueurs du monde**.
- Le filtre final est `pokemonConfig.alertDespawned` côté client.

## Catégories: comment elles sont détectées

- Shiny: `pokemon.getShiny()`
- Legendary: `pokemon.isLegendary()`
- Mythical: `pokemon.isMythical()`
- Ultra Beast: `pokemon.isUltraBeast()`
- Paradox: `pokemon.hasLabels("paradox")`
- Starter: `RarityUtil.isStarter(dexId)` (liste codée en dur)
- Hidden Ability: `HiddenAbilityUtil.hasHiddenAbility(...)`

## Conditions pour envoyer/afficher un message

## Côté serveur (envoi packet)

- Spawn global (`AlertDataPacket`) seulement si `AlertUtil.shouldGlobalAlert(...)` est vrai ET seulement pour joueurs non-trackers.
- Despawn (`DespawnDataPacket`) envoyé à tous les joueurs, mais seulement pour Pokémon déjà dans `globallyAlerted`.

## Côté client (affichage)

- Spawn: `AlertHandler.alert(...)` applique `main.json` + `pokemon.json`:
  - `enabled`, `alwaysAlert`, catégories `alertAll*`, `alertEverything`, IV/EV hunt, levelFilter, HA, dex states.
- Despawn: `AlertHandler.alertDespawned(...)` vérifie surtout `pokemonConfig.alertDespawned`.

## `MAIN_MESSAGE` vs `DISABLED`

- Lu dans `applyDynamicReplacements(...)` via `StatDisplayMode`.
- Impacte uniquement le **format du texte** (fragment visible ou non), pas les conditions de broadcast serveur.

## Ce qui est configurable vs hardcodé

## Configurable

- Flags catégories client (`main.json`) et serveur (`server.json`).
- Affichage des fragments (`pokemon.json -> statDisplayModes`).
- Templates de messages (`message_templates.json`).
- Sons et glow (`pokemon.json`).

## Hardcodé

- Séparation trackers/non-trackers au spawn dans `FabricPlatformHelper`.
- Liste `starter` dans `RarityUtil` (set codé en dur).
- Détection paradox par label "paradox" codée.
- Chemin event capture/faint (et gate `globallyAlerted`) codé.

