extends CharacterBody2D

@export var World: Node2D
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jump()

	move_and_slide()
	
func jump():
	velocity.y = JUMP_VELOCITY
	
func damage():
	World.reset()
	
func _unhandled_input(event):
	if event is InputEventScreenTouch and is_on_floor():
		jump()
	
