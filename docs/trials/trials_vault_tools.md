# Outils disponibles pour reset des vaults

## Vérification dans ce pack

- `kubejs/` absent.
- Aucun indice d'installation Carpet/Carpet Extra dans les mods traités (`.fabric/processedMods`).
- Pas de système existant de scan global des blocs chargé côté datapack.

## Conséquence pratique

Le patch est conçu en **vanilla datapack + commandes**:
- `data remove block`
- `execute ... at ...`
- tag `minecraft:load`

## Limites techniques vanilla

1. Les commandes ne modifient que les chunks chargés.
2. Vanilla ne fournit pas de scan global "trouver tous les `minecraft:vault` du monde" sans index préalable.
3. Un index persistant (ici: entités `marker` taggées) est nécessaire pour un reset fiable.
