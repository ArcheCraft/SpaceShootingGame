extends Bullet

func _ready():
	damage = Globals.laser_damage
	speed = Globals.laser_speed

func shooting_speed():
	return Globals.shooting_speed
