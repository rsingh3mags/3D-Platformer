extends CharacterBody3D
# Speed velocity
var speed = -3
# Adds gravity 
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
# Variable used for ledge chcking
var facing_right = false

# Gravity speed it determined for the enemy
func _physics_process(delta):
# When enemy is not on the floor pull him downwards
	if not is_on_floor():
		velocity.y -= gravity * delta
# Mechanism for ledge checking.
# If ledge is discovered flip direction
	if !$Left.is_colliding() && is_on_floor():
		flip()
# Enemy Velocity
	velocity.x = speed
	move_and_slide()
# Function for fliping the Enemy

func flip():
# Change direction when ledge is found
	facing_right = !facing_right
	scale.x = scale.x * -1
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1
