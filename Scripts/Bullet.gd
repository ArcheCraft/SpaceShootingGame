extends Node2D

class_name Bullet

var speed: float
var damage: float

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	move(delta)

func move(delta):
	translate(-transform.y * speed * delta)
	if position.x < 0 or position.x > Globals.size_x or position.y < 0 or position.y > Globals.size_y:
		queue_free()

func shooting_speed():
	return 1
