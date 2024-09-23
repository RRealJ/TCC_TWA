extends Node2D

@onready var global = get_node("/root/Global")
@onready var player_var = get_node("/root/PlayerVariaveis")


func _ready():
	get_tree().change_scene_to_file("res://intro.tscn")


func _process(delta):
	pass
