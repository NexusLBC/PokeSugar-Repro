# Comparaison par catégorie (Legendary/Paradox vs Starter/Shiny)

Légende:
- "Oui (conditionnel)" = supporté par code mais dépend de flags/config/chemin réseau.
- "Partiel" = l’event existe mais pas pour tous les cas (ex: faint seulement PvW).

| Catégorie  | Alerte apparition ? | Alerte disparition ? | Alerte capture ? | Alerte défaite ? | Config active (repo) | Notes |
|---|---|---|---|---|---|---|
| Legendary | Oui (conditionnel) | Oui (conditionnel) | Oui (conditionnel) | Partiel (PvW) | true (client+server) | Détection directe `isLegendary()`. |
| Paradox | Oui (conditionnel) | Oui (conditionnel) | Oui (conditionnel) | Partiel (PvW) | true (client+server) | Détection via label `paradox`. |
| Starter | Oui (conditionnel) | Oui (conditionnel) | Oui (conditionnel) | Partiel (PvW) | true (client+server) | Détection via `RarityUtil.isStarter(dexId)` (liste hardcodée). |
| Shiny | Oui (conditionnel) | Oui (conditionnel) | Oui (conditionnel) | Partiel (PvW) | true (client+server) | Détection via `getShiny()`. |

## Pourquoi Legendary/Paradox semblent “mieux fonctionner”

Le code n’a pas de chemin entièrement séparé pour Legendary/Paradox versus Starter/Shiny dans la logique de filtrage: les catégories sont traitées de façon similaire (booléens serveur + client).

La différence observée en jeu vient surtout de la topologie réseau du spawn:

- au spawn, les joueurs trackers reçoivent `PokemonDataPacket` (local path),
- les non-trackers reçoivent `AlertDataPacket` (global path).

Or le path local est fragilisé par un early-return dans `alertClientside(...)`, ce qui peut supprimer le message de spawn du joueur proche de l’entité.

## Point bloquant principal pour Starter/Shiny

Le problème n’est pas un flag starter/shiny absent:
- `alertStarters` / `alertShinies` (serveur) sont bien lus.
- `alertAllStarter` / `alertAllShinies` (client) sont bien lus.

Le blocage principal est la combinaison:
1) séparation tracker/non-tracker au spawn,
2) early-return dans la voie locale client (`alertClientside`),
3) despawn broadcasté plus largement (donc visible),
ce qui crée l’impression "disparition oui, apparition non".

