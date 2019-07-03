extends CanvasLayer


func _on_CreditsButton_pressed():
	$CreditsSwitcher.play("ToCredits")

func _on_BasicButton_pressed():
	$CreditsSwitcher.play("ToTitleScreen")