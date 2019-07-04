extends ProgressBar

export (NodePath) var player_path
export var target_signal_name = ""
export var target_variable_name = ""

onready var player_node: gangsta_ghost = get_node(player_path)

func _ready():
	var connect_successful = player_node.connect(target_signal_name, self, "_on_player_signal")
	assert(connect_successful == OK)
	value = player_node.get(target_variable_name)

func _on_player_signal(new_value):
	value = new_value