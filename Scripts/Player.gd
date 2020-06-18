extends Area2D

var regenerate = true

onready var weapon: Weapon = Globals.weapon

func _ready():
	Globals.player_health = Globals.max_player_health
	
	$HealthBar.max_value = Globals.max_player_health

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
	if Input.is_action_pressed("ui_fire"):
		weapon.shoot(self.global_position, self.global_rotation, get_parent())
	if regenerate:
		Globals.player_health += (Globals.max_player_health / 10) * delta
		if Globals.player_health > Globals.max_player_health:
			Globals.player_health = Globals.max_player_health
	
	update_health_bar()

func update_health_bar():
	$HealthBar.value = Globals.player_health

func _on_Player_area_entered(area):
	if "Player" in area.name:
		return
	
	if "Meteor" in area.name:
		Globals.player_health -= area.health
		area.queue_free()
		regenerate = false
		$RegenTimer.start(5)
	else:
		Globals.player_health -= area.damage
		area.queue_free()
		regenerate = false
		$RegenTimer.start(5)
	if Globals.player_health <= 0:
		Globals.player_health = Globals.max_player_health
		get_tree().change_scene("res://Scenes/MainMenu.tscn")

func _on_RegenTimer_timeout():
	regenerate = true
