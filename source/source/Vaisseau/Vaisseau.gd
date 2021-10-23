extends KinematicBody2D


var is_moving = false;
var velocity = Vector2.ZERO;
var speed = 500;
var on_screen=true;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	if get_parent().get_parent().is_playing:
		if Input.is_action_just_released("launch"):
			launch(get_global_mouse_position())
		if is_moving:
			move_and_slide(velocity)
		else:
			look_at(get_global_mouse_position())
		if not get_node("notifier").is_on_screen():
			on_screen = false
		for i in get_slide_count():
			get_parent().get_parent().gameOver()
func launch(dest):
	velocity = (dest - position).normalized() * speed;
	is_moving = true

func is_on_screen():
	return on_screen
