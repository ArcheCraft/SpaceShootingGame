extends Control

func _ready():
	pass # Replace with function body.

func _on_ExitButton_pressed():
	$QuitButton.hide()
	$QuitAccept.show()
	$QuitDecline.show()

func _on_QuitAccept_pressed():
	get_tree().quit()

func _on_QuitDecline_pressed():
	$QuitButton.show()
	$QuitAccept.hide()
	$QuitDecline.hide()

func _on_PlayButton_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")

func _on_ShopButton_pressed():
	get_tree().change_scene("res://Scenes/ShopMenu.tscn")

func _on_SettingsButton_pressed():
	get_tree().change_scene("res://Scenes/SettingsMenu.tscn")
