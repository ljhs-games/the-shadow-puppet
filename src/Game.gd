extends WorldEnvironment

func _ready():
	GameState.score = 0

func gameover():
	if $WeatherAnimation.current_animation != "Lose":
		$WeatherAnimation.play("Lose")
		$GUI/MarginContainer/MarginContainer2/ScoreLabel.set_process(false)

func onto_score_scene():
	get_tree().change_scene("res://Score.tscn")