extends CharacterBody3D
class_name Player
const ACCELERATION = 300
const FRICTION = 0.85
const JUMP_VELOCITY = 4
# Variable for jump velocity in air
var jump_velocity_in_air= 5
var jump_countair = 0
var max_jumpsair = 2
var jump_count = 0
var max_jumps = 1
# when player is alive
var state = "alive"
# variable for speed of player 
var speed = 1.5
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# When the player is alive, handle all movement, animations, and interactions
	if state == "alive":
		# If player is on the wall, increase jump velocity and play animation if moving upwards
		if is_on_wall():
			jump_velocity_in_air = 8
			if velocity.y <= 0:
				$AuxScene/AnimationPlayer.play("HangingIdle")

		else: 
			jump_velocity_in_air = 5

		# Apply gravity when not on the floor
		if not is_on_floor():
			velocity.y -= gravity * delta
			
		# Reset jump count and velocity when on the floor
		if is_on_floor():
			jump_count = 0
			jump_countair = 0
			jump_velocity_in_air = 5
		# Define player direction based on input
		var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

		# Set horizontal velocity based on direction
		if direction:
			velocity.x = direction.x * ACCELERATION * delta
			velocity.z = direction.z * ACCELERATION * delta

		# Handle player rotation based on input direction
		if input_dir.x > 0:
			$AuxScene/Node.rotation.y = 0
		elif input_dir.x < 0:
			$AuxScene/Node.rotation.y = PI

		# Play animations based on movement and state
		if direction and is_on_floor():
			$AuxScene/AnimationPlayer.play("Running(1)")
		elif abs(velocity.x) <= 2 and is_on_floor():
			$AuxScene/AnimationPlayer.play("StandingW_BriefcaseIdle")
		elif not is_on_floor() and not is_on_wall() and velocity.y < 0.0001:
			$AuxScene/AnimationPlayer.play("FallingIdle")

		# Handle jumps on ground and in the air
		if Input.is_action_just_pressed("ui_accept") and jump_count < max_jumps:
			velocity.y = JUMP_VELOCITY
			jump_count += 1
			$AuxScene/AnimationPlayer.play("RunningJump")
		elif Input.is_action_just_pressed("ui_accept") and not is_on_floor() and jump_countair < max_jumpsair:
			velocity.y = jump_velocity_in_air
			jump_countair += 1
			$AuxScene/AnimationPlayer.play("RunningJump")
		# Final movement adjustments with friction applied
		move_and_slide()
		velocity.x *= FRICTION
		velocity.z *= FRICTION


# Function for pressing restart
func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().change_scene_to_file("res://scenes/level_1.tscn")
		Global.coins_collected = 0
		Global.current_time = 0


# When player is on wall the jumo velocity is slower than before.
func check_jump():
	if Input.is_action_just_pressed("ui_accept") and is_on_wall_only():
		velocity = get_wall_normal() * jump_velocity_in_air
		velocity.y += JUMP_VELOCITY * 0.7
		
	check_jump()
# When the player collects the coins
# Respawns player
# Restarts timer
# Turns velocity to 0 so player freezes
func _on_player_area_entered(area):
	if area.has_meta("coin"):
		jump_countair = 0
		
	if area.has_meta("death"):
		state = "dead"
		velocity.x = 0 
		velocity.y = 0 
		velocity.z = 0 
		Global.current_time = 0
		$AuxScene/AnimationPlayer.play("StandingW_BriefcaseIdle")
		await get_tree().create_timer(2).timeout 
		get_tree().change_scene_to_file("res://scenes/level_1.tscn")
		Global.coins_collected = 0 
		Global.time = 0
		Global.minutes = 0
		Global.seconds = 0
		Global.msec = 0
		Global.coins_collected = 0
		state = "alive"
