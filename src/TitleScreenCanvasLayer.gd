extends CanvasLayer


func _on_CreditsButton_pressed():
	$CreditsSwitcher.play("ToCredits")

func _on_BasicButton_pressed():
	$CreditsSwitcher.play("ToTitleScreen")

func _on_PlayButton_pressed():
	get_node("/root/TitleScreen/TitleScreenAnimation").play("FadeOut")

func goto_game_scene():
	get_tree().change_scene("res://Game.tscn")