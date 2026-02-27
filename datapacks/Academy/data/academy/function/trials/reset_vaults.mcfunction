# Academy - Daily Trial Vault reset
# Called from minecraft:load (server restart).
# Strategy: reset every vault referenced by persistent marker entities.

# Reset every registered vault marker in loaded chunks.
execute as @e[type=minecraft:marker,tag=academy_trial_vault] at @s run function academy:trials/reset_vault_at_marker

# Housekeeping: drop stale markers that no longer point to a vault block.
execute as @e[type=minecraft:marker,tag=academy_trial_vault] at @s unless block ~ ~ ~ minecraft:vault run kill @s
