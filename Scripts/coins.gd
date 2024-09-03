extends Area3D
#signals to global
signal coins_collected

func _ready():
	set_meta("coin", 1)

#when player enters remove coin
func _on_body_entered(body):
	if body.name == "Player":
		Global.coins_collected += 1
		coins_collected.emit()
		queue_free()

