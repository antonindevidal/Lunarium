extends StaticBody2D

var forceAttraction = 0.1;
var radius = 300;
var Couleur = ["Rouge", "Bleu", "Verte", "Jaune","Rose"]
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
	print(col)
	get_node("AnimatedSprite").animation = col
