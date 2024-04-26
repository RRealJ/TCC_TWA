extends Control


@onready var mundo = MundosGlobal.mundo_atual

func _on_btn_restart_pressed():
	print(mundo)
	if mundo == 1:
		get_tree().change_scene_to_file("res://Mundos/mundo_1.tscn")
	if mundo == 2:
		get_tree().change_scene_to_file("res://Mundos/mundo_2.tscn")
	if mundo == 3:
		get_tree().change_scene_to_file("res://Mundos/mundo_3.tscn")
	if mundo == 4:
		get_tree().change_scene_to_file("res://Mundos/mundo_4.tscn")
	if mundo == 5:
		get_tree().change_scene_to_file("res://Mundos/mundo_5.tscn")
	

func _on_btn_finalizar_pressed():
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")
