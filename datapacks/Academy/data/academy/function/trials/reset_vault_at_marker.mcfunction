# Reset one vault at marker position.
# Must be run as+at the marker.

# Abort if marker no longer sits on a vault.
execute unless block ~ ~ ~ minecraft:vault run return 0

# Clear per-player unlock history.
data remove block ~ ~ ~ server_data.rewarded_players

# Clear queued ejections/items from in-progress runs.
data remove block ~ ~ ~ server_data.items_to_eject

# Clear vault resume timer and dynamic ejection requirement.
data remove block ~ ~ ~ server_data.state_updating_resumes_at
data remove block ~ ~ ~ server_data.total_ejections_needed

# Clear shared player visibility/cache list.
data remove block ~ ~ ~ shared_data.connected_players
