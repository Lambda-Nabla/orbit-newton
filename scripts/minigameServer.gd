extends Node

var minigames = []
var tree: SceneTree

# Called when the node enters the scene tree for the first time.
func _ready():
	minigames.append("res://scenes/wires_minigame.tscn")
	minigames.append("res://scenes/terminal minigame.tscn")
	minigames.append("res://scenes/pressureminigame.tscn")

func serve_minigame():
	var minigame = minigames.pick_random()
	get_tree().change_scene_to_file(minigame)

func reload_main_scene():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
