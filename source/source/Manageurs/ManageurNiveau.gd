extends Node2D

var arrayNiveau = [];
var currentNiveau = 0;

var nbGravitator = 3;
var Vaisseau_on_screen = true;
var ZoneChanger = 10;
var savePoint : Vector2
var lesChiffres=[3,2,1,4,0,2,1,4,0,3,2,1,0]
var currentColor = 0;
var avancement;
var pas = 40;
var slide =false;
var totalDeplacement;

var save=true;
var nbCheckPoint =0;
# Called when the node enters the scene tree for the first time.
func _init():
	loadNiveaux();
	pass;
	
func _ready():
	pass;
	
func _process(_delta):
	if Input.is_action_just_released("Skip"):
		nextNiveau()
	if get_parent().is_playing :
		if get_parent().nbClic > 2:
			Vaisseau_on_screen = (get_node("NiveauTemplate").get_node("Vaisseau")).is_on_screen()
			if not Vaisseau_on_screen:
				gameOver()
			if (get_node("NiveauTemplate").get_node("Vaisseau")).victoire:
				victoire()
		if Input.is_action_just_pressed("Reload"):
			reloadNiveau()
		if Input.is_action_just_released("AdderGravitator"):
			addGravitator(get_global_mouse_position())
		if slide:
			if (avancement < totalDeplacement):
				for i in get_node("NiveauTemplate").get_children():
					i.position.x -= pas
				avancement+=pas
			else:
				slide = false
				if save:
					savePoint = get_node("NiveauTemplate/Vaisseau").position
				get_node("NiveauTemplate/Vaisseau").is_moving = false
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
	arrayNiveau.append("res://source/Niveaux/Niveau2/Niveau2.tscn");
	arrayNiveau.append("res://source/Niveaux/Niveau3/Niveau3.tscn");
	pass;

func nextNiveau():
	currentNiveau=currentNiveau + 1;
	if currentNiveau < 4:
		loadNiveau(currentNiveau)
	else:
		get_parent().runEnd()
	pass;

func loadNiveau(nb):
	remove_child(get_child(0));
	var tmp : Node =load(arrayNiveau[nb]).instance()
	tmp.name = "NiveauTemplate"
	add_child(tmp);
	nbGravitator=3;
	currentColor = 0;
	nbCheckPoint=0;
	savePoint = tmp.get_node("Vaisseau").position
	
func loadNiveauCurrent():
	loadNiveau(currentNiveau)
	
func reloadNiveau():
	get_node("NiveauTemplate/Vaisseau").is_moving =false
	get_node("NiveauTemplate/Vaisseau").velocity = Vector2.ZERO
	get_node("NiveauTemplate/Vaisseau").position = savePoint
	nbGravitator = 3;
	for i in get_node("NiveauTemplate").get_children():
		if i.is_in_group("Planete"):
			if i.get_node("AnimatedSprite").animation == "Gravitator":
				i.queue_free()

func gameOver():
	get_parent().setGameOver()
	
func victoire():
	nextNiveau()

func addGravitator(coord):
	if nbGravitator > 0:
		var grav = preload("res://source/Planetes/PlaneteTemplate.tscn").instance();
		grav.init(coord);
		grav.setColor("Gravitator")
		get_node("NiveauTemplate").add_child(grav);
		nbGravitator-=1;

func changeZone(val, pos : Vector2):
	for i in get_node("NiveauTemplate").get_children():
		if i.is_in_group("Planete"):
			if pos.distance_to(i.position)<100:
				if i.get_node("AnimatedSprite").animation == "Gravitator":
					i.changeRadius(val)


func slide(nb : int):
	avancement = 0;
	slide = true;
	totalDeplacement = (get_node("NiveauTemplate/Vaisseau").position.x - get_parent().position.x)+1500
	
func getColorNumber():
	var oldcolor = currentColor
	currentColor = (currentColor+1)%lesChiffres.size()
	return lesChiffres[oldcolor]
