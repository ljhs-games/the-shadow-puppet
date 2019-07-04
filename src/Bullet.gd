extends Area2D

export var velocity = 300.0
var direction: Vector2 = Vector2()

func _ready():
	set_process(false)

func _process(delta):
	global_position += direction*velocity*delta

func go(direction_vector: Vector2):
	direction = direction_vector
	rotation = direction.angle()
	set_process(true)

func _on_Bullet_body_entered(body):
	if body.is_in_group("walls"):
		hit_wall()

func hit_wall():
	set_process(false)
	$AnimationPlayer.play("bullet-hit-wall")