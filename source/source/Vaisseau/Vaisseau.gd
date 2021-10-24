extends KinematicBody2D


var is_moving = false;
var velocity = Vector2.ZERO;
var speed = 800;
var on_screen=true;
var _poubelle;
var victoire = false
var force = Vector2.ZERO;
var oldMouse;
# Called when the node enters the scene tree for the first time.
func _ready():
	oldMouse = get_global_mouse_position()
	pass # Replace with function body.

func _process(_delta):
	oldMouse=get_global_mouse_position()
	
	if is_moving:
		$animatedSprite.play("moving")
	else:
		$animatedSprite.play("default")
	
	
	if get_parent().get_parent().get_parent().is_playing :
		force = calcDir(position)
		
		if Input.is_action_just_released("launch") and not is_moving and get_parent().get_parent().get_parent().nbClic >1:
			launch(get_global_mouse_position())
		if is_moving:
			velocity = (velocity + force).normalized() * speed
			_poubelle = move_and_slide(velocity)
			look_at(velocity + position)
		else:
			look_at(get_global_mouse_position())
		if not get_node("notifier").is_on_screen():
			on_screen = false
		for i in get_slide_count():
			if get_slide_collision(i).collider.is_in_group("Lune"):
				victoire = true
			else:
				get_parent().get_parent().gameOver()
	
func launch(dest):
	velocity = (dest - position).normalized() * speed;
	is_moving = true

func is_on_screen():
	return on_screen
	
func calcDir(pos):
	var lesPlanetes = get_parent().get_children()
	force = Vector2.ZERO
	for i in lesPlanetes:
		if i.is_in_group("Planete"):
			if i.radius > pos.distance_to(i.position):
				force = force + (i.position - pos)*i.forceAttraction;
	return force
