# Custom Shields
This is a system that adds custom shields to Minecraft with configurable attributes. 

For ease of use, there is a [generator](https://www.crowdford.com/tools/shield) that you can use to make shields for this system.

## In this repo

### Datapacks
1. `custom_shield` | The core system for the custom shields
2. entity_hit_detection | My [entity hit detection datapack](https://github.com/gibbsly/ehid), packaged with this system since it is dependent on it to function.

### Resource Pack
The resource pack is required for the shield models and sounds, as well as all text used. The resources for this are intended to be able to be merged into other resource packs, the only file that this should override is the `carrot_on_a_stick` [item model](https://github.com/gibbsly/custom-shields/blob/main/custom_shield_resources/assets/minecraft/models/item/carrot_on_a_stick.json).

There are translations for all the strings used for this in the [`shield/lang`](https://github.com/gibbsly/custom-shields/tree/main/custom_shield_resources/assets/shield/lang) folder. If you would like to contribute to translations, you can create a pull request with an additional lang file.

#### Adding Models
Adding new shield models requires you to create a standard model and a blocking model. There are 2 template models provided in the resource pack that you can use as reference. To display your models, add them to the `CustomModelData` overrides on the `carrot_on_a_stick` [item model](https://github.com/gibbsly/custom-shields/blob/main/custom_shield_resources/assets/minecraft/models/item/carrot_on_a_stick.json), then specify the `CustomModelData` values for each on the `default_model` and `blocking_model` attributes.

# About the shields
Documented below is the core functionality of the shield system.

The function `cushield:give_template_shield` gives you some template shields that you can try out. If you want to generate a shield, there is a generator [here](https://www.crowdford.com/tools/shield).

## Blocking
If you are holding a shield item in your main or offhand, and holding use (right click), you will start blocking. This is immediate, unlike vanilla shields. Shields in your offhand will be prioritized over mainhand shields.
 
### Normal
A normal block has a linear damage reduction that starts at the `block_value` attribute, and goes down to the `minimum_block_value` over the entire duration of `max_time` attribute

### Parry
If a shield can parry, specified by the `parry_time` attribute, and you are hit within the parry window specified by that attribute, you will execute a parry. A parry negates all damage you would have received. 

If any effects are specified within the attributes, they will be applied. 

#### Coyote time
Parries can have coyote time, this is an amount of time, in ticks, after you get hit that you can execute a parry. If a hit would be fatal you will still die since you can't parry when you are dead.

### Arrow reflection
Shields can have an attribute that allows you to reflect an arrow. The speed of the arrow that is reflected is determined by how long you have been blocking, the longer you have been blocking, the slower it is launched.

The speed falloff is doubled for non-parry blocks.

### Disablers
Shields can be disabled for a set duration of time, set by an attribute on the shield, if you block and attack from a disabler item. 

A disabler item is an item in the item tag `#cushield:disabler`, or an item with the nbt `{disabler:1b}` If you want an item that is in the `#cushield:disabler` item tag to not disable a shield you can add the nbt `{disabler:0b}`. 

If you want a shield to not be disabled by a disabler item, you can specify that with the `disable_resistant` attribute.

### Bashing
Shields can execute a bash effect if you sprint while blocking, this is specified with the `block_effect` attribute. 

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

Durability[[1]](https://github.com/gibbsly/custom-shields#1-durability)
> `durability` | value: int | maximum durability (unbreakable if not specified)
  
Values used for damage calculation
> `block_value`*[[2]](https://github.com/gibbsly/custom-shields#2-block-value) | value | maximum amount of damage to block from non-parry block 
> 
> `minimum_block_value` | value | minimum amount of damage to block with a non-parry block, linear falloff from maximum value over the `max_time` attribute's duration (default 0)
  
Model values, these specify what CustomModelData values to use.
> `default_model`* | value: [model](https://github.com/gibbsly/custom-shields/blob/main/custom_shield_resources/assets/minecraft/models/item/carrot_on_a_stick.json) | custom model data used for default display
> 
> `blocking_model`* | value: [model](https://github.com/gibbsly/custom-shields/blob/main/custom_shield_resources/assets/minecraft/models/item/carrot_on_a_stick.json) | custom model data used for blocking display
  
Parry time values.
> `parry_time` | value: time | amount of time you can parry
> 
> `can_coyote` | true/false | allow coyote time parry (must be a byte to work)
> 
> `coyote_time` | value: time | amount of time system listens for a coyote parry after a player is damaged 
  
Event values. These specify a command to run in the functions `cushield:event/<bash_effect|player_parry_effect|entity_parry_effect>`.
> `bash_effect` | value: [effect](https://github.com/gibbsly/custom-shields#adding-effects) | effect to use when a player bashes
> 
> `player_parry_effect` | value: [effect](https://github.com/gibbsly/custom-shields#adding-effects) | effect to apply to player when a parry succeeds
> 
> `entity_parry_effect` | value: [effect](https://github.com/gibbsly/custom-shields#adding-effects) | effect to apply to entity that hit player when a parry succeeds
  
Disabler attributes.
> `disable_resistant` | true/false | can't be disabled when hit with an item in the `#cushield:disabler` item tag/item with `{disabler:1b}`
> 
> `disable_time` | value: time | amount of time that shield gets disabled (default value 50, overridden if specified)
  
Arrow reflection.
> `can_reflect_arrows` | true/false | weather the shield can reflect blocked arrows

## Adding effects
The `bash_effect`, `player_parry_effect`, and `entity_parry_effect` attributes all use an ID system to run effects. The ID you specify runs a command in the corresponding function in the [event](https://github.com/gibbsly/custom-shields/tree/main/custom_shield_datapacks/custom_shield/data/cushield/functions/event) folder. The value is written onto the score `effect= cush.main`, so you can use that to specify what function/command to run based on that score. 

The effect function is run on the player for `bash_effect` and `player_parry_effect`, and run on the entity you parried for `entity_parry_effect`.

There are example commands in the functions that can be safely removed or changed.

## Icon
When a player's shield is on cooldown, an animated icon will be displayed on the actionbar, this can be disabled if needed.

`scoreboard players set icon= cush.main <0..1>` enables or disables the icon for all players.

If you want to disable a specific player from seeing the icon, you can set the player's `cush.title` score to `-1`. To re-enable it, just set the value to `0`.

## Footnotes
### 1: durability
Since the item that is being used for the shields is `carrot_on_a_stick`, there is only 25 possible durabilities to display all damage values for the shields. This means that the `f3+h` "Durability" value will be inaccurate unless the maximum durability of your shield happens to be 25.
### 2: block value
the `block_value` attribute is not required if you have a `parry_time` equal to `max_time`
### 3: shulker box
This system modifies the loot table of the standard shulker box, so that it drops dynamically if mined with a `debug_stick`.

## Credit
**Main Functionality**: [gibbsly](https://github.com/gibbsly) 

**Design**: [Asometric](https://github.com/adri2711), [pearuhdox](https://github.com/pearuhdox)

**[Shield Generator Application](https://www.crowdford.com/tools/shield) and [Inventory Restoration System](https://github.com/McTsts/inv-manipulation)**: [McTsts](https://github.com/McTsts)
