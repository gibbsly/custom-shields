scoreboard players set @s cush.title 7

#title mode 1 (subtitle)
execute if score icon= cush.main matches 1 run title @s times 0 20 0
execute if score icon= cush.main matches 1 run title @s subtitle {"text":"R","font":"shield:icon"}
execute if score icon= cush.main matches 1 run title @s title ""
#title mode 2 (actionbar)
execute if score icon= cush.main matches 2 run title @s actionbar {"text":"r","font":"shield:icon"}