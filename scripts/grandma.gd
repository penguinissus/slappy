extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0 #how high th player goes

func _physics_process(delta: float) -> void: #delta = time since the last frame
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if Input.is_action_just_pressed("grandma_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var direction := Input.get_axis("grandma_left", "grandma_right")
	if direction: #right returns 1, left returns -1
		velocity.x = direction * SPEED
	else: 
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide() #applies all of this to player
