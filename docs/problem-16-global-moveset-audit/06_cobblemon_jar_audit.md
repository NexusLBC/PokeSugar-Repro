# Audit Cobblemon / support datapack observé

## 1. Situation du jar Cobblemon

### Constat
Le jar Cobblemon principal n'a pas été trouvé sous un nom explicite dans `mods/`.

### Preuves indirectes solides
- `mods/CobblemonTrialsEdition-fabric-1.1.0.jar` dépend de `cobblemon >=1.7.1`
- `config/cobblemon/main.json` indique `"lastSavedVersion": "1.7.1"`

### Conclusion
Le serveur tourne bien sur Cobblemon 1.7.1, mais le jar de base n'est pas directement auditables dans ce repo sous un nom évident.

## 2. Où sont stockées les données utiles observées côté Cobblemon

### Dans le repo
Les données Cobblemon effectivement visibles et chargées vivent dans :
- `data/cobblemon/species/**`
- `data/cobblemon/species_additions/**`
- `data/cobblemon/spawn_pool_world/**`

### Interprétation
Même sans le jar de base, le modèle ressource consommé par Cobblemon est clairement visible à travers les datapacks serveur.

## 3. Format réel des learnsets observé

### Réponse
Le format réel observé est :
- **champ `moves` dans le JSON espèce/forme**

### Sous-format
- `niveau:move`
- `egg:move`
- `tm:move`
- `tutor:move`

### Exemple de lecture
`1:thundershock` = move appris au niveau 1
`egg:bestow` = egg move
`tm:agility` = compat TM
`tutor:thunderbolt` = compat tutor

## 4. Présence d'un support datapack/override

### Preuve directe
Oui, car le repo contient déjà des dossiers Cobblemon standards :
- `species`
- `species_additions`

Et ces dossiers sont activés par le chargement global des datapacks.

### Ce que cela prouve
Cobblemon accepte ici des ressources datapack de données espèces.

## 5. Indices sur la fusion des données custom

### Preuve directe
Des fichiers `species_additions` très partiels existent, par exemple :
- un Toxapex qui ne rajoute que `riding`

### Inférence forte
Cela implique un merge avec une espèce de base déjà connue.
Sinon ces fichiers seraient incomplets et inutilisables.

## 6. Ce que je peux conclure malgré l'absence du jar base

### Prouvé
- Cobblemon 1.7.1 est la base du serveur
- les données espèces sont data-driven
- `species_additions` est bien un canal de surcharge/extension
- le learnset fait partie de la donnée espèce via `moves`

### Non prouvé à 100%
- l'algorithme exact de priorité multi-pack côté code Cobblemon
- la granularité exacte du merge champ par champ sans audit du jar source

## 7. Conclusion
Même sans disposer du jar Cobblemon principal dans `mods/`, le repo donne suffisamment de preuves pour conclure que :
- les learnsets sont gérés par les **données d'espèce Cobblemon** ;
- les overrides exploitables passent par les **datapacks Cobblemon**, spécialement `species_additions`.
