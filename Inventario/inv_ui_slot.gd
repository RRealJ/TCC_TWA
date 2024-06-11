extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var level_text: Label = $CenterContainer/Panel/Label


func update(slot: Inv_slot):
	if !slot.item:
		item_visual.visible = false
		level_text.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.textura
		level_text.visible = true
		level_text.text = str(slot.level)
