extends Node2D

var is_playing = false
var oldWindowSize;
var reload = false;
var nbClic = 0;
func _init():
	pass

func _ready():
	var _p = get_tree().get_root().connect("size_changed", self, "myResize")
	oldWindowSize = get_viewport().size
	pass # Replace with function body.

func _process(_delta):
	if Input.is_action_just_released("launch"):
		if not is_playing:
			get_node("StartMenu").visible = false;
			get_node("GameOver").visible = false;
			get_node("ManageurNiveau").visible = true;
			if reload: 
				get_node("ManageurNiveau").reloadNiveau()
			else:
				get_node("ManageurNiveau").loadNiveauCurrent()
			is_playing = true
		nbClic = nbClic +1;
	if Input.is_action_just_pressed("Exit"):
		get_tree().quit()


func myResize():
	var ratio = Vector2.ZERO
	ratio.x = oldWindowSize.x/get_viewport().size.x
	get_node("Camera2D").zoom.x = get_node("Camera2D").zoom.x*ratio.x
	ratio.y = oldWindowSize.y/get_viewport().size.y
	get_node("Camera2D").zoom.y = get_node("Camera2D").zoom.y*ratio.y
	oldWindowSize = get_viewport().size

func setGameOver():
	is_playing = false;
	get_node("GameOver").visible = true;
	get_node("ManageurNiveau").visible = false;
	nbClic = 0;
	reload = true;
