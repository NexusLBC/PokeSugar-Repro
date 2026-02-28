# Problème #5 — Spawn Alerts (Légendaire / Paradox / Starters / Shiny)

## 1) Résumé du problème (constaté dans le code/config)

- Le mod qui gère les annonces de spawn/capture/faint/despawn est **Cobblemon Spawn Alerts** (`cobblemon_spawn_alerts`, v`1.11.2`).
- Les fichiers de config actuellement présents (`main.json`, `server.json`, `pokemon.json`) ont tous les flags rares activés (`Shiny`, `Paradox`, `Starter`, `Legendary`, etc.).
- La logique de **spawn** et la logique de **despawn/capture/faint** passent par des chemins réseau différents :
  - spawn proche: paquet `PokemonDataPacket` vers joueurs qui trackent l’entité,
  - broadcast global rare: paquet `AlertDataPacket` vers joueurs non-trackers,
  - disparition/capture/faint: paquet `DespawnDataPacket` envoyé à tous les joueurs du monde.
- Cause probable côté architecture (pas un simple flag ici): la différence de canal (tracking vs global) + des filtres client/serveur différents peut laisser un cas où le spawn shiny/starter n’est pas annoncé alors que le despawn/capture/faint est bien annoncé ensuite.

---

## 2) Inventaire des mods d’alerte

| Mod | Rôle principal | Événements gérés | Types concernés | Config principale |
|---|---|---|---|---|
| `cobblemon_spawn_alerts` `1.11.2` (`modid`: `cobblemon_spawn_alerts`) | Alertes Cobblemon (spawn + despawn/capture/faint) | spawn, capture, faint (vaincu), despawn | shiny, legendary, mythical, ultrabeast, paradox, starter, hidden ability (+ filtres dex/IV/EV) | `config/cobblemon-spawn-alerts/main.json`, `server.json`, `pokemon.json`, `message_templates.json` |
| `cobblemontrialsedition` `1.1.0` (`modid`: `cobblemontrialsedition`) | Remplacement spawners/trials Cobblemon | pas de couche d’annonce détectée dans ses configs locales | N/A | `config/cobblemontrialsedition.toml` (spawner/trial, pas annonce) |

### Notes d’inventaire
- Aucun autre mod du dossier `mods/` n’expose (dans ses métadonnées/configs locales) une couche explicite de broadcast spawn/capture/faint/despawn Cobblemon.
- Les événements d’annonce observés proviennent donc prioritairement de `cobblemon_spawn_alerts`.

---

## 3) Analyse des configs

## 3.1 `config/cobblemon-spawn-alerts/main.json` (client)

Flags globaux relevés :

- `alertAllShinies: true`
- `alertAllLegendaries: true`
- `alertAllMythicals: true`
- `alertAllUltraBeasts: true`
- `alertAllParadox: true`
- `alertAllStarter: true`
- `alertAllHA: false`
- `alertEverything: false`

Constat : **pas de désactivation flagrante** de Shiny/Starter côté `main.json`.

## 3.2 `config/cobblemon-spawn-alerts/server.json` (serveur)

Flags serveur relevés :

- `enableSpawnCommandAlerts: true`
- `alertShinies: true`
- `alertLegendaries: true`
- `alertMythicals: true`
- `alertUltraBeasts: true`
- `alertParadox: true`
- `alertStarters: true`
- `alertHiddenAbility: false`

Constat : **pas de désactivation flagrante** de Shiny/Starter côté serveur non plus.

## 3.3 `config/cobblemon-spawn-alerts/pokemon.json` (règles par Pokémon)

Config par défaut (seule entrée active observée):

- `enabled: true`
- `alwaysAlert: true`
- `alertShiny: true`
- `alertDespawned: true`
- `showLegendary: true`

Constat :
- Aucune override espèce/catégorie spécifique Starter/Shiny détectée dans le fichier actuel.
- Le socle actuel devrait autoriser les alerts spawn + despawn pour ces catégories.

## 3.4 Différences légendaire/paradox vs shiny/starter au niveau config

- **Aucune différence de valeur** détectée dans les flags principaux: tous à `true` pour Legendary/Paradox/Shiny/Starter.
- La différence de comportement rapportée ne semble donc pas due à un simple booléen `false` dans les fichiers de config présents.

---

## 4) Logique de code pour les événements (pseudo-code)

## 4.1 Pipeline spawn

1. Event `POKEMON_ENTITY_SPAWN` → `onPokemonSpawned(entity)`.
2. Après délai (~0.5s), serveur envoie `PokemonDataPacket` aux joueurs qui **trackent** l’entité.
3. Le client recevant `PokemonDataPacket` reconstruit les données puis appelle `AlertHandler.alertClientside(...)`.
4. En parallèle, serveur évalue `AlertUtil.shouldGlobalAlert(entity)` (flags serveur: shiny/legendary/.../starter).
5. Si `true`:
   - UUID ajouté à `globallyAlerted`.
   - envoi `AlertDataPacket` à tous les joueurs du monde **non déjà trackers** de l’entité.

