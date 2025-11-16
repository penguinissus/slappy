extends CharacterBody2D
@onready var _crawl_animation = $AnimatedSprite2D
const SPEED = 500.0
const JUMP_VELOCITY = -900.0

func _ready() -> void:
	add_to_group("player")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("fetus_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("fetus_left", "fetus_right")
	if direction:
		velocity.x = direction * SPEED
		_crawl_animation.play()
		
	#if Input.gets("fetus_left"):
		#velocity.x =  speed
		#_crawl_animation.play()

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		_crawl_animation.stop()

	move_and_slide()
