extends "res://Scripts/Laser.gd"

export var divisor = 4

func _ready():
	damage = Globals.calc_meteor_life() / divisor
