extends CanvasLayer


@onready var btn_continuar = $menu_holder/btn_continuar
@onready var volume = get_node("Volume")
@onready var opt_btn = $Video/HBoxContainer1/checkboxes1/ob_resolucao
@onready var mundo_bgm = $"../../mundo_bgm"


func _ready():
	visible = false


func _unhandled_input(event):
	if event.is_action_pressed("escape"):
		if $"../Recompensas".visible == false:
			if get_tree().paused == false:
				if Global.diminuir_bgm_ao_pausar:#vai que a pessoa pausa pra ouvir algo
					mundo_bgm.volume_db -= 5 
				visible = true
				get_tree().paused = true
				btn_continuar.grab_focus()
			else:
				if Global.diminuir_bgm_ao_pausar:
					mundo_bgm.volume_db += 5
				get_tree().paused = false
				visible = false
				
	

func _on_btn_continuar_pressed():
	get_tree().paused = false
	if Global.diminuir_bgm_ao_pausar:
		mundo_bgm.volume_db += 5
	visible = false
	
	
func _on_btn_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")


func mostrar_esconder(mostrar, esconder):
	mostrar.show()
	esconder.hide()
	
		
