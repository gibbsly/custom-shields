tag @s add cushield.can_block

playsound shield:ready player @s ~ ~ ~ 1 1 0
playsound shield:ready player @s ~ ~ ~ 1 1 0

execute unless score @s[tag=cushield.first] cush.title matches -1 run function cushield:block/icon

tag @s add cushield.first