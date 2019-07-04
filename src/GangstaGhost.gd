extends KinematicBody2D

class_name gangsta_ghost

signal health_changed(new_health)
signal mech_changed(new_mech)

export var max_velocity = 600.0
export var move_accel = 350.0
export var move_dampening = 150.0
export var bounce_amount = 0.8
export (PackedScene) var bullet_scene

var accel = Vector2()
var velocity = Vector2()
var go_right = 0
var go_left = 0
var go_up = 0
var go_down = 0
var health = 100.0 setget set_health
var mech = 0.0 setget set_mech

func _ready():
	move_accel += move_dampening

func _physics_process(delta):
	accel = get_direction_vector()*move_accel
	velocity += accel*delta
	velocity = vector_clamp(velocity, -max_velocity, max_velocity)
	velocity = reduce_vector(velocity, move_dampening*delta)
#	print("stats: ", global_position, " | ", velocity, " | ", accel)
	var collision_information: KinematicCollision2D = move_and_collide(velocity*delta)
	if collision_information != null:
		velocity = velocity.bounce(collision_information.normal)*bounce_amount

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

func get_direction_vector() -> Vector2:
	return Vector2(go_right + -go_left, go_down + -go_up)

func fire():
	if $AnimationPlayer.current_animation == "gun-bob":
		$AnimationPlayer.play("gun-fire")
		$AnimationPlayer.queue("gun-bob")
		var target_position = get_viewport().get_mouse_position()
		var local_position = $Gun/Sprite.get_global_transform_with_canvas().origin
		var direction = (target_position - local_position).normalized()
		var cur_bullet = bullet_scene.instance()
		get_node("../Bullets").add_child(cur_bullet)
		cur_bullet.global_position = $Gun/Sprite.global_position
		cur_bullet.go(direction)

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
	elif event.is_action_pressed("g_up"):
		go_up = 1
	elif event.is_action_released("g_up"):
		go_up = 0
	elif event.is_action_pressed("g_down"):
		go_down = 1
	elif event.is_action_released("g_down"):
		go_down = 0
	elif event.is_action_pressed("g_fire"):
		fire()

func set_health(new_health):
	health = clamp(new_health, 0.0, 100.0)
	emit_signal("health_changed", health)

func set_mech(new_mech):
	mech = clamp(new_mech, 0.0, 100.0)
	emit_signal("mech_changed", mech)