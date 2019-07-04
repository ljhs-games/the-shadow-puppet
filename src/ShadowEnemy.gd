extends Area2D

export var damage_rate = 5.0
export var player_hurt_rate = 15.0
export var move_speed = 100.0
export var to_player_move_speed = 300.0

var dispenser_coordinates = Vector2(300.0, 0.0)
var player_node = null
var target_dissasembly = null
var target_player = false
var attacking_player = false

func _ready():
	randomize()
	target_player = (randi()%2) as bool

func _process(delta):
	var target_coords = dispenser_coordinates
	var closing_distance = 50.0
	var cur_move_speed = move_speed
	var cur_damage_rate = damage_rate
	if target_player and player_node != null:
		target_coords = player_node.global_position
		closing_distance = 5.0
		cur_move_speed = to_player_move_speed
		cur_damage_rate = player_hurt_rate
	if target_dissasembly != null:
		target_dissasembly.health -= damage_rate*delta
	rotation = global_position.angle_to_point(target_coords) + PI
	if attacking_player and player_node != null:
		player_node.health -= cur_damage_rate*delta
	if (target_coords - global_position).length() <= closing_distance:
		return
	global_position += (target_coords - global_position).normalized()*cur_move_speed*delta

func _on_ShadowEnemy_area_entered(area):
	if area.is_in_group("dispenser"):
		$DismantlePlayer2D.play()
		target_dissasembly = area.get_parent()
	elif area.is_in_group("bullets"):
		$AnimationPlayer.play("death")
		set_process(false)

func _on_ShadowEnemy_area_exited(area):
	if area.is_in_group("dispenser"):
		$DismantlePlayer2D.playing = false
		target_dissasembly = null

func _on_DismantlePlayer2D_finished():
	if target_dissasembly != null and is_processing() == false:
		$DismantlePlayer2D.pitch_scale = rand_range(0.9, 1.2)
		$DismantlePlayer2D.play()

func _on_ShadowEnemy_body_entered(body):
	if body.is_in_group("player"):
		attacking_player = true
		$HurtPlayerPlayer2D.play()


func _on_ShadowEnemy_body_exited(body):
	if body.is_in_group("player"):
		attacking_player = false
		$HurtPlayerPlayer2D.playing = false

func _on_HurtPlayerPlayer2D_finished():
	if attacking_player:
		$HurtPlayerPlayer2D.pitch_scale = rand_range(0.8, 1.3)
		$HurtPlayerPlayer2D.play()