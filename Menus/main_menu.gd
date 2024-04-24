extends Control

@onready var slider_master = $Volume/HBoxContainer/sliders/hs_master
@onready var btn_display = $Video/HBoxContainer/checkboxes/ob_resolucao
@onready var btn_video = $Opcoes/VBoxContainer/video
@onready var btn_saltar = $menu/btn_saltar
@onready var opcoes = get_node("Opcoes")
@onready var menu = get_node("menu")
@onready var video = get_node("Video")
@onready var volume = get_node("Volume")
@onready var global = $"/root/Global"
@onready var opt_btn = $Video/HBoxContainer/checkboxes/ob_resolucao


const DICT_RESOLUCOES : Dictionary = {
	"1024 x 768" : Vector2i(1024, 768),
	"1280 x 960" : Vector2i(1280, 960),
	"1440 x 900" : Vector2i(1440, 900),
	"1600 x 1050" : Vector2i(1600, 1050),
	"1920 x 1080" : Vector2i(1920, 1080)
}
	

func _ready():
	add_resolucao_items()
	opt_btn.item_selected.connect(on_resolution_selected)
	btn_saltar.grab_focus()


func _on_btn_saltar_pressed():
	get_tree().change_scene_to_file("res://Mundos/mundo_1.tscn")


func _on_btn_loja_pressed():
	pass # Replace with function body.


func _on_btn_opcoes_pressed():
	mostrar_esconder(opcoes, menu)
	btn_video.grab_focus()


func _on_btn_sair_pressed():
	get_tree().quit()


func mostrar_esconder(mostrar, esconder):
	mostrar.show()
	esconder.hide()


func _on_video_pressed():
	mostrar_esconder(video, opcoes)
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
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_cb_sem_bordas_toggled(toggled_on):
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	else:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)


func _on_cb_vsync_toggled(toggled_on):
	if toggled_on == true:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		

func _on_btn_voltar_video_pressed():
	mostrar_esconder(opcoes, video)
	btn_video.grab_focus()
	
	
func _on_btn_voltar_volume_pressed():
	mostrar_esconder(opcoes, volume)
	btn_video.grab_focus()
