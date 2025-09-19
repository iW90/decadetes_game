extends CharacterBody2D

@export var speed: float = Constants.CHARACTER_SPEED
@export var jump_force: float = Constants.JUMP_FORCE
@export var gravity: float = Constants.GRAVITY

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var z: float = 0.0          # current jump height
var z_velocity: float = 0.0 # vertical speed
var is_jumping: bool = false

func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	velocity = input_vector * speed

	# Handle jump input
	if Input.is_action_just_pressed("ui_select") and not is_jumping:
		z_velocity = -jump_force
		is_jumping = true
		#anim.play("jump")

	# Apply "gravity" on Z axis
	if is_jumping:
		z_velocity += gravity * delta
		z += z_velocity * delta

		if z >= 0.0: # landed
			z = 0.0
			z_velocity = 0.0
			is_jumping = false
			#anim.play("idle")

	# Movement only on ground plane
	move_and_slide()

	# Set animation when not jumping
	if not is_jumping:
		if input_vector != Vector2.ZERO:
			pass
			#anim.play("walk")
		else:
			#anim.play("idle")
			pass

	# Optional: visually offset sprite upwards when jumping
	anim.position.y = z
