extends Area3D

signal coins_collected

func _on_body_entered(body):
	if body.name == "Player":
		queue_free()
