# Problem #1 — Pokémon introuvables / récompenses d'arène

## 1) Sources de spawns Cobblemon

- Fichiers de spawn détectés (`**/spawn_pool_world/*.json`): **170** (Academy + CCC + packs spécialisés).
- Espèces différentes trouvées en spawn naturel: **157**.
- Sources clés: `datapacks/Academy/data/cobblemon/spawn_pool_world/`, `datapacks/CCC_1.9.2/data/cobblemon/spawn_pool_world/`, `datapacks/CCC_1.9.2/data/paradox_spawns/spawn_pool_world/`, `datapacks/CCC_1.9.2/data/ultra_beasts_spawns/spawn_pool_world/`.
- Configs spawn: `config/cobblemon/main.json`, `config/cobblemon/spawning/best-spawner-config.json`, `config/academy/pokemon_spawn.json`.
- Matrice détaillée espèce/conditions: `docs/problem-01/spawn_species_matrix.csv`.

## 2) Systèmes de récompenses d'arène

- Définition des arènes: `datapacks/Academy/data/rad-gyms/gyms/*.json` (`reward_loot_tables`).
- Loot tables de récompense: `datapacks/Academy/data/rad-gyms/loot_table/gyms/**/t*_loot_table.json` + `shared_loot_table.json`.
- Pools Pokémon aléatoires: `datapacks/Academy/data/rad-gyms/caches/*.json` (tiers+poids).
- Recettes et composant type: `datapacks/Academy/data/rad-gyms/recipe/cache_*.json` avec `rad-gyms:gym_type_component`.
- Configuration mod serveur: `config/rad-gyms_server.json`.
- Vérification technique: 0 référence de loot table gym cassée, 0 fonction datapack de distribution Pokémon (pipeline géré par le mod).

### Symptômes de bug plausibles

1. Le tirage final dépend du code du mod Rad Gyms (aucun fallback datapack), donc une régression mod/API casse la récompense Pokémon.
2. Les caches utilisent un composant item custom de type (`gym_type_component`) — sensible aux changements de format NBT/composant entre versions.
3. Le fichier `config/rad-gyms_server.json` force de nombreuses exclusions (`ignoredSpecies`/`ignoredForms`), pouvant produire des tirages vides selon l'algorithme interne.

## 3) Listes de Pokémon introuvables

- Base espèces utilisée: `showdown/data/pokedex.js` + espèces datapack Cobblemon.
- Espèces "disponibles serveur" (proxy): **1422**.
- Espèces en spawn naturel: **157**.
- Espèces présentes dans les récompenses aléatoires d'arène: **977**.

| Liste | Taille | Fichier |
|---|---:|---|
| A (sans spawn du tout) | 1265 | `docs/problem-01/list_a_no_natural_spawn.md` |
| B (uniquement en récompenses arène) | 820 | `docs/problem-01/list_b_rewards_only.md` |
| C (orphelins) | 445 | `docs/problem-01/list_c_orphans.md` |

## 4) Templates de spawn suggérés

- Templates générés pour chaque Pokémon de la Liste B: `docs/problem-01/spawn_templates_for_list_b.md`.
- Pour chaque cible: espèce cible, source reward, modèle spawn choisi, fichiers modèle, dimensions et poids de référence.
