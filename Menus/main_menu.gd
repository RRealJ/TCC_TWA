extends Control


@onready var opcoes = get_node("Opcoes")
@onready var menu = get_node("menu")
@onready var video = get_node("Video")
@onready var volume = get_node("Volume")
@onready var global = get_node("Opcoes")


func _on_btn_saltar_pressed():
	get_tree().change_scene_to_file("res://Mundos/mundo_1.tscn")


func _on_btn_loja_pressed():
	pass # Replace with function body.


func _on_btn_opcoes_pressed():
	mostrar_esconder(opcoes, menu)


func _on_btn_sair_pressed():
	get_tree().quit()


func mostrar_esconder(mostrar, esconder):
	mostrar.show()
	esconder.hide()


func _on_video_pressed():
	mostrar_esconder(video, opcoes)


func _on_volume_pressed():
	mostrar_esconder(volume, opcoes)
