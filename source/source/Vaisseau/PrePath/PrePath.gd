extends Control

var force = Vector2.ZERO;
var velocity = Vector2.ZERO;
var N = 0.01
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
		velocity = (get_parent().get_local_mouse_position() - position2).normalized() * get_parent().speed;
		draw_line(position2,position2+velocity*N,Color.gray);
		for j in nb:
			var lesPlanetes = get_parent().get_parent().get_children()
			force = Vector2.ZERO
			for i in lesPlanetes:
				if i.is_in_group("Planete"):
					if i.radius > position2.distance_to(i.position):
						force = force + (i.position - position2)*i.forceAttraction;
			velocity = (velocity + force).normalized() * get_parent().speed;
			if draw:
				draw_line(position2,position2+velocity,Color.gray);
			#draw = not draw
			position2 = position2 + velocity
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
