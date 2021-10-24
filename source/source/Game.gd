extends Node2D

var is_playing = false
var oldWindowSize;

func _init():
	pass

func _ready():
	var _p = get_tree().get_root().connect("size_changed", self, "myResize")
	oldWindowSize = get_viewport().size
	pass # Replace with function body.

func _process(_delta):
	if Input.is_action_just_released("launch") and not is_playing:
		get_node("StartMenu").visible = false;
		add_child(load("res://source/Manageurs/ManageurNiveau.tscn").instance())
		is_playing = true
	if Input.is_action_just_pressed("Exit"):
		get_tree().quit()

func myResize():
	var ratio = Vector2.ZERO
	ratio.x = oldWindowSize.x/get_viewport().size.x
	get_node("Camera2D").zoom.x = get_node("Camera2D").zoom.x*ratio.x
	
	ratio.y = oldWindowSize.y/get_viewport().size.y
	get_node("Camera2D").zoom.y = get_node("Camera2D").zoom.y*ratio.y
	oldWindowSize = get_viewport().size

func scrollCam(nbSlide):
	var dest =get_node("Camera2D").position.x + 1920*nbSlide
	var speed = 1;
	while get_node("Camera2D").position.x < dest:
		print(get_node("Camera2D").position.x)
		get_node("Camera2D").position.x = get_node("Camera2D").position.x + speed
		get_node("Camera2D").force_update_scroll()
