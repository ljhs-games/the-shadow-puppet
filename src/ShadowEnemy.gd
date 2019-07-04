extends Area2D

export var damage_rate = 5.0
export var move_speed = 100.0

var dispenser_coordinates = Vector2(300.0, 0.0)
var target_dissasembly = null

func _process(delta):
	if target_dissasembly != null:
		target_dissasembly.health -= damage_rate*delta
	rotation = global_position.angle_to_point(dispenser_coordinates) + PI
	if (dispenser_coordinates - global_position).length() <= 50.0:
		return
	global_position += (dispenser_coordinates - global_position).normalized()*move_speed*delta

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