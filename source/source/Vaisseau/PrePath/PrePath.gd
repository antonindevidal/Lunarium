extends Control

var force = Vector2.ZERO;
var velocity = Vector2.ZERO;
var N = 0.5
var draw = true
var nb=5;
var position2;

func _ready():
	position2 = get_parent().position

func _process(delta):
	update()

func _draw():
	position2 = get_parent().get_node("AnimatedSprite").position
	if not get_parent().is_moving:
		velocity = (get_global_mouse_position() - position2).normalized() * get_parent().speed;
		for j in nb:
			var lesPlanetes = get_parent().get_parent().get_children()
			force = Vector2.ZERO
			for i in lesPlanetes:
				if i.is_in_group("Planete"):
					if i.radius > position2.distance_to(i.position):
						force = (i.position - position2)*i.forceAttraction;
			velocity = (velocity + force).normalized() * get_parent().speed;
			if draw:
				draw_line(position2,position2+velocity*N,Color.gray);
			draw = not draw
			position2 = position2 + velocity
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
