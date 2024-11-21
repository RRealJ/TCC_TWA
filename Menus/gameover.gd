extends Control


@onready var mundo = Global.mundo_atual
@onready var btn_finalizar = $VBoxContainer/btn_finalizar
@onready var titulo = $gameover_titulo
@onready var inv: Inv = load("res://Inventario/player_inv.tres")


func _ready():
	get_tree().paused = false
	if Global.player_win:
		titulo.text = "GANHOU!"
		$gameover_win_sound.play()
	else:
		titulo.text = "FIM DE JOGO"
		$gameover_sound.play()
		
	$Control/Inv_ui.visible = true
	
	await get_tree().create_timer(1.5).timeout
	$gameover_bgm.play()
	SaveLoad.save()
	btn_finalizar.grab_focus()



func _on_btn_restart_pressed():
	$pressed.play()
	print(mundo)
	if mundo == 1:
		get_tree().change_scene_to_file("res://Mundos/mundo_1.tscn")
	elif mundo == 2:
		get_tree().change_scene_to_file("res://Mundos/mundo_2.tscn")
	elif mundo == 3:
		get_tree().change_scene_to_file("res://Mundos/mundo_3.tscn")
	elif mundo == 4:
		get_tree().change_scene_to_file("res://Mundos/mundo_4.tscn")
	elif mundo == 5:
		get_tree().change_scene_to_file("res://Mundos/mundo_5.tscn")
	else:
		get_tree().change_scene_to_file("res://Menus/main_menu.tscn")
	

func _on_btn_finalizar_pressed():
	$pressed.play()
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")


func _on_btn_restart_focus_entered():
	$select.play()


func _on_btn_finalizar_focus_entered():
	$select.play()
