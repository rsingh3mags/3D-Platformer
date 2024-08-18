extends CharacterBody3D

var speed = -1.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var facing_right = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	if !$Left.is_colliding() && is_on_floor():
		flip()

	velocity.x = speed
	move_and_slide()

func flip():
	facing_right = !facing_right

	scale.x = scale.x * -1
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1
