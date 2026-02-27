# Trials Vault NBT (modpack PokeSugar)

## Méthode d'inspection utilisée

1. Extraction du jar serveur vanilla embarqué (`server-1.21.1.jar`) depuis `server.jar`.
2. Lecture des structures vanilla Trial Chambers:
   - `data/minecraft/structure/trial_chambers/reward/vault.nbt`
   - `data/minecraft/structure/trial_chambers/reward/ominous_vault.nbt`
3. Inspection des codecs internes du serveur (classes obfusquées `dsn` et `dso`) pour récupérer les clés NBT réellement sérialisées pour `minecraft:vault`.

> Note: le dépôt ne contient pas de `world/region/*.mca`, donc aucun snapshot NBT "vault déjà utilisé" n'est lisible offline ici.

## NBT complet observé - vault normal (structure vanilla)

```snbt
{
  id:"minecraft:vault",
  config:{
    key_item:{count:1,id:"minecraft:trial_key"},
    loot_table:"minecraft:chests/trial_chambers/reward"
  }
}
```

## NBT complet observé - vault ominous (structure vanilla)

```snbt
{
  id:"minecraft:vault",
  config:{
    key_item:{count:1,id:"minecraft:ominous_trial_key"},
    loot_table:"minecraft:chests/trial_chambers/reward_ominous"
  }
}
```

## Clés runtime identifiées dans le code serveur

### `server_data`
- `rewarded_players` (set UUID) -> historique des joueurs déjà récompensés.
- `state_updating_resumes_at` (long) -> timer interne de reprise/rafraîchissement d'état.
- `items_to_eject` (list) -> file d'items à éjecter.
- `total_ejections_needed` (int) -> nombre d'éjections nécessaires pour terminer le cycle.

### `shared_data`
- `display_item` (item stack) -> item visuel affiché.
- `connected_players` (set UUID) -> joueurs actuellement connectés/considérés par le vault.
- `connected_particles_range` (double) -> portée visuelle des particules.

## Différence normal vs ominous

Le type de bloc est identique (`minecraft:vault`) ; la différence est portée par `config`:
- `config.key_item` (`trial_key` vs `ominous_trial_key`)
- `config.loot_table` (table normale vs ominous)

Le reset ne doit **pas** toucher `config`.
