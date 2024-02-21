extends Control




func _on_btn_saltar_pressed():
	get_tree().change_scene_to_file("res://Mundos/mundo_1.tscn")


func _on_btn_loja_pressed():
	pass # Replace with function body.


func _on_btn_opcoes_pressed():
	get_tree().change_scene_to_file("res://Menus/opt_menu.tscn")


func _on_btn_sair_pressed():
	get_tree().quit()



