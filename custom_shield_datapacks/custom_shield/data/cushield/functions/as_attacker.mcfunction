#running parry effect as entity if player has parry effect
execute if score entity_parry= cush.main matches 1.. unless entity @s[type=creeper] run function cushield:blocked/parry/attacker