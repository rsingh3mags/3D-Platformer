extends CharacterBody3D
# speed velocity
var speed = -3
# adds gravity 
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
# variable used for ledge chcking
var facing_right = false

# Gravity speed it determined for the enemy
func _physics_process(delta):
# when enemy is not on the floor pull him downwards
	if not is_on_floor():
		velocity.y -= gravity * delta
# mechanism for ledge checking.
# if ledge is discovered flip direction
	if !$Left.is_colliding() && is_on_floor():
		flip()
# Enemy Velocity
	velocity.x = speed
	move_and_slide()
# function for fliping the Enemy

func flip():
# change direction when ledge is found
	facing_right = !facing_right
	scale.x = scale.x * -1
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1
