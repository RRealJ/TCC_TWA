extends CanvasLayer


@onready var btn_continuar = $menu_holder/btn_continuar


func _ready():
	visible = false


func _unhandled_input(event):
	if event.is_action_pressed("pausar"):
		visible = true
		get_tree().paused = true
		btn_continuar.grab_focus()
		

func _on_btn_continuar_pressed():
	get_tree().paused = false
	visible = false


func _on_btn_inventário_pressed():
	pass # Replace with function body.


func _on_btn_opcoes_pressed():
	pass
	

func _on_btn_main_menu_pressed():
	pass # Replace with function body.


func mostrar_esconder(mostrar, esconder):
	mostrar.show()
	esconder.hide()
	



		
		
		
