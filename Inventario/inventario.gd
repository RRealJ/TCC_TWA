extends Resource

class_name Inv

signal update

@export var slots: Array[Inv_slot]


func insert(item: InvItem):
	var bala = load("res://Player/Armas e Bullets/bullet_normal.tscn")
	var itemslots = slots.filter(func(slot): return slot.item == item) #verifica se já está preenchido
	if !itemslots.is_empty():
		itemslots[0].level += 1
		item.level = itemslots[0].level
	else:
		var emptyslots = slots.filter(func(slot): return slot.item == null) #verifica se o slot esta vazio 
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].level = 1
			if item == bala.instantiate().item:
				emptyslots[0].level = 2	
			item.level = emptyslots[0].level
	update.emit()
	
	
func limpar():
	for item in slots:
		item.level = 0
		item.item = null
	update.emit() 
	
	
		
