extends Node

@export var scroll_speed : int = 2

var game_running : bool
var game_over : bool
var scroll
var score
var ground_height : int

func _ready():
	ground_height = $Ground.get_node("Sprite2D").texture.get_height()
	new_game()

func new_game():
	game_running = false
	game_over = false
	score = 0
	scroll = 0
	$ScoreLabel.text = "SCORE: " + str(score)
	$GameOver.hide()
	$Bird.reset()
	
func _input(_event):
	pass

func start_game():
	game_running = true
	$Bird.flying = true
	$Bird.flap()

func _process(_delta):
	if game_running:
		scroll += scroll_speed
		if scroll >= get_window().size.x:
			scroll = 0
		$Ground.position.x = -scroll

func stop_game():
	$GameOver.show()
	$Bird.flying = false
	game_running = false
	game_over = true

func _on_ground_hit():
	$Bird.falling = false
	stop_game()

func _on_game_over_restart():
	new_game()
