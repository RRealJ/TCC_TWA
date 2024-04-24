extends CanvasLayer

signal confirmado
signal cancelado

var opt:int
#opt = 0 -- Cancelado
#opt = 1 -- Confirmado


func _on_sim_pressed():
	opt = 1
	emit_signal("confirmado")
	

func _on_nao_pressed():
	opt = 0
	emit_signal("cancelado")
	




