extends Resource

class_name Inv

signal update

@export var slots: Array[Inv_slot]


func insert(item: InvItem):
	var itemslots = slots.filter(func(slot): return slot.item == item) #verifica se já está preenchido
	if !itemslots.is_empty():
		itemslots[0].level += 1
		item.level = itemslots[0].level
	else:
		var emptyslots = slots.filter(func(slot): return slot.item == null) #verifica se o slot esta vazio 
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].level = 1
			item.level = emptyslots[0].level
	update.emit()
