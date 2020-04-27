extends Control

func _ready():
	$MouseControlButton.pressed = Globals.mouse_control

func _on_ExitButton_pressed():
	Globals.mouse_control = $MouseControlButton.pressed
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
