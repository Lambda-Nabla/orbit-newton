extends Control

var copyText
var rng = RandomNumberGenerator.new()

var texts = ["calculate_gravity(velocity)", "flush_toilets(toilet0)", "fix_that_dang_bug(245)", 
"eat_good_fish(swordfish)"]

var lineNode
var label

var playerText

# Called when the node enters the scene tree for the first time.
func _ready():
	var temp = rng.randf_range(0, 3)
	copyText = texts[temp]
	lineNode = get_node("VSplitContainer/LineEdit")
	label = get_node("VSplitContainer/Label")
	lineNode.grab_focus()
	label.text = copyText
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	playerText = lineNode.text
	if playerText == copyText:
		print("you win!")
	pass
