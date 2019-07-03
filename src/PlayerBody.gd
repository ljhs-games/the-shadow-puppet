extends KinematicBody2D

const gravity = 20
var velocity = Vector2()

func _physics_process(delta):
	velocity.y += delta * gravity
	
	move_and_slide(velocity, Vector2(0, -1))