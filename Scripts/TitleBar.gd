extends Control

func _ready():
	_process(0)

func _process(delta):
	if not get_tree().current_scene.name == "SettingsMenu":
		$DustAmount.show()
		$DustAmount.text = "Meteor Dust: " + str(Globals.meteor_dust)
	else:
		$DustAmount.hide()
