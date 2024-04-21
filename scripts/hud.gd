extends CanvasLayer

var lHealth
var lVelocity
var lGravity
var lNearestBody
var lScore

var player

var health
var velocity
var gravity
var nearest

var minigameServer

var orangeSpeed
var redSpeed


# Called when the node enters the scene tree for the first time.
func _ready():
	minigameServer = get_node("/root/MinigameServer")
	lHealth = get_node("Grid/Health")
	lVelocity = get_node("Grid/Velocity")
	lGravity = get_node("Grid/Gravity")
	lNearestBody = get_node("Grid/DistNearestBody")
	lScore = get_node("You win!/score")
	
	player = get_node("/root/Node2D/Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_getPlayerVars()
	lHealth.text = str("Health: ", health)
	lVelocity.text = str("Velocity: ", velocity)
	lGravity.text = str("Gravity: ", gravity)
	lNearestBody.text = str("Distance to nearest body: ", nearest)
	lScore.text = str("Score: ", 3 - minigameServer.playerHealth)
	if abs(velocity.x) > redSpeed or abs(velocity.y) > redSpeed:
		lVelocity.set("theme_override_colors/font_color", Color(1,0,0))
	elif abs(velocity.x) > orangeSpeed or abs(velocity.y) > orangeSpeed:
		lVelocity.set("theme_override_colors/font_color", Color(1,.5,0))
	else:
		lVelocity.set("theme_override_colors/font_color", Color(0,1,0))
		
	if minigameServer.score >= 3:
		$"You win!".show()
		$Grid.hide()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	if minigameServer.playerHealth <= 0:
		$Death.show()
		$Grid.hide()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
func _getPlayerVars():
	if player != null:
		health = minigameServer.playerHealth
		orangeSpeed = player.orangeSpeed
		redSpeed = player.redSpeed
		velocity = player.velocity
		gravity = player.playerGravity
		nearest = player.get_nearest_body()

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	$"You win!".hide()
	$Death.hide()
	$Grid.show()
	minigameServer.score = 0
	minigameServer.playerHealth = 3
	
