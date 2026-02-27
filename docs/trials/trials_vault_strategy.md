# Stratégie retenue: index des vaults via markers

## Principe

On référence chaque vault avec une entité:
- type: `minecraft:marker`
- tag: `academy_trial_vault`
- position: exactement sur le bloc `minecraft:vault`

Au redémarrage (`minecraft:load`), la fonction de reset parcourt ces markers et reset le vault à leurs coordonnées.

## Pourquoi cette stratégie

- Compatible vanilla datapack.
- Coût faible (itération d'une liste indexée), même avec beaucoup de vaults.
- Évite un scan massif de terrain à chaque reboot.

## Bootstrap / maintenance de l'index

La création des markers est une étape d'exploitation (op/admin), à faire lors des découvertes de Trial Chambers ou par lot via des outils d'administration.

Commande manuelle (exemple sur un vault ciblé):

```mcfunction
execute positioned <x> <y> <z> if block ~ ~ ~ minecraft:vault run summon minecraft:marker ~ ~ ~ {Tags:["academy_trial_vault"]}
```

Le reset supprime automatiquement les markers devenus invalides (si le bloc n'est plus un vault).

## Limitation majeure

Un vault sans marker ne sera pas reset.
