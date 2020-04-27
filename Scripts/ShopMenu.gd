extends Control

func _ready():
	for node in get_children():
		if node.has_method("restore_state"):
			node.restore_state()

func _on_ExitButton_pressed():
	for node in get_children():
		if node.has_method("store_state"):
			node.store_state()
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

func _on_DustBonus_item_bought(item_name, old_count, new_count, old_effect, new_effect, bonus_to_apply):
	Globals.dust_player_bonus += Globals.dust_player_bonus_step
	Globals.dust_player_bonus_price += Globals.dust_player_bonus_price_step
	
	update_DustBonus()

func _on_DustBonus_to_initialize():
	$DustBonus.item_name = "Dust Bonus"
	$DustBonus.infinite = true
	$DustBonus.current_effect = " - "
	$DustBonus.current_price = Globals.dust_player_bonus_price
	
	update_DustBonus()

func update_DustBonus():
	$DustBonus.next_effect = "+" + str(Globals.dust_player_bonus + Globals.dust_player_bonus_step) + " Dust from Meteors"
	$DustBonus.next_bonus = "+" + str(Globals.dust_player_bonus_step)
	$DustBonus.next_price = Globals.dust_player_bonus_price + Globals.dust_player_bonus_price_step
	
	$DustBonus.set_stuff()

func _on_PlayerMovementSpeed_item_bought(item_name, old_count, new_count, old_effect, new_effect, bonus_to_apply):
	Globals.player_movement_speed += Globals.player_movement_speed_step
	Globals.player_movement_speed_price += Globals.player_movement_speed_price_step
	
	update_PlayerMovementSpeed()

func _on_PlayerMovementSpeed_to_initialize():
	$PlayerMovementSpeed.item_name = "Movement Speed"
	$PlayerMovementSpeed.max_count = 5
	$PlayerMovementSpeed.current_effect = str(Globals.player_movement_speed) + " Pixels per Second"
	$PlayerMovementSpeed.current_price = Globals.player_movement_speed_price
	
	update_PlayerMovementSpeed()

func update_PlayerMovementSpeed():
	$PlayerMovementSpeed.next_effect = str(Globals.player_movement_speed + Globals.player_movement_speed_step) + " Pixels per Second"
	$PlayerMovementSpeed.next_bonus = "+" + str(Globals.player_movement_speed_step)
	$PlayerMovementSpeed.next_price = Globals.player_movement_speed_price + Globals.player_movement_speed_price_step
	
	$PlayerMovementSpeed.set_stuff()

func _on_LaserDamage_item_bought(item_name, old_count, new_count, old_effect, new_effect, bonus_to_apply):
	Globals.laser_damage += Globals.laser_damage_step
	Globals.laser_damage_price += Globals.laser_damage_price_step
	
	update_LaserDamage()

func _on_LaserDamage_to_initialize():
	$LaserDamage.item_name = "Damage"
	$LaserDamage.infinite = true
	$LaserDamage.current_effect = str(Globals.laser_damage) + " Damge per Shot"
	$LaserDamage.current_price = Globals.laser_damage_price
	
	update_LaserDamage()

func update_LaserDamage():
	$LaserDamage.next_effect = str(Globals.laser_damage + Globals.laser_damage_step) + " Damge per Shot"
	$LaserDamage.next_bonus = "+" +str(Globals.laser_damage_step)
	$LaserDamage.next_price = Globals.laser_damage_price + Globals.laser_damage_price_step
	
	$LaserDamage.set_stuff()

func _on_LaserSpeed_item_bought(item_name, old_count, new_count, old_effect, new_effect, bonus_to_apply):
	Globals.laser_speed += Globals.laser_speed_step
	Globals.laser_speed_price += Globals.laser_speed_price_step
	
	update_LaserSpeed()

func _on_LaserSpeed_to_initialize():
	$LaserSpeed.item_name = "Laser Speed"
	$LaserSpeed.max_count = 15
	$LaserSpeed.current_effect = str(Globals.laser_speed) + " Pixels per Second"
	$LaserSpeed.current_price = Globals.laser_speed_price
	
	update_LaserSpeed()

func update_LaserSpeed():
	$LaserSpeed.next_effect = str(Globals.laser_speed + Globals.laser_speed_step) + " Pixels per Second"
	$LaserSpeed.next_bonus = "+" + str(Globals.laser_speed_step)
	$LaserSpeed.next_price = Globals.laser_speed_price + Globals.laser_speed_price_step
	
	$LaserSpeed.set_stuff()

func _on_ShootingSpeed_item_bought(item_name, old_count, new_count, old_effect, new_effect, bonus_to_apply):
	Globals.shooting_speed += Globals.shooting_speed_step
	Globals.shooting_speed_price += Globals.shooting_speed_price_step
	
	update_ShootingSpeed()

func _on_ShootingSpeed_to_initialize():
	$ShootingSpeed.item_name = "Shooting Speed"
	$ShootingSpeed.max_count = 20
	$ShootingSpeed.current_effect = str(Globals.shooting_speed) + " Shots per Second"
	$ShootingSpeed.current_price = Globals.shooting_speed_price
	
	update_ShootingSpeed()

func update_ShootingSpeed():
	$ShootingSpeed.next_effect = str(Globals.shooting_speed + Globals.shooting_speed_step) + " Shots per Second"
	$ShootingSpeed.next_bonus = "+" + str(Globals.shooting_speed_step)
	$ShootingSpeed.next_price = Globals.shooting_speed_price + Globals.shooting_speed_price_step
	
	$ShootingSpeed.set_stuff()
