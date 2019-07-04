extends Node2D

export (NodePath) var dispenser_path
export (NodePath) var player_path
export (PackedScene) var shadow_enemy_pack

onready var dispenser_node = get_node(dispenser_path)
onready var player_node = get_node(player_path)

var spawn_time = 3.0
var spawn_decrease_per_minute = 1.0

var cur_counter = 0.0

func _ready():
	set_process(false)
	yield(get_tree().create_timer(5.0), "timeout")
	get_node("../MainThemePlayer").play()
	set_process(true)

func _process(delta):
	spawn_time -= (spawn_decrease_per_minute*(1.0/60)*delta)
	cur_counter += delta
	if cur_counter >= spawn_time:
		spawn_guy()
		cur_counter = 0.0

func spawn_guy():
	var cur_enemy = shadow_enemy_pack.instance()
	add_child(cur_enemy)
	cur_enemy.dispenser_coordinates = dispenser_node.global_position
	cur_enemy.player_node = player_node
	cur_enemy.global_position.x = randi()%2 * 600.0
	cur_enemy.global_position.y = rand_range(0, 500.0)
#	print("spawning!")