extends CharacterBody3D
const ACCELERATION = 300
const FRICTION = 0.85
const JUMP_VELOCITY = 4
const JUMPVELOCITY_INAIR = 6
var jump_countair = 0
var max_jumpsair = 2
var jump_count = 0
var max_jumps = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	#if is_on_wall(): velocity.y = MAX_WALL_SLIDE_SPEED * delta
	if is_on_wall_only():
		jump_countair =- 1
	#if player is on floor on not.
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	#When player touches the floor all jump counters reset.
	if is_on_floor():
		jump_count = 0
		jump_countair = 0
		
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jump_count < max_jumps:
		velocity.y = JUMP_VELOCITY
		jump_count += 1

	#player jump counter in air.
	elif Input.is_action_just_pressed("ui_accept") and not is_on_floor() and jump_countair < max_jumpsair:
		velocity.y = JUMPVELOCITY_INAIR
		jump_countair += 1

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# how direction is defined
	if direction:
		velocity.x = direction.x * ACCELERATION * delta
		velocity.z = direction.z * ACCELERATION * delta

	# for stoping player and causing decelration.
	move_and_slide()
	velocity.x *= FRICTION
	velocity.z *= FRICTION


	# when player is on wall the jumo velocity is slower than before.
func check_jump():
	if Input.is_action_just_pressed("ui_accept") and is_on_wall_only():
		velocity = get_wall_normal() * JUMPVELOCITY_INAIR
		velocity.y += JUMP_VELOCITY * 0.7
	#check Jump
	check_jump()
