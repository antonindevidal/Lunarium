extends Node2D

var arrayNiveau = [];
var currentNiveau = -1;

var countTMP = 120;

# Called when the node enters the scene tree for the first time.
func _init():
	loadNiveau();
	pass;
	
func _ready():
	nextNiveau();
	pass;
	
func _process(_delta):
	if countTMP>0:
		countTMP = countTMP -1;
	if countTMP == 0 :
		nextNiveau();
		countTMP = -1;
	pass;

func loadNiveau():
	arrayNiveau.append("res://source/Niveaux/Niveau0/Niveau0.tscn");
	arrayNiveau.append("res://source/Niveaux/Niveau1/Niveau1.tscn");
	pass;

func nextNiveau():
	currentNiveau=currentNiveau + 1;
	remove_child(get_child(0));
	add_child(load(arrayNiveau[currentNiveau]).instance());
	pass;
