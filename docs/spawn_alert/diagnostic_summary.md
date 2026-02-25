# Synthèse diagnostic Spawn Alert

## Comment le système fonctionne actuellement

- Le serveur écoute spawn/capture/défaite (faint PvW) et envoie des packets.
- Pour le spawn:
  - joueurs qui trackent déjà l’entité -> `PokemonDataPacket` (voie locale client),
  - joueurs non-trackers -> `AlertDataPacket` (voie globale) si catégorie autorisée.
- Pour la disparition/capture/défaite:
  - `DespawnDataPacket` est diffusé aux joueurs du monde (avec gate `globallyAlerted`).

## Pourquoi Starter/Shiny donnent "disparition oui, apparition non"

Le problème principal n’est pas la traduction/lang ni les booléens de catégorie.

Le diagnostic pointe surtout:

1. **Architecture spawn en 2 chemins (tracker vs non-tracker)**.
2. **Early-return côté `AlertHandler.alertClientside(...)`** dans le chemin local (trackers).
3. **Despawn broadcast plus large**, donc visible même quand le spawn local n’a pas été affiché.

Effet concret:
- un joueur proche du Pokémon (tracker) peut ne pas voir le message d’apparition,
- mais voir ensuite le message de disparition/capture/défaite.

## Legendary/Paradox vs Starter/Shiny

- Les flags de config existent et sont lus pour les 4 catégories.
- Il n’y a pas un "vrai" pipeline séparé réservé aux légendaires/paradox dans les filtres.
- L’écart perçu vient plutôt de la situation de tracking réseau lors du spawn.

## Pourquoi les modifs précédentes n’ont rien changé

- Changer `DISABLED` / `MAIN_MESSAGE` agit sur le rendu du texte (ou le son), pas sur l’émission réseau du spawn.
- Basculer des true/false de catégorie est bien pris en compte, mais ne corrige pas un court-circuit dans la voie locale de spawn.

## Config vs code

- **Ce qui est config**: catégories activées, templates, fragments du message, sons, glow, hunts IV/EV.
- **Ce qui est code**: séparation trackers/non-trackers au spawn, gating `globallyAlerted`, liste starter hardcodée, détection paradox via label.

Verdict:
- le bug observé est **majoritairement côté code/pipeline** (pas seulement un mauvais réglage de config).

## Recommandations pour le patch correctif suivant

1. Corriger la voie locale spawn (`alertClientside`) pour ne pas early-return de façon bloquante.
2. Aligner la logique d’envoi spawn pour que le joueur tracker reçoive aussi une alerte fiable (ou envoyer `AlertDataPacket` également au tracker).
3. Vérifier la cohérence spawn/despawn/capture/faint par catégorie (Starter/Shiny/Legendary/Paradox) après correction.
4. Garder les configs actuelles de catégories à `true` comme base de test.
5. Optionnel: nettoyer les clés mortes (`showLegendary`) ou documenter explicitement leur non-utilisation.

