extends Bullet

func _ready():
	damage = Globals.laser_damage * 6
	speed = Globals.laser_speed * 0.5

func shooting_speed():
	return Globals.shooting_speed / 4
