extends CharacterBody2D
#annotations check grandma
const SPEED = 300.0
const JUMP_VELOCITY = -700.0

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * 2 * delta
		
	if Input.is_action_just_pressed("fetus_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var direction := Input.get_axis("fetus_left", "fetus_right")
	if direction:
		velocity.x = direction * SPEED
		if direction != 0:
			$fetusCrawl.flip_h = (direction == 1)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
