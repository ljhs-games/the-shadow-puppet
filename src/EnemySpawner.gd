extends Node2D

var spawn_time = 3.0
var spawn_decrease_per_minute = 1.0

var cur_counter = 0.0

func _ready():
	set_process(false)
	yield(get_tree().create_timer(1.0), "timeout")
	set_process(true)

func _process(delta):
	spawn_time -= (spawn_decrease_per_minute*(1.0/60)*delta)
	cur_counter += delta
	if cur_counter >= spawn_time:
		spawn_guy()
		cur_counter = 0.0

func spawn_guy():
	print("spawning!")