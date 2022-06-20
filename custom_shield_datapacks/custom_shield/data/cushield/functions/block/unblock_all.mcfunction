#ending block state
tag @s add cushield.end_from_hand
tag @s add cushield.ended
function cushield:block/end

#fixing shield data in the inventory
data modify storage cushield:main player set value []
data modify storage cushield:main player append from entity @s Inventory[{tag:{blocking:1b}}]
data modify storage cushield:main player[{tag:{blocking:1b}}].tag.CustomModelData set from storage cushield:main player[{tag:{blocking:1b}}].tag.shield.default_model
data modify storage cushield:main player[{tag:{blocking:1b}}].tag.blocking set value 0b

#recursive modification
execute if data storage cushield:main player[0] run function cushield:block/unblock_all/loop