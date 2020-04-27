extends Node

export(Texture) var texture

func _ready():
	get_tree().get_root().connect("size_changed", self, "create_background")
	create_background()

func create_background():
	var width = get_viewport().get_visible_rect().size.x / texture.get_width() + 1.5
	var height = get_viewport().get_visible_rect().size.y / texture.get_height() + 1.5
	
	for i in range(width):
		for j in range(height):
			var x = i * texture.get_width()
			var y = j * texture.get_height()
			var sprite = Sprite.new()
			sprite.texture = texture
			sprite.position.x = x
			sprite.position.y = y
			add_child(sprite)
