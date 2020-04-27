extends Node

export var player_movement_speed_base = 200
export var player_movement_speed_step = 40
var player_movement_speed = 0
export var player_movement_speed_price_base = 10000
export var player_movement_speed_price_step = 5000
var player_movement_speed_price = 0

export var player_health_base = 20
export var player_health_step = 10
var max_player_health = 0
var player_health: float = 0
export var player_health_price_base = 12500
export var player_health_price_step = 15000
var player_health_price

export var player_regeneration_speed = 2
export var player_rotation_speed = 10

export var laser_speed_base = 1500
export var laser_speed_step = 100
var laser_speed = 0
export var laser_speed_price_base = 5000
export var laser_speed_price_step = 8500
var laser_speed_price = 0

export var dust_player_bonus_step = 100
var dust_player_bonus = 0
export var dust_player_bonus_price_base = 10000
export var dust_player_bonus_price_step = 15000
var dust_player_bonus_price = 0

export var laser_damage_base = 4
export var laser_damage_step = 2
var laser_damage = 0
export var laser_damage_price_base = 12500
export var laser_damage_price_step = 17500
var laser_damage_price = 0

export var shooting_speed_base = 10.0
export var shooting_speed_step = 1.5
var shooting_speed = 0
export var shooting_speed_price_base = 15000
export var shooting_speed_price_step = 20000
var shooting_speed_price = 0


export var meteor_life_time_multiplier = 1.025
var meteor_life_multiplier = 1

export var dust_multilpier_mouse = 0.3
export var normal_dust_multiplier = 1
var dust_multiplier = 1

export var dust_bonus_time_multiplier = 5
var dust_bonus = 0

export var meteor_speed_time_multiplier = 1.005
var meteor_speed_muliplier = 1

export var meteor_time_time_multiplier = 0.975
var meteor_time_multiplier = 1

var shop_item_states = {}

export var meteor_dust_base = 0
var meteor_dust = 0

var mouse_control = false

var elapsed_time = 0.0
var last_multiplied = 0.0


func _ready():
	randomize()
	
	laser_damage = laser_damage_base
	laser_speed = laser_speed_base
	player_movement_speed = player_movement_speed_base
	shooting_speed = shooting_speed_base
	max_player_health = player_health_base
	player_health = player_health_base
	
	laser_damage_price = laser_damage_price_base
	player_movement_speed_price = player_movement_speed_price_base
	laser_speed_price = laser_speed_price_base
	dust_player_bonus_price = dust_player_bonus_price_base
	shooting_speed_price = shooting_speed_price_base
	player_health_price = player_health_price_base
	
	meteor_dust = meteor_dust_base

func _process(delta):
	if mouse_control:
		dust_multiplier = dust_multilpier_mouse
	else:
		dust_multiplier = normal_dust_multiplier
	
	if get_tree().current_scene.name == "Game":
		elapsed_time += delta
	
	dust_bonus = dust_bonus_time_multiplier * elapsed_time
	
	while elapsed_time - last_multiplied > 1.0:
		last_multiplied += 1.0
		meteor_time_multiplier *= meteor_time_time_multiplier
		meteor_speed_muliplier *= meteor_speed_time_multiplier
		meteor_life_multiplier *= meteor_life_time_multiplier

func calc_meteor_life():
	return int(rand_range(3, 9) * meteor_life_multiplier)

func calc_speed_of_meteor():
	return int(rand_range(50, 200) * meteor_speed_muliplier)

func calc_time_til_next_meteor():
	return int(rand_range(0.3, 1.7) * meteor_time_multiplier)

func calc_dust(dust, meteor_life):
	return int((dust + dust_player_bonus + dust_bonus * dust_multiplier) * dust_multiplier) * meteor_life

func add_dust(count):
	meteor_dust += count

func enough_dust(count):
	return meteor_dust >= count

func remove_dust(count):
	meteor_dust -= count

func deg_to_rad(deg):
	return deg * PI / 180
