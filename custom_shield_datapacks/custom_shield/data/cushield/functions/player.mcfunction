#times
scoreboard players set @s[scores={cush.use=1..}] cush.block_time 5
execute if score icon= cush.main matches 1 if entity @s[tag=!cushield.can_block,tag=cushield.first] unless score @s cush.title matches -1 run function cushield:block/cooldown

#can block logic
execute unless entity @s[tag=cushield.can_block] unless score @s cush.block_time matches 0.. unless score @s cush.wait matches 1.. run function cushield:block/can

#running blocking function
execute if score @s[tag=cushield.can_block] cush.block_time matches 0.. unless score @s cush.wait matches 1.. run function cushield:block

#resetting use score
scoreboard players reset @s[scores={cush.use=1..}] cush.use
scoreboard players remove @s[scores={cush.block_time=0..}] cush.block_time 1

#coyote time handling
scoreboard players remove @s[scores={cush.cy.dur=1..}] cush.cy.dur 1
scoreboard players add @s[scores={cush.cy.dur=..-1}] cush.cy.dur 1
scoreboard players reset @s[scores={cush.dam=1..}] cush.dam
scoreboard players reset @s[scores={cush.abs=1..}] cush.abs

#title handling
execute if score @s cush.title matches 1 run function cushield:event/reset_title_times
scoreboard players remove @s[scores={cush.title=1..}] cush.title 1