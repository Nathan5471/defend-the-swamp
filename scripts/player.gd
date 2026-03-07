extends CharacterBody2D


const SPEED = 350
const JUMP_VELOCITY = -700

@onready var animated_sprite = $AnimatedSprite2D


func respawn():
	self.global_position = Vector2(35, 254)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if velocity.y < 0:
			animated_sprite.play("Jump")
		
	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
		if is_on_floor():
			animated_sprite.play("Run")
		animated_sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			animated_sprite.play("Idle")

	move_and_slide()
