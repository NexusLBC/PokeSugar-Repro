# Audit complet recettes — candies / bonbons (XS→XL)

## Résumé exécutif
- **Recettes de craft candy trouvées**: **0** (aucune dans `data/*/recipe/*.json`, `data/*/recipes/*.json`, KubeJS, CraftTweaker).
- **Recettes candy supprimées/override détectées**: **0** (aucun `remove`, `replaceOutput`, `recipes.remove` lié aux candies).
- **Présence des items candies dans le repo**: **oui**, mais en **loot tables**, **avancements**, **drop/economy configs**.
- **Conclusion craftabilité**: **PAS DU TOUT craftable** (dans ce repo, aucun craft explicite).

## Méthode d’audit (ordre demandé)
1. Cartographie des emplacements recettes (`recipe/recipes`, KubeJS, CraftTweaker, dossiers `*recipe*`).
2. Recherche large mots-clés FR/EN (`candy`, `bonbon`, `rare_candy`, `exp_candy`, variantes XS→XL).
3. Recherche orientée outputs (`result/output/item/id`) sur les zones datapack/config.
4. Vérification tags (`data/*/tags/*/*.json`) liés aux candies.
5. Vérification override/removal (KubeJS/CraftTweaker patterns).

## Inventaire des IDs candy détectés
- `cobblemon:exp_candy_xs`
- `cobblemon:exp_candy_s`
- `cobblemon:exp_candy_m`
- `cobblemon:exp_candy_l`
- `cobblemon:exp_candy_xl`
- `cobblemon:rare_candy`
- IV candies (hors XS→XL): `health_candy`, `mighty_candy`, `tough_candy`, `smart_candy`, `courage_candy`, `quick_candy`

## Tableau des recettes candy trouvées (craft)

> **Aucune recette de craft candy trouvée**. Tableau rempli en mode audit négatif (attendu vs trouvé).

| Output item (namespace:id) | Count | Recipe type | Inputs | Source system | File path | Notes |
|---|---:|---|---|---|---|---|
| `cobblemon:exp_candy_xs` | — | **absent** | — | — | — | ID vu en loot/advancement, pas en craft |
| `cobblemon:exp_candy_s` | — | **absent** | — | — | — | ID vu en loot/advancement, pas en craft |
| `cobblemon:exp_candy_m` | — | **absent** | — | — | — | ID vu en loot/advancement, pas en craft |
| `cobblemon:exp_candy_l` | — | **absent** | — | — | — | ID vu en loot/advancement, pas en craft |
| `cobblemon:exp_candy_xl` | — | **absent** | — | — | — | ID vu en loot/advancement, pas en craft |
| `cobblemon:rare_candy` | — | **absent** | — | — | — | ID vu en loot/economy/advancement, pas en craft |
| `cobblemon:health_candy` | — | **absent** | — | — | — | IV candy vu en loot uniquement |
| `cobblemon:mighty_candy` | — | **absent** | — | — | — | IV candy vu en loot uniquement |
| `cobblemon:tough_candy` | — | **absent** | — | — | — | IV candy vu en loot uniquement |
| `cobblemon:smart_candy` | — | **absent** | — | — | — | IV candy vu en loot uniquement |
| `cobblemon:courage_candy` | — | **absent** | — | — | — | IV candy vu en loot uniquement |
| `cobblemon:quick_candy` | — | **absent** | — | — | — | IV candy vu en loot uniquement |

## Overrides / priorités / suppressions
- **Collisions de recipe IDs candy**: aucune (aucune recette candy trouvée).
- **Suppression/removal KubeJS**: non applicable (pas de dossier KubeJS).
- **Suppression/removal CraftTweaker**: non détectée (pas de scripts `.zs` pertinents).
- **Tags candy dédiés**: aucun tag candy détecté.

## Où les candies sont effectivement définis/appliqués
- **Loot tables datapack** (ex. `academy:cobblemon/candy_t*`, `basic_gym/*`, `basic_trials/*`).
- **Advancements Cobblemon** (`use_candy`, `use_iv_candy`) qui référencent les items candies.
- **Config lootballs** (tables de loot de balles, dont `master_loot_table`).
- **Config économie world** (`rare_candy` en black market / battle rewards).

## Checklist de fin
- [x] IDs exacts des bonbons/candies XS S M L XL identifiés
- [x] Chaque ID a : “existe recette ? oui/non”
- [x] Si oui : type + ingrédients + quantité + fichier (**aucun cas**)
- [x] Vérification des removes/overrides (KubeJS/CraftTweaker)
- [x] Conclusion claire : “Tout est craftable / Partiellement / Pas du tout” + liste des manquants

## Conclusion
**Statut final: MANQUANT / PAS DU TOUT craftable** pour les recettes candies XS→XL et `rare_candy` dans ce repo.

- XS: recette craft **non** trouvée
- S: recette craft **non** trouvée
- M: recette craft **non** trouvée
- L: recette craft **non** trouvée
- XL: recette craft **non** trouvée
- Rare Candy: recette craft **non** trouvée

Les items existent bien dans d’autres systèmes (loot/progression/economy), mais pas dans un système de craft déclaré dans les sources auditées.
