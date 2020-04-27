extends Node2D

var meteor = preload("res://Scenes/Meteor.tscn")

func _ready():
	$Player.position = get_viewport().get_visible_rect().size / 2
	$MeteorTimer.wait_time = 1
	$MeteorTimer.start()

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://Scenes/MainMenu.tscn")

func rand_pos_outside_screen():
	var width = get_viewport().get_visible_rect().size.x
	var height = get_viewport().get_visible_rect().size.y
	
	var direction = rand_range(0, 4)
	if direction > 2:
		direction -= 0.0000001
	direction = int(direction)
	if direction == 0:
		return Vector2(-10, rand_range(-10, height + 10))
	if direction == 1:
		return Vector2(rand_range(-10, width + 10), -10)
	if direction == 2:
		return Vector2(width + 10, rand_range(-10, height + 10))
	if direction == 3:
		return Vector2(rand_range(-10, width + 10), height + 10)

func rand_meteor_size():
	var random = int(rand_range(0, 9))
	
	if random == 0:
		return "Big1"
	if random == 1:
		return "Big2"
	if random == 2:
		return "Big3"
	if random == 3:
		return "Big4"
	if random == 4:
		return "Medium1"
	if random == 5:
		return "Medium2"
	if random == 6:
		return "Small1"
	if random == 7:
		return "Small2"
	if random == 8:
		return "Tiny1"
	if random == 9:
		return "Tiny2"

func _on_Timer_timeout():
	$MeteorTimer.wait_time = Globals.calc_time_til_next_meteor()
	$MeteorTimer.start()
	
	var meteor_instance = meteor.instance()
	meteor_instance.position = rand_pos_outside_screen()
	meteor_instance.size = rand_meteor_size()
	meteor_instance.max_health = Globals.calc_meteor_life()
	meteor_instance.movement_speed = Globals.calc_speed_of_meteor()
	meteor_instance.dust = Globals.calc_dust(rand_range(1, 56.7), meteor_instance.max_health)
	
	add_child(meteor_instance)
