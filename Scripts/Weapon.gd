extends Node2D

class_name Weapon

export var plasma_scene = preload("res://Scenes/Laser.tscn")
export var missile_scene = preload("res://Scenes/Missile.tscn")
export var shotgun_scene = preload("res://Scenes/Scrap.tscn")

enum weapons {
	Plasma, Missile, Shotgun
}

class BulletInfo:
	var bullet: PackedScene
	var bullet_instance: Bullet
	
	func _init(bullet: PackedScene, bullet_instance: Bullet):
		self.bullet = bullet
		self.bullet_instance = bullet_instance

var current_bullet: BulletInfo
var current_num: int

var bullets = {
	weapons.Plasma: BulletInfo.new(plasma_scene, plasma_scene.instance()),
	weapons.Missile: BulletInfo.new(missile_scene, missile_scene.instance()),
	weapons.Shotgun: BulletInfo.new(shotgun_scene, shotgun_scene.instance())
}

var ready = true

func _ready():
	pass

func shoot(pos: Vector2, rot: float, game: Node):
	if not ready:
		return
	
	match current_num:
		weapons.Plasma, weapons.Missile:
			var instance = current_bullet.bullet.instance()
			instance.position = pos
			instance.rotation = rot
			game.add_child(instance)
		weapons.Shotgun:
			for i in range(Globals.shotgun_bullets):
				var a = -Globals.shotgun_spread + i * (2*Globals.shotgun_spread)/(Globals.shotgun_bullets-1)
				var instance = current_bullet.bullet.instance()
				instance.position = pos
				instance.rotation = rot + a
				game.add_child(instance)
	
	ready = false
	$ShootTimer.start(1 / current_bullet.bullet_instance.shooting_speed())

func set_bullet(bullet: int):
	self.current_num = bullet
	self.current_bullet = bullets[bullet]

func _on_ShootTimer_timeout():
	ready = true
