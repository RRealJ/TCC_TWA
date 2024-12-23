extends Control

@onready var slider_master = $Volume/HBoxContainer/sliders/hs_master
@onready var btn_display = $Video/HBoxContainer/checkboxes/ob_resolucao
@onready var btn_video = $Opcoes/VBoxContainer/video
@onready var btn_saltar = $menu/btn_saltar
@onready var opcoes = get_node("Opcoes")
@onready var menu = get_node("menu")
@onready var video = get_node("Video")
@onready var volume = get_node("Volume")
@onready var status = get_node("Status")
@onready var opt_btn = $Video/HBoxContainer/checkboxes/ob_resolucao
@onready var btn_voltar = $Opcoes/btn_voltar_opt


const DICT_RESOLUCOES : Dictionary = {
	"1024 x 768" : Vector2i(1024, 768),
	"1280 x 960" : Vector2i(1280, 960),
	"1440 x 900" : Vector2i(1440, 900),
	"1600 x 1050" : Vector2i(1600, 1050),
	"1920 x 1080" : Vector2i(1920, 1080)
}
	

func _ready():
	$bgm_menu_loop.play()
	add_resolucao_items()
	opt_btn.item_selected.connect(on_resolution_selected)
	btn_saltar.grab_focus()
	$Video/HBoxContainer/checkboxes/cb_fullscreen.button_pressed = SaveLoad.fullscreen
	$Volume/HBoxContainer/sliders/hs_master.value = SaveLoad.hs_master * 100
	$Volume/HBoxContainer/sliders/hs_sfx.value = SaveLoad.hs_sfx * 100
	$Volume/HBoxContainer/sliders/hs_bgm.value = SaveLoad.hs_bgm * 100
	SaveLoad.save()
	
	
func _on_btn_saltar_pressed():
	mostrar_esconder($Mundos, menu)
	$"Mundos/HBoxContainer/Mundo 1".grab_focus()


func _on_btn_loja_pressed():
	await get_tree().create_timer(0.4).timeout
	get_tree().change_scene_to_file("res://loja.tscn")


func _on_btn_opcoes_pressed():
	mostrar_esconder(opcoes, menu)
	btn_video.grab_focus()


func _on_btn_sair_pressed():
	await get_tree().create_timer(0.4).timeout
	get_tree().quit()


func mostrar_esconder(mostrar, esconder):
	mostrar.show()
	esconder.hide()
	SaveLoad.save()


func _on_video_pressed():
	mostrar_esconder(video, opcoes)
	$Video/HBoxContainer/checkboxes/cb_fullscreen.button_pressed = Global.fullscreen
	$Video/HBoxContainer/checkboxes/cb_vsync.button_pressed = Global.sem_bordas
	$Video/HBoxContainer/checkboxes/cb_sem_bordas.button_pressed = Global.vsync
	btn_display.grab_focus()


func _on_volume_pressed():
	mostrar_esconder(volume, opcoes)
	slider_master.grab_focus()


func _on_btn_voltar_opt_pressed():
	mostrar_esconder(menu, opcoes)
	btn_saltar.grab_focus()
	
	
func add_resolucao_items() -> void:
	for resolucao_tamanho in DICT_RESOLUCOES:
		opt_btn.add_item(resolucao_tamanho)
		 

func on_resolution_selected(index : int) -> void:
	DisplayServer.window_set_size(DICT_RESOLUCOES.values()[index])
	
	
func _on_cb_fullscreen_toggled(toggled_on):
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		Global.fullscreen = true
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		Global.fullscreen = false
		if $Video/HBoxContainer/checkboxes/cb_sem_bordas.button_pressed == true:
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
			Global.sem_bordas = true


func _on_cb_sem_bordas_toggled(toggled_on):
	if toggled_on == true  && $Video/HBoxContainer/checkboxes/cb_fullscreen.button_pressed == false:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		Global.sem_bordas = true
	else:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		Global.fullscreen = false


func _on_cb_vsync_toggled(toggled_on):
	if toggled_on == true:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		Global.vsync = true
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		Global.vsync = false
		

func _on_btn_voltar_video_pressed():
	mostrar_esconder(opcoes, video)
	btn_voltar.grab_focus()
	
	
func _on_btn_voltar_volume_pressed():
	mostrar_esconder(opcoes, volume)
	btn_voltar.grab_focus()
	
	
func _on_btn_voltar_status_pressed():
	mostrar_esconder(opcoes, status)
	btn_voltar.grab_focus()


func _on_status_pressed():
	mostrar_esconder(status, opcoes)
	$Status/HBoxContainer/info/info_moedas.text = str(Global.moedas)
	$Status/HBoxContainer/info/info_iniciados.text = str(Global.jogos_iniciados)
	$Status/HBoxContainer/info/info_mundos_completados.text = str(Global.jogos_completados)
	$Status/HBoxContainer/info/info_inimigos.text = str(Global.inimigos_derrotados)
	$Status/HBoxContainer/info/info_bosses.text = str(Global.bosses_derrotados)
	$Status/HBoxContainer/info/info_conquistas.text = str(Global.conquista_completadas)
	$Status/btn_voltar_status.grab_focus()


func _on_hs_master_drag_ended(value_changed):
	if value_changed:
		SaveLoad.hs_master = $Volume/HBoxContainer/sliders/hs_master.value/100

func _on_hs_sfx_drag_ended(value_changed):
	if value_changed:
		SaveLoad.hs_sfx = $Volume/HBoxContainer/sliders/hs_sfx.value/100


func _on_hs_bgm_drag_ended(value_changed):
	if value_changed:
		SaveLoad.hs_bgm = $Volume/HBoxContainer/sliders/hs_bgm.value/100
		
func _on_bgm_menu_loop_finished():
	$bgm_menu_loop.play()
	
	
func _unhandled_input(event):
	if event.is_action_pressed("f11"):
		if Global.fullscreen == true:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			Global.fullscreen = false
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			Global.fullscreen = true
			
			


func _on_voltar_md_pressed() -> void:
	mostrar_esconder(menu, $Mundos)
	btn_saltar.grab_focus()


func _on_mundo_1_pressed() -> void:
	await get_tree().create_timer(0.4)
	get_tree().change_scene_to_file("res://Mundos/mundo_1.tscn")


func _on_mundo_2_pressed() -> void:
	await get_tree().create_timer(0.4)
	get_tree().change_scene_to_file("res://Mundos/mundo_2.tscn")
