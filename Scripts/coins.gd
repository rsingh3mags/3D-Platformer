extends Area3D
# Signals to global
signal coins_collected

# Set metadata for the coin
func _ready():
	set_meta("coin", 1)

# When player enters remove coin
func _on_body_entered(body):
	if body.name == "Player":
		Global.coins_collected += 1
		coins_collected.emit()
		queue_free()
