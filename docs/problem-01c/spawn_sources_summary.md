# Synthèse des sources de spawns (problem-01c)

## Méthodologie
- Scan datapacks `datapacks/**/data/**/spawn_pool_world/*.json` (champs `species` et `pokemon`).
- Scan JARs `mods/*.jar` sur `data/**/spawn_pool_world/*.json` (champs `species` et `pokemon`).
- Scan scripts (KubeJS/CraftTweaker) par regex `cobblemon:[a-z0-9_]+` sur les lignes contenant `spawn`.
- Scan configs Cobblemon par regex `cobblemon:[a-z0-9_]+` sur les lignes contenant `spawn`.
- Relecture des récompenses depuis `caches/*.json` et `loot_table/gyms/**/t*_loot_table.json` (+ `shared_loot_table.json` si présent).

## Volumétrie
- S_spawns_datapacks: **157**
- S_spawns_jars: **210**
- S_spawns_scripts: **0**
- S_spawns_configs: **0**
- S_spawns_all_sources: **345**
- S_caches: **977**
- S_both_all_sources: **288**
- S_caches_only_correct: **689**

## Exemples (cas utilisateur)
- `cobblemon:abra` → sources spawn: **jar**, récompense cache: **oui**.
- `cobblemon:timburr` → sources spawn: **aucune**, récompense cache: **oui**.

## Interprétation
- Datapack/JAR = déclarations explicites de spawn (fiables).
- Script/Config = indices de logique dynamique, non preuve absolue sans exécution.
