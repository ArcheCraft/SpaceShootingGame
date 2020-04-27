extends Area2D

export var size = ""
export var movement_speed = 100
export var dust = 0

export var max_health = 1
var health = 1

const hb_margin_big_left = -50
const hb_margin_big_top = 55
const hb_margin_big_right = 50
const hb_margin_big_bottom = 65

const hb_margin_medium_left = -25
const hb_margin_medium_top = 30
const hb_margin_medium_right = 25
const hb_margin_medium_bottom = 35

const hb_margin_small_left = -15
const hb_margin_small_top = 20
const hb_margin_small_right = 15
const hb_margin_small_bottom = 25

const hb_margin_tiny_left = -10
const hb_margin_tiny_top = 15
const hb_margin_tiny_right = 10
const hb_margin_tiny_bottom = 18

func _ready():
	set_shape()
	set_health_bar()
	look_at(get_tree().root.find_node("Player", true, false).position)

func set_health_bar():
	if "Big" in size:
		$HealthBar.margin_left = hb_margin_big_left
		$HealthBar.margin_top = hb_margin_big_top
		$HealthBar.margin_right = hb_margin_big_right
		$HealthBar.margin_bottom = hb_margin_big_bottom
	if "Medium" in size:
		$HealthBar.margin_left = hb_margin_medium_left
		$HealthBar.margin_top = hb_margin_medium_top
		$HealthBar.margin_right = hb_margin_medium_right
		$HealthBar.margin_bottom = hb_margin_medium_bottom
	if "Small" in size:
		$HealthBar.margin_left = hb_margin_small_left
		$HealthBar.margin_top = hb_margin_small_top
		$HealthBar.margin_right = hb_margin_small_right
		$HealthBar.margin_bottom = hb_margin_small_bottom
	if "Tiny" in size:
		$HealthBar.margin_left = hb_margin_tiny_left
		$HealthBar.margin_top = hb_margin_tiny_top
		$HealthBar.margin_right = hb_margin_tiny_right
		$HealthBar.margin_bottom = hb_margin_tiny_bottom
	
	health = max_health
	
	$HealthBar.max_value = max_health
	update_health_bar()
	
	$HealthBar.show()

func update_health_bar():
	$HealthBar.value = health

func hide_all():
	$Big1.hide()
	$Big2.hide()
	$Big3.hide()
	$Big4.hide()
	$Medium1.hide()
	$Medium2.hide()
	$Small1.hide()
	$Small2.hide()
	$Tiny1.hide()
	$Tiny2.hide()
	$ShapeBig1.disabled = true
	$ShapeBig2.disabled = true
	$ShapeBig3.disabled = true
	$ShapeBig4.disabled = true
	$ShapeMedium1.disabled = true
	$ShapeMedium2.disabled = true
	$ShapeSmall1.disabled = true
	$ShapeSmall2.disabled = true
	$ShapeTiny1.disabled = true
	$ShapeTiny2.disabled = true

func set_shape():
	hide_all()
	if size == "Big1":
		$Big1.show()
		$ShapeBig1.disabled = false
	if size == "Big2":
		$Big2.show()
		$ShapeBig2.disabled = false
	if size == "Big3":
		$Big3.show()
		$ShapeBig3.disabled = false
	if size == "Big4":
		$Big4.show()
		$ShapeBig4.disabled = false
	if size == "Medium1":
		$Medium1.show()
		$ShapeMedium1.disabled = false
	if size == "Medium2":
		$Medium2.show()
		$ShapeMedium2.disabled = false
	if size == "Small1":
		$Small1.show()
		$ShapeSmall1.disabled = false
	if size == "Small2":
		$Small2.show()
		$ShapeSmall2.disabled = false
	if size == "Tiny1":
		$Tiny1.show()
		$ShapeTiny1.disabled = false
	if size == "Tiny2":
		$Tiny2.show()
		$ShapeTiny2.disabled = false

func _physics_process(delta):
	var width = get_viewport().get_visible_rect().size.x
	var height = get_viewport().get_visible_rect().size.y
	
	translate(transform.x * movement_speed * delta)
	if position.x < -10 or position.x > width + 10 or position.y < -10 or position.y > height + 10:
		queue_free()

func _on_Meteor_area_entered(area):
	if "Laser" in area.name:
		health -= area.damage
	
	if health <= 0:
		health = 0
		queue_free()
		area.queue_free()
		Globals.add_dust(dust)
	
	update_health_bar()
