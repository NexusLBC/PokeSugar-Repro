# Fossils patch TODO (intégration HA + Radiant + Max IV)

Plan de correction exploitable pour un patch suivant, sans casser l'existant.

## Règles de sécurité
1. **Ne pas modifier** `shiny_fossil.json` hors besoin explicite (mapping déjà actif).
2. Ajouter les nouveaux mappings dans des fichiers dédiés, 1 item spécial = 1 fichier.
3. Tester la machine avec chaque fossile spécial après ajout.

## TODO par fossile spécial

### 1) `academy:shiny_fossil`
- `item_id` : `academy:shiny_fossil`
- `doit avoir fichier_fossil_json ?` **OUI**
- fichier cible : **déjà présent** `shiny_fossil.json`
- effet voulu :
  - shiny = `true`
  - HA = `false` (sauf besoin design)
  - IV = `random`
  - radiant = `false`
  - catégorie Pokémon = `random_common` (ou autre si équilibrage voulu)
- état actuel : **mapping OK**

### 2) `academy:ha_fossil`
- `item_id` : `academy:ha_fossil`
- `doit avoir fichier_fossil_json ?` **OUI**
- fichier cible conseillé : `ha_fossil.json`
- effet voulu (proposition) :
  - shiny = `false`
  - HA = `true`
  - IV = `random`
  - radiant = `false`
  - catégorie Pokémon = `random_common` (ou `random_rare` si design premium)
- état actuel : **mapping manquant**

### 3) `academy:max_iv_fossil`
- `item_id` : `academy:max_iv_fossil`
- `doit avoir fichier_fossil_json ?` **OUI**
- fichier cible conseillé : `max_iv_fossil.json`
- effet voulu (proposition) :
  - shiny = `false`
  - HA = `false`
  - IV = `31 all`
  - radiant = `false`
  - catégorie Pokémon = `random_common` (ou `random_rare` selon balance)
- état actuel : **mapping manquant**

### 4) `academy:radiant_fossil`
- `item_id` : `academy:radiant_fossil`
- `doit avoir fichier_fossil_json ?` **OUI (si item activé côté gameplay)**
- fichier cible conseillé : `radiant_fossil.json`
- effet voulu (proposition) :
  - shiny = selon design (`false` recommandé si radiant est distinct du shiny)
  - HA = selon design
  - IV = selon design
  - radiant = `true` **uniquement si Cobblemon/API supporte ce flag dans le champ `result`**
  - catégorie Pokémon = `random_common` ou pool radiant dédié
- état actuel : **mapping manquant**

## Vérifications à faire dans le patch de correction
1. Vérifier la grammaire exacte supportée par Cobblemon pour `result` (flags HA / IV / radiant), via la doc du mod principal ou ses data pack internals.
2. Ajouter les 3 fichiers manquants sous `datapacks/Academy/data/cobblemon/fossils/`.
3. Contrôler que chaque item spécial est obtenu quelque part (loot, shop, quest) :
   - `ha_fossil` et `max_iv_fossil` déjà lootables,
   - `radiant_fossil` à brancher dans loot/shop si voulu.
4. Tester en jeu la machine à fossiles pour les 4 items spéciaux.
