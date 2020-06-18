extends Area2D

var shoot_ready = true
var regenerate = true

var health = 0.0
var max_health = 0.0
export var shooting_speed = 30
var movement_speed = 0
var dust = 0

var in_range = false

var timeout = 0.5

onready var player = get_tree().root.find_node("Player", true, false)

var laser = preload("res://Scenes/EnemyShot.tscn")

func _ready():
	max_health = (Globals.calc_meteor_life() + 5) * 2
	health = max_health
	movement_speed = Globals.player_movement_speed / 2
	dust = Globals.calc_dust(rand_range(1, 100), max_health) * 2.5
	
	$HealthBar.max_value = max_health

func _physics_process(delta):
	timeout -= delta
	
	if shoot_ready and timeout < 0:
		shoot_ready = false
		$ShootTimer.start(1 / shooting_speed)
		var laser_instance = laser.instance()
		laser_instance.transform = transform
		get_parent().add_child(laser_instance)
	
	look_at(player.position)
	rotate(Globals.deg_to_rad(90))
	
	in_range = false
	for area in $PlayerDistance.get_overlapping_areas():
		if area.name == "Player":
			in_range = true
	
	if(in_range):
		translate(transform.x * movement_speed * delta)
	else:
		translate(-transform.y * movement_speed * delta)
	
	update_health_bar()

func update_health_bar():
	$HealthBar.value = health

func _on_Enemy_area_entered(area):
	if health <= 0:
		return
	
	if "Meteor" in area.name:
		health -= area.health
		area.queue_free()
	else:
		health -= area.damage
		area.queue_free()
	
	if health <= 0:
		health = max_health
		get_tree().root.find_node("Game", true, false).meteor_spawning = true
		queue_free()

func _on_ShootTimer_timeout():
	shoot_ready = true

func _on_RegenTimer_timeout():
	regenerate = true
