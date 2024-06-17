extends CanvasLayer


@onready var btn_continuar = $menu_holder/btn_continuar
@onready var video = get_node("Video")
@onready var volume = get_node("Volume")
@onready var opt_btn = $Video/HBoxContainer1/checkboxes1/ob_resolucao
@onready var mundo_bgm = $"../../mundo_bgm"

const DICT_RESOLUCOES : Dictionary = {
	"1024 x 768" : Vector2i(1024, 768),
	"1280 x 960" : Vector2i(1280, 960),
	"1440 x 900" : Vector2i(1440, 900),
	"1600 x 1050" : Vector2i(1600, 1050),
	"1920 x 1080" : Vector2i(1920, 1080)
}

func _ready():
	visible = false
	add_resolucao_items()
	opt_btn.item_selected.connect(on_resolution_selected)


func _unhandled_input(event):
	if event.is_action_pressed("escape"):
		if $"../Recompensas".visible == false:
			if get_tree().paused == false:
				if Global.diminuir_bgm_ao_pausar:#vai que a pessoa pausa pra ouvir algo
					mundo_bgm.volume_db = -15 
				visible = true
				get_tree().paused = true
				btn_continuar.grab_focus()
			else:
				if Global.diminuir_bgm_ao_pausar:
					mundo_bgm.volume_db = -5
				get_tree().paused = false
				visible = false
				
	

func _on_btn_continuar_pressed():
	get_tree().paused = false
	if Global.diminuir_bgm_ao_pausar:
		mundo_bgm.volume_db = -5
	visible = false
	
	
func _on_btn_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")


func mostrar_esconder(mostrar, esconder):
	mostrar.show()
	esconder.hide()
	
	
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
		
		
		





