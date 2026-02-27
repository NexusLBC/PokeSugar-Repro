# Champs NBT modifiés pendant le reset

Fonction: `academy:trials/reset_vault_at_marker`

## Commandes appliquées

```mcfunction
data remove block ~ ~ ~ server_data.rewarded_players
data remove block ~ ~ ~ server_data.items_to_eject
data remove block ~ ~ ~ server_data.state_updating_resumes_at
data remove block ~ ~ ~ server_data.total_ejections_needed
data remove block ~ ~ ~ shared_data.connected_players
```

## Justification

- `server_data.rewarded_players`: retire l'historique par joueur, donc tous les joueurs redeviennent éligibles.
- `server_data.items_to_eject` + `server_data.total_ejections_needed`: purge d'un cycle de récompense en cours.
- `server_data.state_updating_resumes_at`: supprime un timer de reprise/cooldown intermédiaire.
- `shared_data.connected_players`: nettoie l'état de connexion visuelle des joueurs au vault.

## Champs explicitement conservés

- `config.key_item`
- `config.loot_table`
- tout autre `config.*`

=> le type de vault (normal/ominous) reste inchangé.
