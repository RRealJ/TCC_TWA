extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var level_text: Label = $CenterContainer/Panel/Label


func update(recompensa):
	item_visual.texture = recompensa.item.textura
	level_text.text = str(recompensa.level)
