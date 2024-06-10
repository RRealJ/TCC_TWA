extends Control

@onready var inv: Inv = preload("res://Inventario/player_inv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false

func _ready():
	print(inv)
	print(slots)
	update_slots()
	close()
	
	
func update_slots():
	for i in range(min(inv.itens.size(), slots.size())):
		print(slots[i])
		slots[i].update(inv.itens[i])
	
	
func _process(delta):
	if Input.is_action_just_pressed("inv"):
		if is_open:
			close()
		else:
			open()
	
	
func open():
	visible = true
	is_open = true


func close():
	visible = false
	is_open = false
