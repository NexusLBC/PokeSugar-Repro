# Peut-on reproduire un override de moveset plus tard ?

## Réponse pratique
**Oui, surtout via datapack.**
Le repo ne donne pas de preuve sérieuse qu'une config ou un script soit une meilleure voie.

## Cas 1 — Via datapack

### Supporté ou non
**Oui, supporté en pratique et fortement prouvé.**

### Preuve
- les datapacks du repo sont chargés globalement
- `species_additions` est déjà utilisé massivement
- certaines additions portent des `moves` dans des formes

### Difficulté
- **moyenne**
- il faut respecter la structure JSON Cobblemon
- il faut vérifier comment fusionner proprement un `moves` pour l'espèce visée

### Maintenance
- **bonne** si le patch est isolé dans un datapack dédié
- lisible, versionnable, diffable
- moins risqué qu'un patch jar/mod

### Recommandation
**C'est la méthode recommandée.**

## Cas 2 — Via config

### Supporté ou non
**Non prouvé pour un override de learnset par espèce.**

### Preuve
- `config/cobblemon/main.json` : réglages globaux seulement
- `config/simpletms/main.json` : activation de catégories d'apprentissage, pas édition par Pokémon
- absence de `serverconfig` utile

### Difficulté
- faible pour changer des règles globales
- mais **non applicable** au besoin exact de patcher un learnset ciblé

### Maintenance
- bonne pour des toggles globaux
- **mauvaise / impossible** pour un correctif Toxapex précis, faute de support prouvé

### Recommandation
**À écarter pour la correction future de Toxapex.**

## Cas 3 — Via script

### Supporté ou non
**Non trouvé / non prouvé.**

### Preuve
- pas de KubeJS
- pas de scripts Cobblemon de mutation de learnsets
- pas de CraftTweaker/Groovy/ZenScript utiles trouvés

### Difficulté
- potentiellement élevée même si possible via un addon custom
- non justifiée ici

### Maintenance
- plus fragile
- plus opaque
- moins compatible avec les updates qu'un datapack

### Recommandation
**À éviter** sauf découverte ultérieure d'une API officielle déjà prévue.

## Recommandation finale par scénario

### Si on veut un patch propre et réutilisable
- **Datapack**

### Si on veut un toggle global de catégories d'apprentissage
- **Config SimpleTMs/Cobblemon**, mais cela ne corrige pas un Pokémon donné

### Si on veut bricoler sans support prouvé
- **Script** : non recommandé
