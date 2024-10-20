extends CharacterBody3D
class_name Player
const ACCELERATION = 300
const FRICTION = 0.85
const JUMP_VELOCITY = 4
var JUMPVELOCITY_INAIR = 5
var jump_countair = 0
var max_jumpsair = 2
var jump_count = 0
var max_jumps = 1
var state = "alive"
var facing_right = false
var speed = 1.5
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
	
func _physics_process(delta):
	if state == "alive":
		#if player is on floor on not.
		# Add the gravity
		
		if is_on_wall():
			JUMPVELOCITY_INAIR = 8
			$AuxScene/AnimationPlayer.play("HangingIdle")
		else: 
			JUMPVELOCITY_INAIR = 5
		
		
		if not is_on_floor():
			velocity.y -= gravity * delta
		#When player touches the floor all jump counters reset.
		if is_on_floor():
			jump_count = 0
			jump_countair = 0
			JUMPVELOCITY_INAIR = 5

		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and jump_count < max_jumps:
			velocity.y = JUMP_VELOCITY
			jump_count += 1
			if jump_countair >= 1:
				$AuxScene/AnimationPlayer.play("RunningForwardFlip")
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
		
		if direction and is_on_floor():
			$AuxScene/AnimationPlayer.play("Running(1)")
		
		elif not is_on_floor() and not is_on_wall():
			$AuxScene/AnimationPlayer.play("RunningJump")
			
		elif velocity.x <= 2:
			$AuxScene/AnimationPlayer.play("StandingW_BriefcaseIdle")
		
	# for stoping player and causing decelration.
		move_and_slide()
		velocity.x *= FRICTION
		velocity.z *= FRICTION

func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().change_scene_to_file("res://scenes/level_1.tscn")
		Global.coins_collected = 0

	#when player is on wall the jumo velocity is slower than before.
func check_jump():
	if Input.is_action_just_pressed("ui_accept") and is_on_wall_only():
		velocity = get_wall_normal() * JUMPVELOCITY_INAIR
		velocity.y += JUMP_VELOCITY * 0.7
		
	#check Jump
	check_jump()

func _on_player_area_entered(area):
	if area.has_meta("coin"):
		jump_countair = 0
	if area.has_meta("death"):
		state = "dead"
		velocity.x = 0 
		velocity.y = 0 
		velocity.z = 0 
		await get_tree().create_timer(2).timeout 
		position.x = -18
		position.y = 10.227
		position.z = 1
		state = "alive"
