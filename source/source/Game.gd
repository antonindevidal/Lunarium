extends Node2D

var is_playing = false

func _init():
	pass

func _ready():
	pass # Replace with function body.

func _process(_delta):
	if Input.is_action_just_released("launch") and not is_playing:
		get_node("StartMenu").visible = false;
		add_child(load("res://source/Manageurs/ManageurNiveau.tscn").instance())
		is_playing = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
