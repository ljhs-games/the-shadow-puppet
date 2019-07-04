extends Node

signal score_updated(new_score)
var score setget set_score

func set_score(new_score):
	if new_score != score:
		score = new_score
		emit_signal("score_updated", new_score)