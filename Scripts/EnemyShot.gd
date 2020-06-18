extends Bullet

export var divisor = 10.0

func _ready():
	damage = Globals.calc_meteor_life() / divisor
	speed = Globals.calc_speed_of_meteor() * divisor
