extends Control

signal item_bought(item_name, old_count, new_count, old_effect, new_effect, bonus_to_apply)
signal to_initialize()

export var item_name = ""
export var max_count = 0
export var infinite = false
export var current_effect = ""
export var next_effect = ""
export var next_bonus = ""
export(Texture) var visualization_graphic
export var current_price = 0
export var next_price = 0

var curr_count = 0
var active = true

var not_enough_md = false

func _ready():
	pass

func set_stuff():
	$BuyButton.text = "Buy " + item_name
	
	if not infinite:
		$Visualization.show()
		$Visualization.value = curr_count
		
		$Count.text = str(curr_count) + " / " + str(max_count)
	else:
		$Visualization.hide()
		
		$Count.text = str(curr_count)
	
	$CurrentEffect.text = "Current: " + current_effect
	if active:
		$NextBonus.text = "Next: " + next_bonus
		$BuyButton.text +=  ": " + str(current_price) + " MD"
		
		$GrayOut.hide()
		$NextBonus.show()
	else:
		$BuyButton.disabled = true
		
		$GrayOut.show()
		$NextBonus.hide()
	
	$NotEnoughMD.visible = not_enough_md

func _on_BuyButton_pressed():
	if Globals.enough_dust(current_price):
		Globals.remove_dust(current_price)
		
		if curr_count < max_count or infinite:
			curr_count += 1
		if curr_count >= max_count and not infinite:
			active = false
		
		current_effect = next_effect
		current_price = next_price
		
		next_effect = ""
		next_bonus = ""
		next_price = 0
		
		emit_signal("item_bought", item_name, curr_count, curr_count + 1, current_effect, next_effect, next_bonus)
		
		not_enough_md = false
	else:
		not_enough_md = true
	
	set_stuff()

func store_state():
	if not Globals.shop_item_states.has(item_name):
		Globals.shop_item_states[item_name] = {}
	Globals.shop_item_states[item_name].item_name = item_name
	Globals.shop_item_states[item_name].max_count = max_count
	Globals.shop_item_states[item_name].infinite = infinite
	Globals.shop_item_states[item_name].current_effect = current_effect
	Globals.shop_item_states[item_name].next_effect = next_effect
	Globals.shop_item_states[item_name].next_bonus = next_bonus
	Globals.shop_item_states[item_name].visualization_graphic = visualization_graphic
	Globals.shop_item_states[item_name].curr_count = curr_count
	Globals.shop_item_states[item_name].active = active
	Globals.shop_item_states[item_name].current_price = current_price
	Globals.shop_item_states[item_name].next_price = next_price

func restore_state():
	if Globals.shop_item_states.has(item_name):
		item_name = Globals.shop_item_states[item_name].item_name
		max_count = Globals.shop_item_states[item_name].max_count
		infinite = Globals.shop_item_states[item_name].infinite
		current_effect = Globals.shop_item_states[item_name].current_effect
		next_effect = Globals.shop_item_states[item_name].next_effect
		next_bonus = Globals.shop_item_states[item_name].next_bonus
		visualization_graphic = Globals.shop_item_states[item_name].visualization_graphic
		curr_count = Globals.shop_item_states[item_name].curr_count
		active = Globals.shop_item_states[item_name].active
		current_price = Globals.shop_item_states[item_name].current_price
		next_price = Globals.shop_item_states[item_name].next_price
		
	else:
		emit_signal("to_initialize")
		
	$Visualization.texture_progress = visualization_graphic
	$Visualization.max_value = max_count
	
	set_stuff()
