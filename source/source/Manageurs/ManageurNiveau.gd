extends Node2D

var arrayNiveau = [];
var currentNiveau = 0;

var nbGravitator = 5;
var test=true
var Vaisseau_on_screen = true;
var ZoneChanger = 5;
# Called when the node enters the scene tree for the first time.
func _init():
	loadNiveaux();
	pass;
	
func _ready():
	loadNiveau(0)
	pass;
	
func _process(_delta):
	if get_parent().is_playing :
		if get_parent().nbClic > 1:
			Vaisseau_on_screen = (get_node("NiveauTemplate").get_node("Vaisseau")).is_on_screen()
			if not Vaisseau_on_screen:
				gameOver()
			if (get_node("NiveauTemplate").get_node("Vaisseau")).victoire:
				victoire()
			if Input.is_action_just_pressed("Reload"):
				loadNiveau(currentNiveau)
		if Input.is_action_just_released("AdderGravitator"):
			addGravitator(get_global_mouse_position())
	pass;

func _input(event : InputEvent) -> void:
	if event is InputEventMouseButton:
		event as InputEventMouseButton
		if event.pressed:
			match event.button_index:
				BUTTON_WHEEL_UP:
					changeZone(ZoneChanger, get_local_mouse_position())
				BUTTON_WHEEL_DOWN:
					changeZone(-ZoneChanger, get_local_mouse_position())

func loadNiveaux():
	arrayNiveau.append("res://source/Niveaux/Niveau0/Niveau0.tscn");
	arrayNiveau.append("res://source/Niveaux/Niveau1/Niveau1.tscn");
	pass;

func nextNiveau():
	currentNiveau=currentNiveau + 1;
	loadNiveau(currentNiveau)
	pass;

func loadNiveau(nb):
	remove_child(get_child(0));
	var tmp : Node =load(arrayNiveau[nb]).instance()
	tmp.name = "NiveauTemplate"
	add_child(tmp);
func reloadNiveau():
	remove_child(get_child(0));
	var tmp : Node =load(arrayNiveau[currentNiveau]).instance()
	tmp.name = "NiveauTemplate"
	add_child(tmp);

func gameOver():
	get_parent().setGameOver()
	
func victoire():
	print("Victoire")
	if currentNiveau < arrayNiveau.size()-1:
		nextNiveau()

func addGravitator(coord):
	var grav = preload("res://source/Planetes/PlaneteTemplate.tscn").instance();
	grav.init(coord);
	grav.setColor("Gravitator")
	get_node("NiveauTemplate").add_child(grav);

func changeZone(val, pos : Vector2):
	for i in get_node("NiveauTemplate").get_children():
		if i.is_in_group("Planete"):
			if pos.distance_to(i.position)<100:
				if i.get_node("AnimatedSprite").animation == "Gravitator":
					i.changeRadius(val)
