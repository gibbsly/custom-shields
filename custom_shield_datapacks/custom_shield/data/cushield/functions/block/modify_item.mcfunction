#copying item
execute if entity @s[tag=cushield.offhand] run data modify storage cushield:main item set from entity @s Inventory[{Slot:-106b}]
execute unless entity @s[tag=cushield.offhand] run data modify storage cushield:main item set from entity @s SelectedItem

#modifying
execute if entity @s[tag=cushield.blocking] run data modify storage cushield:main item.tag.CustomModelData set from storage cushield:main item.tag.shield.blocking_model
execute if entity @s[tag=cushield.blocking] run data modify storage cushield:main item.tag.blocking set value 1b
execute unless entity @s[tag=cushield.blocking] run data modify storage cushield:main item.tag.CustomModelData set from storage cushield:main item.tag.shield.default_model
execute unless entity @s[tag=cushield.blocking] run data modify storage cushield:main item.tag.blocking set value 0b

#durability handling
execute if data storage cushield:main item.tag.shield.durability run function cushield:block/do_durability

#modifying item
execute if entity @s[tag=cushield.offhand,tag=!cushield.break] run item modify entity @s weapon.offhand cushield:copy_item
execute if entity @s[tag=!cushield.offhand,tag=!cushield.break] run item modify entity @s weapon.mainhand cushield:copy_item
execute if entity @s[tag=cushield.offhand,tag=cushield.break] run item replace entity @s weapon.offhand with air
execute if entity @s[tag=!cushield.offhand,tag=cushield.break] run item replace entity @s weapon.mainhand with air
execute if entity @s[tag=cushield.break] anchored eyes run particle item shield ^ ^ ^1 0.1 0.1 0.1 0.1 8
tag @s remove cushield.break
