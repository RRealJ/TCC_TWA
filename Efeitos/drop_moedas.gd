extends Node2D

@onready var anim = $anim
@onready var mundo = $".."
var valor := 1 as int


func _on_collision_area_entered(area):
	if area.name == "pick_up":
		mundo.count_moedas(valor)
		queue_free()
	


