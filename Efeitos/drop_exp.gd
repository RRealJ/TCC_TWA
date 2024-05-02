extends Node2D

@onready var anim = $anim
@onready var player = $"../Player"
var valor := 50 as int


func _on_collison_area_entered(area):
	if area.name == "pick_up":
		print(player.exp)
		player.update_exp(valor)
		print(player.exp)
		queue_free()
