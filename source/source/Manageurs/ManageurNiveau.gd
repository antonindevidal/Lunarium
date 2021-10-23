extends Node2D

var arrayNiveau = [];
var currentNiveau = -1;
var is_playing = false;

var countTMP = 120;
var countRun = 30;
var Vaisseau_on_screen = true;
# Called when the node enters the scene tree for the first time.
func _init():
	loadNiveau();
	pass;
	
func _ready():
	nextNiveau();
	pass;
	
func _process(_delta):
	is_playing = true
	if is_playing:
		if countTMP>0:
			countTMP = countTMP -1;
		if countTMP == 0 :
			nextNiveau();
			countTMP = -1;
		
		Vaisseau_on_screen = (get_node("NiveauTemplate").get_node("Vaisseau")).is_on_screen()
		if not Vaisseau_on_screen:
			gameOver()
	pass;

func loadNiveau():
	arrayNiveau.append("res://source/Niveaux/Niveau0/Niveau0.tscn");
	arrayNiveau.append("res://source/Niveaux/Niveau1/Niveau1.tscn");
	pass;

func nextNiveau():
	currentNiveau=currentNiveau + 1;
	remove_child(get_child(0));
	var tmp : Node =load(arrayNiveau[currentNiveau]).instance()
	tmp.name = "NiveauTemplate"
	add_child(tmp);
	pass;

func gameOver():
	print("GameOver")
