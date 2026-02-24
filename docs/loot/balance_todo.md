# TODO équilibrage loot (préparation)

## Priorités proposées
1. Fossiles custom gym (`academy:basic_gym/t0`)
   - Tables concernées: `academy:basic_gym/t0`.
   - Idée: augmenter légèrement `academy:shiny_fossil` (2→3) ou réduire `empty` (45→42) pour buff contrôlé.

2. Fossiles standards Cobblemon
   - Tables concernées: `academy:cobblemon/fossils` + toutes les tables appelantes.
   - Idée: garder l'uniformité interne mais augmenter les points d'entrée (rolls/chances des tables parentes).

3. Fossiles HA / max IV
   - Tables concernées: `academy:basic_gym/t0` (et futures tables marchands si ajoutées).
   - Idée: HA légèrement plus rare que shiny, max IV comme jackpot.

4. Radiant fossils (quand IDs connus)
   - Tables concernées: à déterminer, + mapping `data/cobblemon/fossils/*.json`.
   - Idée: ajouter des sources dédiées (marchand/event) plutôt qu'un drop massif en loot général.
