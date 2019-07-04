extends Area2D

export var max_velocity = 600.0
export var move_accel = 350.0
export var move_dampening = 150.0

var accel = Vector2()
var velocity = Vector2()
var go_right = 0
var go_left = 0

func _ready():
	move_accel += move_dampening

func _physics_process(delta):
	accel = Vector2(get_direction_constant(), 0)*move_accel
	velocity += accel*delta
	velocity = vector_clamp(velocity, -max_velocity, max_velocity)
	velocity = reduce_vector(velocity, move_dampening*delta)
#	print("stats: ", global_position, " | ", velocity, " | ", accel)
	global_position += velocity*delta

func vector_clamp(in_vec: Vector2, clamp_min: float, clamp_max: float) -> Vector2:
	in_vec.x = clamp(in_vec.x, clamp_min, clamp_max)
	in_vec.y = clamp(in_vec.y, clamp_min, clamp_max)
	return in_vec

func reduce_vector(in_vec: Vector2, amount: float) -> Vector2:
	in_vec.x = bring_to_zero(in_vec.x, amount)
	in_vec.y = bring_to_zero(in_vec.y, amount)
	return in_vec

func bring_to_zero(in_val: float, amount: float) -> float:
	if abs(in_val) < amount:
		return 0.0
	return in_val - (amount*sign(in_val))

func get_direction_constant() -> int:
	return go_right + -go_left

func _input(event):
	if event.is_action_pressed("g_right"):
		go_right = 1
		$Sprite.flip_h = false
		$Gun.scale.x = 1
	elif event.is_action_released("g_right"):
		go_right = 0
	elif event.is_action_pressed("g_left"):
		go_left = 1
		$Sprite.flip_h = true
		$Gun.scale.x = -1
	elif event.is_action_released("g_left"):
		go_left = 0