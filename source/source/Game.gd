extends Node2D

var is_playing = false
var oldWindowSize;
var reload = false;
var nbClic = 0;
var cinDebut= false;
var cinFin= false;
var credit= false;
var start = true;
func _init():
	pass

func _ready():
	var _p = get_tree().get_root().connect("size_changed", self, "myResize")
	oldWindowSize = get_viewport().size
	get_node("CinematiqueDebut/AnimationPlayer").clear_queue()
	get_node("Cinematique/AnimationPlayer").clear_queue()
	get_node("Credits/SceneAnimation").clear_queue()
	get_node("CinematiqueDebut/AnimationPlayer").stop()
	get_node("Cinematique/AnimationPlayer").stop()
	get_node("Credits/SceneAnimation").stop()
	pass # Replace with function body.

func _process(_delta):
	if Input.is_action_just_released("launch"):
		if credit:
			$Credits.visible = false;
			nbClic=0;
			$StartMenu.visible = true;
			credit=false;
			start = true;
		elif cinFin:
			cinFin=false
			$Cinematique.visible = false;
			$Credits.visible = true;
			get_node("Credits/SceneAnimation").play()
			credit = true;
		elif cinDebut:
			start=false
			get_node("CinematiqueDebut").visible = false;
			get_node("GameOver").visible = false;
			get_node("ManageurNiveau").visible = true;
			if reload: 
				get_node("ManageurNiveau").reloadNiveau()
			else:
				get_node("ManageurNiveau").loadNiveauCurrent()
			cinDebut = false;
			is_playing = true;
		elif start:
			$ManageurNiveau.currentNiveau=0
			get_node("StartMenu").visible = false;
			get_node("CinematiqueDebut").visible = true;
			get_node("CinematiqueDebut/AnimationPlayer").play();
			cinDebut = true
		nbClic = nbClic +1;
	if Input.is_action_just_pressed("Exit"):
		get_tree().quit()
	if is_playing and $AudioEpic.playing == false:
		$AudioMel.stop()
		$AudioEpic.play()
	if not is_playing and $AudioMel.playing == false:
		$AudioEpic.stop()
		$AudioMel.play()

func runEnd():
	$ManageurNiveau.visible = false;
	is_playing=false
	get_node("Cinematique").visible=true
	get_node("Cinematique/AnimationPlayer").play()
	cinFin = true;

func myResize():
	var ratio = Vector2.ZERO
	ratio.x = oldWindowSize.x/get_viewport().size.x
	get_node("Camera2D").zoom.x = get_node("Camera2D").zoom.x*ratio.x
	ratio.y = oldWindowSize.y/get_viewport().size.y
	get_node("Camera2D").zoom.y = get_node("Camera2D").zoom.y*ratio.y
	oldWindowSize = get_viewport().size

func setGameOver():
	is_playing = false;
	get_node("GameOver").visible = true;
	get_node("ManageurNiveau").visible = false;
	nbClic = 0;
	reload = true;
