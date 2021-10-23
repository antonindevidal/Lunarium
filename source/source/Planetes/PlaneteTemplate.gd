extends StaticBody2D

var forceAttraction = 0.1;
var radius = 300;
var Couleur = ["Rouge", "Bleu", "Verte", "Jaune","Rose"]
var rng = RandomNumberGenerator.new()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var my_random_number = rng.randf_range(-1,5)
	get_node("AnimatedSprite").animation = Couleur[my_random_number]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
