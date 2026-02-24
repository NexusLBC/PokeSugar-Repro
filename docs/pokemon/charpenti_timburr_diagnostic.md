# Diagnostic Charpenti / Timburr

## Références brutes à Charpenti / Timburr

- `datapacks/Academy/data/rad-gyms/caches/fighting.json` – cache de récompense d’arène (pool `uncommon` du type Fighting).
- `showdown/config/formats.js` – fichier Showdown (format de battle), sans lien direct avec les spawns/récompenses serveur.

## Spawns Cobblemon trouvés

> Aucun spawn naturel Cobblemon trouvé pour Charpenti/Timburr dans les fichiers de spawn pool.  
> Hypothèse : Charpenti est censé être obtenu uniquement via d’autres mécaniques (ex. récompenses d’arène).

## Charpenti/Timburr dans les récompenses d’arène

- Timburr apparaît dans `datapacks/Academy/data/rad-gyms/caches/fighting.json`, section `uncommon`, avec un poids de `300`.
- Le format utilisé est `timburr` (sans namespace), cohérent avec les autres entrées du cache (`machoke`, `gurdurr`, etc.).
- Cette liste est consommée indirectement via les items `rad-gyms:cache_*` donnés par les loot tables de gym; la logique de tirage final est gérée côté mod `rad-gyms` (pas de `.mcfunction` visible dans le datapack).

### Hypothèses A/B/C/D (lecture du code)

- **A (fonction reward non déclenchée)** : plausible mais non prouvable via datapack seul (déclenchement géré côté mod).
- **B (sous-pool jamais atteinte)** : peu probable pour Timburr, car la pool `uncommon` est explicitement distribuée dans les tiers T3–T5 des loot tables de gym.
- **C (ID faux)** : peu probable ici (`timburr` suit le format attendu dans les caches).
- **D (Pokémon choisi mais non attribué)** : plausible si le problème est dans l’implémentation runtime du mod (hors datapack).

### Mini-conclusion

- Côté datapack serveur, Timburr est bien listé dans les récompenses d’arène (cache Fighting uncommon) mais absent des spawn pools Cobblemon versionnés dans ce repo.
- Donc, **dans l’état actuel de ce repository**, la voie légitime visible pour obtenir Timburr est le système de cache/récompense d’arène `rad-gyms`.
