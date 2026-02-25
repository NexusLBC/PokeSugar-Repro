# Sources du système Spawn Alert

## 1) Mod principal identifié

- **Mod**: `cobblemon_spawn_alerts-fabric-1.11.2.jar`.
- **Chemin**: `mods/cobblemon_spawn_alerts-fabric-1.11.2.jar`.
- **Namespace assets**: `assets/cobblemon_spawn_alerts/...`.
- **Lang embarquée**: `assets/cobblemon_spawn_alerts/lang/en_us.json`.

## 2) Classes JAR liées à l’alerte

Les classes suivantes dans le JAR portent explicitement la logique d’alerte :

- `io.github.stainlessstasis.alert.AlertHandler`
- `io.github.stainlessstasis.core.CobblemonSpawnAlerts`
- `io.github.stainlessstasis.util.AlertUtil`
- `io.github.stainlessstasis.FabricPlatformHelper`
- `io.github.stainlessstasis.network.PacketHandlers`
- `io.github.stainlessstasis.network.AlertDataPacket`
- `io.github.stainlessstasis.network.DespawnDataPacket`
- `io.github.stainlessstasis.network.PokemonDataPacket`

## 3) Datapacks / namespaces datapack liés au Spawn Alert

- **Aucun namespace datapack dédié au Spawn Alert trouvé** (`data/<namespace>/...` côté datapack).
- La logique Spawn Alert de ce modpack est **portée par le mod Java + ses fichiers de config**, pas par un datapack dédié.

## 4) Autres mods candidats (recherche par nom)

- Recherche dans `mods/` sur `alert|spawn|notify|radar|legend` :
  - seul résultat pertinent : `cobblemon_spawn_alerts-fabric-1.11.2.jar`.
