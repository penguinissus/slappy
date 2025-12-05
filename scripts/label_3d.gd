extends Label3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("launch"):
		self.text = "Press X to restart"
	if Input.is_action_just_pressed("restart"):
			get_tree().change_scene_to_file("res://menu.tscn")
