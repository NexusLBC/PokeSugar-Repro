# Revue des modifications déjà tentées (MAIN_MESSAGE / DISABLED / true/false)

Cette revue compare l’état actuel des configs avec les valeurs par défaut de `createDefault()` dans le mod.

## Modifications détectées dans `pokemon.json`

Par rapport au défaut du mod:

- `customAlertMessage`: défaut `""` -> actuel `"MAIN_MESSAGE"`.
- `statDisplayModes.level`: défaut `MAIN_MESSAGE` -> actuel `DISABLED`.
- `statDisplayModes.gender`: défaut `HOVER` -> actuel `DISABLED`.
- `statDisplayModes.coordinates`: défaut `HOVER` -> actuel `DISABLED`.
- `statDisplayModes.nearestPlayer`: défaut `DISABLED` -> actuel `MAIN_MESSAGE`.
- `sounds.shiny`: défaut `""` -> actuel `"MAIN_MESSAGE"`.
- `sounds.starter`: défaut `""` -> actuel `"MAIN_MESSAGE"`.

## Impact réel de ces changements

- `customAlertMessage` et `statDisplayModes.*`:
  - **utilisés** dans `applyDynamicReplacements(...)`.
  - n’impactent que la **forme du message** (texte/hover/fragment), pas le fait qu’un packet spawn soit reçu.

- `sounds.*`:
  - **utilisés** pour jouer un son conditionnel.
  - n’impactent pas le déclenchement réseau du message.

Conclusion intermédiaire:
- ces changements peuvent modifier l’apparence/son **si le message spawn arrive côté client**,
- mais ne peuvent pas corriger un problème de chemin d’envoi/traitement du spawn.

## Modifications true/false dans `main.json` / `server.json`

État actuel:
- catégories `starter/shiny/legendary/paradox` sont déjà à `true` côté serveur et côté client.

Impact réel:
- ces booléens sont bien lus par le code,
- donc ce ne sont pas des "clés mortes".

Pourquoi ça n’a pas corrigé le bug observé:
- le point bloquant principal est ailleurs (pipeline spawn tracker/non-tracker + early-return côté `alertClientside`).
- donc même avec les bons booléens, le message d’apparition peut rester absent pour le joueur qui tracke le Pokémon au spawn.

## À propos de `showLegendary`

- Clé présente dans `pokemon.json`, mais non lue dans `AlertHandler`.
- C’est la seule clé clairement "morte" repérée dans cette zone.

