extends Node2D

var minigameServer
var rng = RandomNumberGenerator.new()

enum colors {green,blue,red,yellow}
var selectedColor
var completed = [false,false,false,false]
var victory = false

var wire1pos = Vector2.ZERO
var wire2pos = Vector2.ZERO

var input = []
var output = []

func _ready():
	minigameServer = get_node("/root/MinigameServer")

func _process(delta):
	if victory == true:
		minigameServer.reload_main_scene()
	else:
		var temp = true
		for c in completed:
			if c == false:
				temp = false
		
		if temp == true:
			victory = true
	pass

func _assignColorInput():
	input.append(get_node("Inputs"))
	input.append(get_node("Inputs2"))
	input.append(get_node("Inputs3"))
	input.append(get_node("Inputs4"))
	
	output.append(get_node("Outputs"))
	output.append(get_node("Outputs2"))
	output.append(get_node("Outputs3"))
	output.append(get_node("Outputs4"))
	
	for i in 4:
		var temp = rng.randi_range(0, 3)
		match temp:
			0:
				input[i].color = colors.green
				output[i].color = colors.green
			1:
				input[i].color = colors.blue
				output[i].color = colors.blue
			2:
				input[i].color = colors.red
				output[i].color = colors.red
			3:
				input[i].color = colors.yellow
				output[i].color = colors.yellow
		pass

func _updateColor(color, pos):
	wire1pos = pos
	selectedColor = color
	print("updated to new color")
	pass

func _detect(color, index, pos):
	if color == selectedColor:
		completed[index] = true
		print("new completed")
		wire2pos = pos
		_createLine2D(color, wire1pos,wire2pos)
	pass

func _createLine2D(color, pos1, pos2):
	var line = Line2D.new()
	line.add_point(pos1,0)
	line.add_point(pos2,1)
	match color:
		colors.green:
			line.default_color = Color(0,1,0)
		colors.blue:
			line.default_color = Color(0,0,1)
		colors.red:
			line.default_color = Color(1,0,0)
		colors.yellow:
			line.default_color = Color(1,1,0)
	
	add_child(line)
	
