extends Area2D

onready var damage = Globals.laser_damage

func _ready():
	pass

func _physics_process(delta):
	var width = get_viewport().get_visible_rect().size.x
	var height = get_viewport().get_visible_rect().size.y
	
	translate(-transform.y * Globals.laser_speed * delta)
	if position.x < 0 or position.x > width or position.y < 0 or position.y > height:
		queue_free()
