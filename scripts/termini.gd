extends Control

var minigameServer

var copyText
var rng = RandomNumberGenerator.new()

var texts = ["calculate_gravity(velocity)", "flush_toilets(toilet0)", "fix_that_dang_bug(245)", 
"eat_good_fish(swordfish)", "collect_planet_data()", "broadcast_signal_km(10000)"]

var lineNode
var label

var playerText

# Called when the node enters the scene tree for the first time.
func _ready():
	var temp = rng.randi_range(0, 5)
	copyText = texts[temp]
	lineNode = get_node("VSplitContainer/LineEdit")
	label = get_node("VSplitContainer/Label")
	lineNode.grab_focus()
	label.text = copyText
	minigameServer = get_node("/root/MinigameServer")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	playerText = lineNode.text
	if playerText == copyText:
		minigameServer.reload_main_scene()
	pass
