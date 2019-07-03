extends Button

export (String, FILE, "*.tscn") var target_scene

func _on_PlayButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(target_scene)