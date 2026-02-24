# Vue d’ensemble du système arène (rad-gyms)

## Fichiers identifiés comme partie du système d’arène

- `datapacks/Academy/data/rad-gyms/gyms/*.json` — définitions des gyms (trainers, niveau, et `reward_loot_tables`).
- `datapacks/Academy/data/rad-gyms/loot_table/gyms/**/t*_loot_table.json` — loot par tiers de niveau (inclut cache Pokémon).
- `datapacks/Academy/data/rad-gyms/loot_table/gyms/**/shared_loot_table.json` — loot partagé (capsule/sticker, pas de cache Pokémon).
- `datapacks/Academy/data/rad-gyms/caches/*.json` — pools Pokémon par type (`common`, `uncommon`, `rare`, `epic`) + poids.
- `datapacks/Academy/data/rad-gyms/recipe/cache_*.json` — recettes de conversion/craft des caches avec composant `rad-gyms:gym_type_component`.

## Mécanisme actuel de récompense aléatoire

1. Chaque gym référence des `reward_loot_tables` par tranche de niveau (`t0`..`t10`).
2. Les loot tables de tiers donnent un item `rad-gyms:cache_common|uncommon|rare` avec le composant de type d’arène (ex: `fighting`).
3. Les espèces possibles sont définies dans `caches/<type>.json` avec leurs poids.
4. Le tirage final du Pokémon au moment d’ouverture/consommation du cache est géré par le mod `rad-gyms` (pas par fonction datapack).

### Déclencheur (ou liaison)

- Liaison visible : `gyms/*.json` -> `reward_loot_tables` -> `loot_table/gyms/...` -> item cache.
- Aucun déclencheur `.mcfunction`/`advancement rewards.function` n’a été trouvé pour piloter ce flux dans le datapack; l’appel semble 100% côté mod.

## Pokémon "arena-only" (sans spawn naturel configuré)

