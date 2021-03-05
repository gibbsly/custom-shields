# Custom Shields
This is a system that adds custom shields to minecraft with configurable attributes.

## In this repo

### Datapacks
1. `custom_shield` | The core system for the custom shields
2. entity_hit_detection | My [entity hit detection datapack](https://github.com/gibbsly/ehid), packaged with this system since it is dependent on it to function.

### Resource Pack
The resource pack is required for the shield models and sounds, there are translations for all the strings used for this in the `shield/lang` folder. If you would like to contribute to translations, you can create a pull request with an additional lang file.

# About the shields
In this section I will go over the shield system in detail. I also have a video [here](coming soon) that covers everything in detail.

The function `cushield:give_template_shield` gives you some template shields that you can try out.

## Blocking
If you are holding a shield item in your main or offhand, and holding use (right click), you will start blocking. This is immediate, unlike vanilla shields. Shields in your offhand will be prioritized over mainhand shields.
 
### Normal
A normal block has a damage reduction formula that is applied to the damage you receive. 

The damage formula is `([damage received] * 100 - ((block_value * 100) - (([total time blocking in ticks] - parry_time) * decay_rate)))/100`.

### Parry
If a shield can parry, specified by the `parry_time` attribute, and you are hit within the parry window specified by that attribute, you will execute a parry. A parry negates all damage you would have received. 

If any effects are specified within the attributes, they will be applied. 

#### Coyote time
Parrys can have coyote time, this is an amount of time, in ticks, after you get hit that you can execute a parry. If a hit would be fatal you will still die since you can't parry when you are dead.

### Arrow reflection
Shields can have an attribute that allows you to reflect an arrow. The speed of the arrow that is reflected is determined by how long you have been blocking, the longer you have been blocking, the slower it is launched.

The speed falloff is doubled for non-parry blocks.

### Disablers
Shields can be disabled for a set duration of time, set by an attribute on the shield, if you block and attack from a disabler item. 

A disabler item is an item in the item tag `#cushield:disabler`, or an item with the nbt `{disabler:1b}` If you want an item that is in the `#cushield:disabler` item tag to not disable a shield you can add the nbt `{disabler:0b}`. 

If you want a shield to not be disabled by a disabler item, you can specify that with the `disable_resistant` attribute.

### Bashing
Shields can execute a bash effect if you sprint while blocking, this is specified with the `block_effect` attribute. 

## Adding Models
Adding a new model to use for a shield requires you to create 2 models, a standard model, and a blocking model. I have 2 template models provided in the resource pack. Once you have your models made, you have to add them to the `CustomModelData` overrides on the `carrot_on_a_stick` item model. You aren't limited to shield shaped models for this, this system doesn't care what the models look like, so you can re-create swords that can block like in 1.7.

## Configurable Attributes 
Shields have 18 configurable attributes you can use, any attributes marked with a `*` are required for the shield to function as intended. All these attributes are in an object called `shield` in the items tags.

Block angle attributes, this specifies a rectangle in which the center of the entity that is being blocked must be within for a block to register. This value is a total angle, eg. 90 will be 45 degrees in each direction.
> `x_angle`* | value: angle | vertical angle for blocking window
> 
> `y_angle`* | value: angle | horizontal angle for blocking window 
  
Timing values
> `max_time`* | value: time | maximum amount of time you can block with the shield
> 
> `cooldown`* | value: time | amount of time you after you drop your shield before you can block again

Durability[¹]()
> `durability` | value: int | maximum durability (unbreakable if not specified)
  
Values used for damage calculation
> `block_value`* | value | amount of damage to reduce from non-parry block
> 
> `decay_rate` | value: model | decay rate for block value 
  
Model values, these specify what CustomModelData values to use.
> `default_model`* | value | custom model data used for default display
> 
> `blocking_model`* | value: model | custom model data used for blocking display
  
Parry time values.
> `parry_time` | value: time | amount of time you can parry
> 
> `can_coyote` | true/false | allow coyote time parry
> 
> `coyote_time` | value: time | amount of time system listens for a coyote parry after a player is damaged 
  
Event values. These specify a command to run in the functions `cushield:event/<bash_effect|player_parry_effect|entity_parry_effect>`.
> `bash_effect` | value: effect | effect to use when a player bashes
> 
> `player_parry_effect` | value: effect | effect to apply to player when a parry succeeds
> 
> `entity_parry_effect` | value: effect | effect to apply to entity that hit player when a parry succeeds
  
Disabler attributes.
> `disable_resistant` | true/false | can't be disabled when hit with an item in the `#cushield:disabler` item tag/item with `{disabler:1b}`
> 
> `disable_time` | value: time | amount of time that shield gets disabled (default value 100, overridden if specified)
  
Arrow reflection.
> `can_reflect_arrows` | true/false | weather the shield can reflect blocked arrows

## Icon
When a player's shield cooldown is over, an icon is displayed, you can change where this displays/if it displays with a score.

`scoreboard players set icon= cush.main <0..2>` configures the value
> `0` | disables the icon from displaying for all players.
>
> `1` | displays the icon on a subtitle, this overrides any current titles, and resets the title times to the default value when it is done displaying. You can change the times it sets back to by modifying the `title times` command in the function `cushield:event/reset_title_times`. This is the default value.
>
> `2` | displays the icon in the actionbar.

If you want to disable a specific player from seeing the icon, you can set the player's `cush.title` score to `-1`. To re-enable it, just set the value to `0`.

## Footnotes
### 1: durability
Since the item that is being used for the shields is `carrot_on_a_stick`, there is only 25 possible durabilities to display all damage values for the shields. This means that the `f3+h` "Durability" value will be inaccurate unless the maximum durability of your shield happens to be 25.
### 2: shulker box
This system modifies the loot table of the standard shulker box, so that it drops dynamically if mined with a `debug_stick`.
