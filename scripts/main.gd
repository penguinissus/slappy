extends Node

var debug = false

func _ready():
	$MultiTargetCamera.add_target($grandma)
	$MultiTargetCamera.add_target($fetus)
