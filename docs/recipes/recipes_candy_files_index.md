# Index brut — fichiers suspects (audit candies)

## 1) Fichiers recipes JSON pertinents

### Résultat
Aucun fichier de recette (`data/*/recipe/*.json` et `data/*/recipes/*.json`) ne contient de sortie/ingrédient candy (mots-clés: `candy`, `exp_candy`, `rare_candy`, `bonbon`).

### Extrait de contrôle (fichier recipe existant, sans candy)
**Chemin**: `datapacks/Academy/data/cobblemon/recipe/cooking_pot/fried_rice.json`

```json
{
  "type": "cobblemon:cooking_pot_shapeless",
  "experience": 1.0,
  "ingredients": [
    { "tag": "c:crops/rice" },
    { "tag": "c:eggs" },
    { "item": "minecraft:carrot" },
    { "tag": "c:crops/onion" },
    { "item": "minecraft:bowl" }
  ],
  "recipe_book_tab": "meals",
  "result": {
    "count": 1,
    "id": "farmersdelight:fried_rice"
  }
}
```

## 2) Scripts KubeJS pertinents

### Résultat
Aucun dossier `kubejs/` détecté (donc aucun `server_scripts`, `startup_scripts` ni `kubejs/data/*/recipes`).

## 3) Scripts CraftTweaker pertinents

### Résultat
Aucun dossier `scripts/` ou `crafttweaker/` avec scripts `.zs` de recettes candies détecté.

## 4) Autres fichiers suspects (hors craft) contenant des candies

> Ces fichiers ne définissent pas des recettes de craft, mais expliquent où les items candy apparaissent (loot, progression, économie).

### 4.1 Loot table avec `exp_candy_xs`
**Chemin**: `datapacks/Academy/data/academy/loot_table/cobblemon/candy_t0.json`

```json
{
  "type": "loot_table",
    "pools": [
      {
        "bonus_rolls": 0.0,
        "entries": [
          {
            "type": "minecraft:item",
            "functions": [
              {
                "count": {
                  "type": "minecraft:uniform",
                  "max": 2.0,
                  "min": 1.0
                },
                "function": "minecraft:set_count"
              }
            ],
            "name": "cobblemon:exp_candy_xs"
          }
        ],
        "rolls": 1.0
      }
    ]
  }
```

### 4.2 Loot table avec `exp_candy_l` + `rare_candy`
**Chemin**: `datapacks/Academy/data/academy/loot_table/cobblemon/candy_t9.json`

```json
{
  "type": "loot_table",
    "pools": [
      {
        "bonus_rolls": 0.0,
        "entries": [
          {
            "type": "minecraft:item",
            "functions": [
              {
                "count": {
                  "type": "minecraft:uniform",
                  "max": 1.0,
                  "min": 1.0
                },
                "function": "minecraft:set_count"
              }
            ],
            "name": "cobblemon:exp_candy_l",
            "weight": 5
          },
          {
            "type": "minecraft:item",
            "name": "cobblemon:rare_candy",
            "weight": 10
          }
        ]
      }
    ]
}
```

### 4.3 Loot table IV candies
**Chemin**: `datapacks/Academy/data/academy/loot_table/cobblemon/ivcandy.json`

```json
{
  "type": "loot_table",
    "pools": [
      {
        "entries": [
          { "type": "minecraft:item", "name": "cobblemon:health_candy", "weight": 1 },
          { "type": "minecraft:item", "name": "cobblemon:mighty_candy", "weight": 1 },
          { "type": "minecraft:item", "name": "cobblemon:tough_candy", "weight": 1 },
          { "type": "minecraft:item", "name": "cobblemon:smart_candy", "weight": 1 },
          { "type": "minecraft:item", "name": "cobblemon:courage_candy", "weight": 1 },
          { "type": "minecraft:item", "name": "cobblemon:quick_candy", "weight": 1 }
        ],
        "rolls": 1.0
      }
    ]
}
```

### 4.4 Avancement Cobblemon (référence explicite XS→XL + rare)
**Chemin**: `datapacks/Academy/data/cobblemon/advancement/use_candy.json`

```json
{"display":{"icon":{"id":"cobblemon:exp_candy_xl"}},"criteria":{"use_rare_candy":{"conditions":{"item":"cobblemon:rare_candy"}},"use_xl_candy":{"conditions":{"item":"cobblemon:exp_candy_xl"}},"use_l_candy":{"conditions":{"item":"cobblemon:exp_candy_l"}},"use_m_candy":{"conditions":{"item":"cobblemon:exp_candy_m"}},"use_s_candy":{"conditions":{"item":"cobblemon:exp_candy_s"}},"use_xs_candy":{"conditions":{"item":"cobblemon:exp_candy_xs"}}}}
```

### 4.5 Loot table config (master) avec S/M/L/XL + rare
**Chemin**: `config/lootballs/loot_tables/master_loot_table.json`

```json
{
  "entries": [
    { "name": "cobblemon:exp_candy_s",  "functions": [{ "count": 30.0 }] },
    { "name": "cobblemon:exp_candy_m",  "functions": [{ "count": 20.0 }] },
    { "name": "cobblemon:rare_candy",   "functions": [{ "count": 12.0 }] },
    { "name": "cobblemon:exp_candy_l",  "functions": [{ "count": 4.0  }] },
    { "name": "cobblemon:exp_candy_xl", "functions": [{ "count": 1.0  }] }
  ]
}
```

### 4.6 Économie serveur (achat/drop table rare candy)
**Chemin**: `world/config/cobblemon-economy/config.json`

```json
{
  "black_market": {
    "items": [
      {
        "id": "minecraft:black_shulker_box",
        "dropTable": [
          "cobblemon:master_ball",
          "cobblemon:rare_candy",
          "cobblemon:ability_patch"
        ]
      }
    ]
  },
  "battle_rewards": {
    "items": [
      {
        "id": "cobblemon:rare_candy",
        "name": "Rare Candy",
        "price": 50
      }
    ]
  }
}
```
