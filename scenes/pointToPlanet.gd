extends Line2D

var player

var planetVector
var playerVector

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("../Player")
	playerVector = player.position
	add_point(playerVector,0)
	add_point(Vector2(500,0),1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	playerVector = player.position
	
	set_point_position(0, playerVector)
	set_point_position(1, (playerVector - player.get_nearest_body().normalized()*100))
	pass
