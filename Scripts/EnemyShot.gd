extends "res://Scripts/Laser.gd"

export var divisor = 10.0

func _ready():
	damage = Globals.calc_meteor_life() / divisor
