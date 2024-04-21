extends CanvasLayer

var lHealth
var lVelocity
var lGravity
var lNearestBody

var player

var health
var velocity
var gravity
var nearest

var orangeSpeed
var redSpeed


# Called when the node enters the scene tree for the first time.
func _ready():
	lHealth = get_node("Grid/Health")
	lVelocity = get_node("Grid/Velocity")
	lGravity = get_node("Grid/Gravity")
	lNearestBody = get_node("Grid/DistNearestBody")
	
	player = get_node("/root/Node2D/Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_getPlayerVars()
	lHealth.text = str("Health: ", health)
	lVelocity.text = str("Velocity: ", velocity)
	lGravity.text = str("Gravity: ", gravity)
	lNearestBody.text = str("Distance to nearest body: ", nearest)
	
	if abs(velocity.x) > redSpeed or abs(velocity.y) > redSpeed:
		lVelocity.set("theme_override_colors/font_color", Color(1,0,0))
	elif abs(velocity.x) > orangeSpeed or abs(velocity.y) > orangeSpeed:
		lVelocity.set("theme_override_colors/font_color", Color(1,.5,0))
	else:
		lVelocity.set("theme_override_colors/font_color", Color(0,1,0))
		
	if get_node("/root/MinigameServer").score == 3:
		$"You win!".show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	if health <= 0:
		$Death.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
func _getPlayerVars():
	if player != null:
		health = player.health
		orangeSpeed = player.orangeSpeed
		redSpeed = player.redSpeed
		velocity = player.velocity
		gravity = player.playerGravity
		nearest = player.get_nearest_body()
