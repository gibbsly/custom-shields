#setup
data modify storage cushield:main item set from storage cushield:main player[0]
execute store result score slot= cushield.main run data get storage cushield:main player[0].Slot

#modify slots 
execute if score slot= cushield.main matches 0..8 run function cushield:block/unblock_all/hotbar
execute if score slot= cushield.main matches 09..17 run function cushield:block/unblock_all/inventory_1
execute if score slot= cushield.main matches 18..26 run function cushield:block/unblock_all/inventory_2
execute if score slot= cushield.main matches 27..35 run function cushield:block/unblock_all/inventory_3

#looping
data remove storage cushield:main player[0]
execute if data storage cushield:main player[0] run function cushield:block/unblock_all/loop