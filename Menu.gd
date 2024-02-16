extends Control


func _on_comecar_pressed():
	get_tree().change_scene_to_file("res://Mundos/mundo_1.tscn")


func _on_loja_pressed():
	pass # Replace with function body.


func _on_sair_pressed():
	get_tree().quit()


func _on_opcoes_pressed():
	get_tree().change_scene_to_file("res://opt_menu.tscn")
