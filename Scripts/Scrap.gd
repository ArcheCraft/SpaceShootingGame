extends Bullet

func _ready():
	damage = Globals.laser_damage / 3
	speed = Globals.laser_speed / 3

func shooting_speed():
	return Globals.shooting_speed / 6
