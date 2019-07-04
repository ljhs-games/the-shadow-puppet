extends Node2D

export var heal_rate = 5.0

var currently_healing = null

func _process(delta):
	if currently_healing == null:
		set_process(false)
		return
	currently_healing.health += heal_rate*delta

func _on_HealingArea2D_body_entered(body):
	if body.is_in_group("player"):
		currently_healing = body
		$AudioStreamPlayer2D.playing = true
		set_process(true)


func _on_HealingArea2D_body_exited(body):
	if body.is_in_group("player"):
		currently_healing = null
		$AudioStreamPlayer2D.playing = false
		set_process(false)
