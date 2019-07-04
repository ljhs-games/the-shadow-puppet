extends Node2D

export (PackedScene) var scrap_scene
export var scrap_timer = 3.0
export var max_scrap = 5
export var spawn_extents = Vector2()

var amount_of_scrap = 0
var cur_scrap_time = 0.0

func _ready():
	randomize()

func _process(delta):
	cur_scrap_time += delta
	if cur_scrap_time >= scrap_timer:
		cur_scrap_time = 0.0
		if amount_of_scrap < max_scrap:
			var cur_scrap = scrap_scene.instance()
			add_child(cur_scrap)
			amount_of_scrap += 1
			cur_scrap.global_position.x = rand_range(global_position.x, global_position.x + spawn_extents.x)
			cur_scrap.global_position.y = rand_range(global_position.y, global_position.y + spawn_extents.y)