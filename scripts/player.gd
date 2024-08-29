extends CharacterBody2D

@onready var state_machine = $AnimationTree["parameters/playback"]
@export var World: Node2D
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var antiGravity: float = -400.0


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jump()
		
	# if jump is held, jump higher by reducing gravity
	if(!is_on_floor() && Input.is_action_pressed("ui_accept") && velocity.y < 0):
		velocity.y += antiGravity * delta


	move_and_slide()
	
func jump():
	velocity.y = JUMP_VELOCITY
	state_machine.travel("jump_anim")
	
func damage():
	World.reset()
	
func _unhandled_input(event):
	if event is InputEventScreenTouch and is_on_floor():
		jump()
	
