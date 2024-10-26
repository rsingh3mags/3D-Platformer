extends Area3D
# Export variable level
@export var  level = ""
# Signals when player enters the level
signal player_entered(level)

# When the player enters the doot change scene to level
func _on_body_entered(body):
	if body.name == "Player":
		player_entered.emit(level)
