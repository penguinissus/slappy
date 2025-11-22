extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -700.0 #how high th player goes

func _physics_process(delta: float) -> void: #delta = time since the last frame
	
	if not is_on_floor():
		velocity += get_gravity() * 2 * delta
		
	if Input.is_action_just_pressed("grandma_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var direction := Input.get_axis("grandma_left", "grandma_right")
	if direction: #right returns 1, left returns -1
		velocity.x = direction * SPEED
		if direction != 0:
			$grandmaIdle.flip_h = (direction == 1)
	else: 
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide() #applies all of this to player
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		#end game
		if collider.name == "fetus":
			get_tree().change_scene_to_file("res://slapaboom.tscn")
		# open door
		if collider.name == "doorLeft":
			collider.get_node("doorLeftSprite").set_frame(1)
			collider.get_node("doorLeftCollision").set_disabled(true)
		if collider.name == "doorRight":
			collider.get_node("doorRightSprite").set_frame(1)
			collider.get_node("doorRightCollision").set_disabled(true)
