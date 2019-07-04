extends Label

var cur_score = 0.0

func _process(delta):
	cur_score += delta
	GameState.score = floor(cur_score)
	text = str(GameState.score)