extends Area2D

export var mech_amount = 10.0

func _on_Scrap_body_entered(body):
	if body.is_in_group("player"):
		if body.mech < 100.0:
			body.mech += mech_amount
			get_parent().amount_of_scrap -= 1
			queue_free()