| Pokémon (ID) | Trouvé dans rewards arène | Spawns Cobblemon trouvés ? |
|---|---|---|
| `cobblemon:abra` | OUI | NON |
| `cobblemon:absol` | OUI | NON |
| `cobblemon:accelgor` | OUI | NON |
| `cobblemon:aegislash` | OUI | NON |
| `cobblemon:aerodactyl` | OUI | NON |
| `cobblemon:aggron` | OUI | NON |
| `cobblemon:aipom` | OUI | NON |
| `cobblemon:alakazam` | OUI | NON |
| `cobblemon:alcremie` | OUI | NON |
| `cobblemon:alomomola` | OUI | NON |
| `cobblemon:altaria` | OUI | NON |
| `cobblemon:amaura` | OUI | NON |
| `cobblemon:ambipom` | OUI | NON |
| `cobblemon:amoonguss` | OUI | NON |
| `cobblemon:ampharos` | OUI | NON |
| `cobblemon:annihilape` | OUI | NON |
| `cobblemon:anorith` | OUI | NON |
| `cobblemon:appletun` | OUI | NON |
| `cobblemon:araquanid` | OUI | NON |
| `cobblemon:arbok` | OUI | NON |
| `cobblemon:arboliva` | OUI | NON |
| `cobblemon:arceus` | OUI | NON |
| `cobblemon:archaludon` | OUI | NON |
| `cobblemon:archen` | OUI | NON |
| `cobblemon:archeops` | OUI | NON |
| `cobblemon:arctovish` | OUI | NON |
| `cobblemon:arctozolt` | OUI | NON |
| `cobblemon:armaldo` | OUI | NON |
| `cobblemon:armarouge` | OUI | NON |
| `cobblemon:aron` | OUI | NON |
| `cobblemon:arrokuda` | OUI | NON |
| `cobblemon:articuno` | OUI | NON |
| `cobblemon:aurorus` | OUI | NON |
| `cobblemon:axew` | OUI | NON |
| `cobblemon:azelf` | OUI | NON |
| `cobblemon:azumarill` | OUI | NON |
| `cobblemon:azurill` | OUI | NON |
| `cobblemon:bagon` | OUI | NON |
| `cobblemon:baltoy` | OUI | NON |
| `cobblemon:banette` | OUI | NON |
| `cobblemon:barbaracle` | OUI | NON |
| `cobblemon:barboach` | OUI | NON |
| `cobblemon:barraskewda` | OUI | NON |
| `cobblemon:basculegion` | OUI | NON |
| `cobblemon:basculin` | OUI | NON |
| `cobblemon:bastiodon` | OUI | NON |
| `cobblemon:beartic` | OUI | NON |
| `cobblemon:beedrill` | OUI | NON |
| `cobblemon:beheeyem` | OUI | NON |
| `cobblemon:beldum` | OUI | NON |
| `cobblemon:bellibolt` | OUI | NON |
| `cobblemon:bellossom` | OUI | NON |
| `cobblemon:bellsprout` | OUI | NON |
| `cobblemon:bergmite` | OUI | NON |
| `cobblemon:bewear` | OUI | NON |
| `cobblemon:bibarel` | OUI | NON |
| `cobblemon:bidoof` | OUI | NON |
| `cobblemon:binacle` | OUI | NON |
| `cobblemon:blissey` | OUI | NON |
| `cobblemon:blitzle` | OUI | NON |
| `cobblemon:boldore` | OUI | NON |
| `cobblemon:boltund` | OUI | NON |
| `cobblemon:bonsly` | OUI | NON |
| `cobblemon:bouffalant` | OUI | NON |
| `cobblemon:bounsweet` | OUI | NON |
| `cobblemon:brambleghast` | OUI | NON |
| `cobblemon:bramblin` | OUI | NON |
| `cobblemon:breloom` | OUI | NON |
| `cobblemon:bronzong` | OUI | NON |
| `cobblemon:bronzor` | OUI | NON |
| `cobblemon:bruxish` | OUI | NON |
| `cobblemon:budew` | OUI | NON |
| `cobblemon:buizel` | OUI | NON |
| `cobblemon:bulbasaur` | OUI | NON |
| `cobblemon:buneary` | OUI | NON |
| `cobblemon:bunnelby` | OUI | NON |
| `cobblemon:butterfree` | OUI | NON |
| `cobblemon:cacnea` | OUI | NON |
| `cobblemon:cacturne` | OUI | NON |
| `cobblemon:calyrex` | OUI | NON |
| `cobblemon:camerupt` | OUI | NON |
| `cobblemon:capsakid` | OUI | NON |
| `cobblemon:carbink` | OUI | NON |
| `cobblemon:carnivine` | OUI | NON |
| `cobblemon:carracosta` | OUI | NON |
| `cobblemon:carvanha` | OUI | NON |
| `cobblemon:caterpie` | OUI | NON |
| `cobblemon:celebi` | OUI | NON |
| `cobblemon:centiskorch` | OUI | NON |
| `cobblemon:ceruledge` | OUI | NON |
| `cobblemon:cetitan` | OUI | NON |
| `cobblemon:cetoddle` | OUI | NON |
| `cobblemon:chandelure` | OUI | NON |
| `cobblemon:chansey` | OUI | NON |
| `cobblemon:charcadet` | OUI | NON |
| `cobblemon:charmander` | OUI | NON |
| `cobblemon:chatot` | OUI | NON |
| `cobblemon:chespin` | OUI | NON |
| `cobblemon:chewtle` | OUI | NON |
| `cobblemon:chienpao` | OUI | NON |
| `cobblemon:chikorita` | OUI | NON |
| `cobblemon:chimchar` | OUI | NON |
| `cobblemon:chimecho` | OUI | NON |
| `cobblemon:chinchou` | OUI | NON |
| `cobblemon:chingling` | OUI | NON |
| `cobblemon:chiyu` | OUI | NON |
| `cobblemon:cinccino` | OUI | NON |
| `cobblemon:clamperl` | OUI | NON |
| `cobblemon:clauncher` | OUI | NON |
| `cobblemon:clawitzer` | OUI | NON |
| `cobblemon:claydol` | OUI | NON |
| `cobblemon:clefable` | OUI | NON |
| `cobblemon:clefairy` | OUI | NON |
| `cobblemon:cleffa` | OUI | NON |
| `cobblemon:clobbopus` | OUI | NON |
| `cobblemon:clodsire` | OUI | NON |
| `cobblemon:cloyster` | OUI | NON |
| `cobblemon:cobalion` | OUI | NON |
| `cobblemon:cofagrigus` | OUI | NON |
| `cobblemon:combee` | OUI | NON |
| `cobblemon:comfey` | OUI | NON |
| `cobblemon:conkeldurr` | OUI | NON |
| `cobblemon:copperajah` | OUI | NON |
| `cobblemon:corphish` | OUI | NON |
| `cobblemon:corviknight` | OUI | NON |
| `cobblemon:corvisquire` | OUI | NON |
| `cobblemon:cosmoem` | OUI | NON |
| `cobblemon:cosmog` | OUI | NON |
| `cobblemon:cottonee` | OUI | NON |
| `cobblemon:crabominable` | OUI | NON |
| `cobblemon:crabrawler` | OUI | NON |
| `cobblemon:cradily` | OUI | NON |
| `cobblemon:cramorant` | OUI | NON |
| `cobblemon:cranidos` | OUI | NON |
| `cobblemon:crawdaunt` | OUI | NON |
| `cobblemon:cresselia` | OUI | NON |
| `cobblemon:croagunk` | OUI | NON |
| `cobblemon:crustle` | OUI | NON |
| `cobblemon:cryogonal` | OUI | NON |
| `cobblemon:cubchoo` | OUI | NON |
| `cobblemon:cubone` | OUI | NON |
| `cobblemon:cufant` | OUI | NON |
| `cobblemon:cursola` | OUI | NON |
| `cobblemon:cutiefly` | OUI | NON |
| `cobblemon:cyclizar` | OUI | NON |
| `cobblemon:cyndaquil` | OUI | NON |
| `cobblemon:dachsbun` | OUI | NON |
| `cobblemon:darkrai` | OUI | NON |
| `cobblemon:dartrix` | OUI | NON |
| `cobblemon:decidueye` | OUI | NON |
| `cobblemon:dedenne` | OUI | NON |
| `cobblemon:deerling` | OUI | NON |
| `cobblemon:deino` | OUI | NON |
| `cobblemon:delibird` | OUI | NON |
| `cobblemon:deoxys` | OUI | NON |
| `cobblemon:dewgong` | OUI | NON |
| `cobblemon:dewott` | OUI | NON |
| `cobblemon:dewpider` | OUI | NON |
| `cobblemon:dhelmise` | OUI | NON |
| `cobblemon:dialga` | OUI | NON |
| `cobblemon:diancie` | OUI | NON |
| `cobblemon:diggersby` | OUI | NON |
| `cobblemon:dodrio` | OUI | NON |
| `cobblemon:doduo` | OUI | NON |
| `cobblemon:dolliv` | OUI | NON |
| `cobblemon:dondozo` | OUI | NON |
| `cobblemon:donphan` | OUI | NON |
| `cobblemon:doublade` | OUI | NON |
| `cobblemon:dracovish` | OUI | NON |
| `cobblemon:dracozolt` | OUI | NON |
| `cobblemon:dragalge` | OUI | NON |
| `cobblemon:dragapult` | OUI | NON |
| `cobblemon:dragonair` | OUI | NON |
| `cobblemon:dragonite` | OUI | NON |
| `cobblemon:drakloak` | OUI | NON |
| `cobblemon:drampa` | OUI | NON |
| `cobblemon:drapion` | OUI | NON |
| `cobblemon:dratini` | OUI | NON |
| `cobblemon:drednaw` | OUI | NON |
| `cobblemon:dreepy` | OUI | NON |
| `cobblemon:drifblim` | OUI | NON |
| `cobblemon:drifloon` | OUI | NON |
| `cobblemon:drilbur` | OUI | NON |
| `cobblemon:drowzee` | OUI | NON |
| `cobblemon:druddigon` | OUI | NON |
| `cobblemon:dubwool` | OUI | NON |
| `cobblemon:ducklett` | OUI | NON |
| `cobblemon:dudunsparce` | OUI | NON |
| `cobblemon:dunsparce` | OUI | NON |
| `cobblemon:duosion` | OUI | NON |
| `cobblemon:durant` | OUI | NON |
| `cobblemon:dusclops` | OUI | NON |
| `cobblemon:dusknoir` | OUI | NON |
| `cobblemon:duskull` | OUI | NON |
| `cobblemon:dwebble` | OUI | NON |
| `cobblemon:eelektrik` | OUI | NON |
| `cobblemon:eelektross` | OUI | NON |
| `cobblemon:eiscue` | OUI | NON |
| `cobblemon:ekans` | OUI | NON |
| `cobblemon:eldegoss` | OUI | NON |
| `cobblemon:electabuzz` | OUI | NON |
| `cobblemon:electivire` | OUI | NON |
| `cobblemon:electrike` | OUI | NON |
| `cobblemon:electrode` | OUI | NON |
| `cobblemon:elekid` | OUI | NON |
| `cobblemon:elgyem` | OUI | NON |
| `cobblemon:emolga` | OUI | NON |
| `cobblemon:enamorus` | OUI | NON |
| `cobblemon:entei` | OUI | NON |
| `cobblemon:escavalier` | OUI | NON |
| `cobblemon:espathra` | OUI | NON |
| `cobblemon:espeon` | OUI | NON |
| `cobblemon:espurr` | OUI | NON |
| `cobblemon:eternatus` | OUI | NON |
| `cobblemon:excadrill` | OUI | NON |
| `cobblemon:exeggcute` | OUI | NON |
| `cobblemon:exeggutor` | OUI | NON |
| `cobblemon:exploud` | OUI | NON |
| `cobblemon:falinks` | OUI | NON |
| `cobblemon:farfetchd` | OUI | NON |
| `cobblemon:farigiraf` | OUI | NON |
| `cobblemon:fearow` | OUI | NON |
| `cobblemon:feebas` | OUI | NON |
| `cobblemon:fennekin` | OUI | NON |
| `cobblemon:ferroseed` | OUI | NON |
| `cobblemon:ferrothorn` | OUI | NON |
| `cobblemon:fezandipiti` | OUI | NON |
| `cobblemon:fidough` | OUI | NON |
| `cobblemon:finizen` | OUI | NON |
| `cobblemon:finneon` | OUI | NON |
| `cobblemon:flaaffy` | OUI | NON |
| `cobblemon:flabebe` | OUI | NON |
| `cobblemon:flamigo` | OUI | NON |
| `cobblemon:flapple` | OUI | NON |
| `cobblemon:flareon` | OUI | NON |
| `cobblemon:fletchinder` | OUI | NON |
| `cobblemon:fletchling` | OUI | NON |
| `cobblemon:flittle` | OUI | NON |
| `cobblemon:floatzel` | OUI | NON |
| `cobblemon:floette` | OUI | NON |
| `cobblemon:florges` | OUI | NON |
| `cobblemon:flygon` | OUI | NON |
| `cobblemon:fomantis` | OUI | NON |
| `cobblemon:foongus` | OUI | NON |
| `cobblemon:forretress` | OUI | NON |
| `cobblemon:fraxure` | OUI | NON |
| `cobblemon:frillish` | OUI | NON |
| `cobblemon:froakie` | OUI | NON |
| `cobblemon:froslass` | OUI | NON |
| `cobblemon:fuecoco` | OUI | NON |

> Liste tronquée à 250 entrées dans ce document (819 au total). La liste brute complète est dans `docs/pokemon/arena_reward_species_raw.md` et peut être recroisée avec les spawn pools.

## Diagnostic – causes probables de dysfonctionnement des récompenses d’arène

- **Déclenchement gym -> loot table** : non vérifiable entièrement depuis le datapack seul; dépend de la logique runtime du mod `rad-gyms`.
- **Liste Pokémon / IDs** : structurellement cohérente dans `caches/*.json`; Timburr est bien présent.
- **Conditions bloquantes** : progression de rareté visible (`common` T0-2, `uncommon` T3-5, `rare` T6-10).
- **Point suspect concret** : les pools `epic` existent dans `caches/*.json` mais aucune loot table de gym ne distribue `rad-gyms:cache_epic`; ces espèces semblent inaccessibles via récompense standard de victoire.
- **Autre point suspect** : si des Pokémon comme Timburr restent introuvables malgré présence en cache, la rupture probable est côté consommation du cache/attribution du Pokémon (côté mod, hors datapack).
