extends Area3D
# export variable level
@export var  level = ""
# signals when player enters the level
signal player_entered(level)

# when the player enters the doot change scene to level
func _on_body_entered(body):
	if body.name == "Player":
		player_entered.emit(level)
