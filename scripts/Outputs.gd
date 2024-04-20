extends Area2D

@export var index = 0
enum colors {green,blue,red,yellow}
@export var color = colors.green
var mainScript

func _ready():
	mainScript = get_node("../")
	match color:
		colors.green:
			get_node("Sprite2D").modulate = Color(0,1,0)
		colors.blue:
			get_node("Sprite2D").modulate = Color(0,0,1)
		colors.red:
			get_node("Sprite2D").modulate = Color(1,0,0)
		colors.yellow:
			get_node("Sprite2D").modulate = Color(1,1,0)
	
	pass

func _process(delta):
	pass


func _on_mouse_entered():
	#if Input.is_mouse_button_pressed(1) == true:
		print("have clicked on this")
		mainScript._detect(color, index, global_position)
