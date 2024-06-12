extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_display
@onready var level_text: Label = $CenterContainer/Panel/Label

func _ready():
	level_text.visible = false
	item_visual.visible = false

func update(recompensa):
	if recompensa is InvItem:
		item_visual.texture = recompensa.textura
		level_text.text = str(recompensa.level)
	else:
		item_visual.texture = recompensa.item.textura
		level_text.text = str(recompensa.item.level + 1)
		level_text.visible = true
	item_visual.visible = true
