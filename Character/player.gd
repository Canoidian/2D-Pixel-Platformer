extends CharacterBody2D


@export var speed : float = 200.0
@export var jump_velocity : float = -150.0
@export var double_jump_velocity : float = -100

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false
var animation_locked : bool = false
var an_direction : Vector2 = Vector2.ZERO

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		has_double_jumped = false

	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			# normal jump
			velocity.y = jump_velocity
		elif not has_double_jumped:
			# doulbe jump in air
			velocity.y += double_jump_velocity
			has_double_jumped = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var	direction = Input.get_axis("left", "right")
	
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()


func update_animation():
	if not animation_locked:
		if an_direction != Vector2.ZERO:
			animated_sprite.play("run")
	else:
		animated_sprite.play("idle")