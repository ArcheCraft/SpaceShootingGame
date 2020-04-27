extends Area2D

var shoot_ready = true

var laser = preload("res://Scenes/Laser.tscn")

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_action_pressed("ui_up"):
		translate(-transform.y * Globals.player_movement_speed * delta)
	if Globals.mouse_control:
		look_at(get_viewport().get_mouse_position())
		rotate(Globals.deg_to_rad(90))
	else:
		if Input.is_action_pressed("ui_left"):
			rotate(Globals.player_rotation_speed * delta)
		if Input.is_action_pressed("ui_right"):
			rotate(-Globals.player_rotation_speed * delta)
	if Input.is_action_pressed("ui_fire") and shoot_ready:
		shoot_ready = false
		$ShootTimer.start(1 / Globals.shooting_speed)
		var laser_instance = laser.instance()
		laser_instance.transform = transform
		get_parent().add_child(laser_instance)

func _on_Player_area_entered(area):
	if "Meteor" in area.name:
		get_tree().change_scene("res://Scenes/MainMenu.tscn")

func _on_ShootTimer_timeout():
	shoot_ready = true
