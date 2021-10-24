extends StaticBody2D

export var forceAttraction = 0.05;
var radius = 300;
var Couleur = ["Rouge", "Bleu", "Vert", "Jaune","Rose"]
var rng = RandomNumberGenerator.new()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func init(coord : Vector2):
	position = coord;
	pass;
	
# Called when the node enters the scene tree for the first time.
func _ready():
	if get_node("AnimatedSprite").animation == "Vide":
		rng.randomize()
		var my_random_number = rng.randf_range(-1,5)
		setColor(Couleur[my_random_number])
	pass # Replace with function body.

func setColor(col : String):
	get_node("AnimatedSprite").animation = col
	get_node("ZoneGrav").animation = col
	if col == "Gravitator":
		rng.randomize()
		var my_random_number = rng.randf_range(0,2*PI)
		get_node("AnimatedSprite").rotate(my_random_number)

func changeRadius(addVal):
	radius = radius + addVal
	get_node("ZoneGrav").scale = get_node("ZoneGrav").scale + Vector2.ONE * (2*addVal)/100
