extends CanvasLayer

signal confirmado
signal cancelado
signal decidido

var opt:int
#opt = 0 -- Cancelado
#opt = 1 -- Confirmado


func _on_sim_pressed():
	opt = 1
	confirmado.emit()
	decidido.emit()
	

func _on_nao_pressed():
	opt = 0
	cancelado.emit()
	decidido.emit()
	
