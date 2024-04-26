extends Node2D

@onready var player := $Player as CharacterBody2D
@onready var camera := $camera as Camera2D

func _ready():
	Global.mundo_atual = 1
	player.follow_camera(camera)
	
