extends Control

var force = Vector2.ZERO;
var velocity = Vector2.ZERO;
var N = 0.1
var draw = true
var nb=10;
var position2;

func _ready():
	position2 = get_parent().get_node("AnimatedSprite").position

func _process(_delta):
	update()

func _draw():
	position2 = get_parent().get_node("AnimatedSprite").position
	if not get_parent().is_moving:
		draw = true
		velocity = (get_global_mouse_position() - position2);
		for j in nb:
			force = get_parent().calcDir(position2)
			velocity = ((velocity + force).normalized()) * get_parent().speed;
			if draw:
				draw_line(position2,position2 + velocity*N,Color.gray);
			draw = not draw
			position2 = position2 + velocity*N
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
