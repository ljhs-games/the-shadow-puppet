extends Node2D

export var heal_rate = 5.0

var currently_healing = null
var health = 50.0 setget set_health

func _ready():
	set_process(false)
	$HealthBar.value = health

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

func _input(event):
	if event.is_action_pressed("g_repair") and currently_healing != null and health < 100.0 and currently_healing.mech > 0:
		self.health += 5.0
		currently_healing.mech -= 5.0
		$FixStreamPlayer.pitch_scale = rand_range(0.9, 1.1)
		$FixStreamPlayer.playing = true

func set_health(new_health):
	health = clamp(new_health, 0.0, 100.0)
	if health <= 0.0:
		get_node("/root/Game").gameover()
	$HealthBar.value = health