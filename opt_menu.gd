extends Control

var master_bus = AudioServer.get_bus_index("Master")

func _on_volume_value_changed(valor):
	AudioServer.set_bus_volume_db(master_bus, valor)
	
	if valor == -30:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)


func _on_voltar_pressed():
	get_tree().change_scene_to_file("res://main.tscn")


