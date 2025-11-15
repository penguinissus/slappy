extends Node

@onready var viewport1 = $Viewports/SubViewportContainer1/SubViewport1
@onready var viewport2 = $Viewports/SubViewportContainer2/SubViewport2
@onready var camera1 = $Viewports/SubViewportContainer1/SubViewport1/Camera2D
@onready var camera2 = $Viewports/SubViewportContainer2/SubViewport2/Camera2D
@onready var world = $Viewports/SubViewportContainer1/SubViewport1/main

func _ready():
	viewport2.world = viewport1.world_2d
