extends CharacterBody3D
const ACCELERATION = 400
const FRICTION = 0.85
const JUMP_VELOCITY = 4
const JUMP_INAIR = 12
const MAX_WALL_SLIDE_SPEED = -120
var jump_countair = 0
var max_jumpsair = 3
var jump_count = 0
var max_jumps = 1
var jumpsmade = 0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if is_on_wall(): velocity.y = MAX_WALL_SLIDE_SPEED * delta
	
	elif not is_on_floor():
		velocity.y -= gravity * delta

	if is_on_floor():
		jump_count = 0
		jump_countair = 0
		
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jump_count < max_jumps:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
	
	elif Input.is_action_just_pressed("ui_accept") and not is_on_floor() and jump_countair < max_jumpsair:
		velocity.y = JUMP_INAIR
		jump_countair += 1
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
			
	if direction:
		velocity.x = direction.x * ACCELERATION * delta
		velocity.z = direction.z * ACCELERATION * delta
	
	move_and_slide()
	velocity.x *= FRICTION
	velocity.z *= FRICTION
	
	
func check_jump():
	if Input.is_action_just_pressed("ui_accept") and is_on_wall_only():
		velocity = get_wall_normal() * JUMP_INAIR
		velocity.y += JUMP_VELOCITY * 0.7
	

	check_jump()