Pseudo-code simplifié :

```text
on spawn(entity):
  trackers = PlayerLookup.tracking(entity)
  send PokemonDataPacket to trackers

  if shouldGlobalAlert(entity):
    globallyAlerted.add(entity.uuid)
    for player in worldPlayers:
      if player not in trackers:
        send AlertDataPacket(player)
```

## 4.2 Condition catégorie rare (serveur)

`AlertUtil.shouldGlobalAlert` (serveur) est vrai si au moins un des cas est vrai :

- `(pokemon.shiny && server.alertShinies)`
- `(pokemon.legendary && server.alertLegendaries)`
- `(pokemon.mythical && server.alertMythicals)`
- `(pokemon.ultrabeast && server.alertUltraBeasts)`
- `(pokemon.hasLabel("paradox") && server.alertParadox)`
- `(RarityUtil.isStarter(dexId) && server.alertStarters)`
- `(hiddenAbility && server.alertHiddenAbility)`

## 4.3 Pipeline despawn / captured / fainted

1. `POKEMON_CAPTURED` et `BATTLE_FAINTED` sont enregistrés au `initServer()`.
2. Ces events appellent `onPokemonDespawned(...)` avec raison (`CAPTURED` / `FAINTED`).
3. Côté serveur, `createDespawnData(...)` recalcule la rareté avec **les mêmes flags serveur** (shiny/legendary/.../starter).
4. `DespawnDataPacket` est envoyé aux joueurs du monde.
5. Côté client, `AlertHandler.alertDespawned(...)` affiche le message selon `pokemonConfig.alertDespawned`.

## 4.4 Divergences importantes spawn vs despawn

- Spawn repose sur **2 canaux** (tracking local + global non-trackers).
- Despawn/capture/faint suit un canal plus direct (packet despawn dédié, puis rendu client).
- Le fait que despawn/capture/faint marche pendant que spawn échoue est **cohérent** avec une divergence de pipeline, même avec les mêmes flags de catégorie.

---

## 5) Hypothèses de cause du bug

1. **Divergence tracking/global sur spawn**
   - Le joueur attendu n’est ni correctement servi par la branche tracking (`PokemonDataPacket`) ni par la branche globale (`AlertDataPacket`, exclut explicitement les trackers).
   - Cela peut créer un “trou” ponctuel uniquement sur spawn.

2. **Dépendance client-side des alertes spawn locales**
   - Les trackers reçoivent `PokemonDataPacket` puis filtrent client-side (`main.json` + `pokemon.json`).
   - Si le fichier client réel d’un joueur diffère du repo (ou est non sync), Shiny/Starter peuvent être filtrés côté client malgré un serveur correct.

3. **Classification Starter dépendante d’une liste statique (`RarityUtil.isStarter`)**
   - Si certains starters/formes attendus ne sont pas dans l’ensemble statique (ou dex/forme custom), le test starter serveur peut échouer.
   - En revanche, despawn peut rester visible par `alwaysAlert`/autres conditions de rendu.

4. **Priorité de filtrage dans `AlertHandler.alert(...)`**
   - Le rendu spawn combine plusieurs flags (`alwaysAlert`, `alertShiny`, `alertAllShinies`, etc.) et états dex/capture.
   - Une combinaison de conditions peut faire rater le spawn shiny alors que le despawn passe via `alertDespawned`.

---

## 6) Pistes de correction (haut niveau, sans patch)

1. **Unifier le chemin de diffusion spawn**
   - Fichiers/fonctions: `FabricPlatformHelper.onPokemonSpawned`, `AlertUtil.shouldGlobalAlert`, `PacketHandlers`.
   - Option simple: envoyer aussi `AlertDataPacket` aux trackers (ou fallback explicite) pour éviter le trou tracking/non-tracking.
   - Précaution: éviter les doublons (UUID cache côté client déjà présent, mais à valider).

2. **Centraliser la décision “doit-on alerter”**
   - Fichiers/fonctions: `AlertUtil.shouldGlobalAlert`, `AlertHandler.alert`, config managers.
   - Option simple: factoriser la logique rareté/flags entre spawn et despawn pour réduire les divergences.

3. **Sécuriser Starter/Shiny avec tests de régression**
   - Vérifier que Legendary/Paradox (déjà OK) restent inchangés.
   - Cas minimaux: spawn shiny tracker, spawn shiny non-tracker, spawn starter tracker/non-tracker, puis capture/faint/despawn.

4. **Valider la réalité des configs clients**
   - Le serveur n’impose pas `main.json` client.
   - Recommander un contrôle des configs client des joueurs concernés avant patch code.

---

## Conclusion opérationnelle

- Dans l’état du repo, le problème ne ressemble **pas** à un simple flag `false` dans `server.json/main.json/pokemon.json`.
- Le point le plus suspect est la **différence de pipeline spawn** (tracking vs global) + filtrage client, alors que despawn/capture/faint utilisent un flux plus direct et homogène.
