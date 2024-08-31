extends CharacterBody2D

@onready var state_machine = $AnimationTree["parameters/playback"]
@export var World: Node2D
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 2000 #ProjectSettings.get_setting("physics/2d/default_gravity")
@export var antiGravity: float = -1100.0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		state_machine.travel('idle_anim')

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jump()
		
	# if jump is held, jump higher by reducing gravity
	if (!is_on_floor() && (Input.is_action_pressed("ui_accept") or is_pressed) && velocity.y < 0):
		velocity.y += antiGravity * delta
	
	move_and_slide()
	
func jump():
	state_machine.travel("kickflip")
	velocity.y = JUMP_VELOCITY
	
func damage():
	World.reset()
	
var is_pressed = false
func _unhandled_input(event):
	if event is InputEventScreenTouch and is_on_floor():
		jump()
	
	if event is InputEventScreenTouch and event.pressed:
		is_pressed = true
	else:
		is_pressed = false
