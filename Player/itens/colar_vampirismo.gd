extends Node2D


@onready var inv: Inv = preload("res://Inventario/player_inv.tres")
@export var item: InvItem
@onready var mundo = $"../../"
@onready var menu_pausa = $"../../camera/menu_pausa"
@onready var recompensas_ui = $"../../camera/Recompensas"


func _ready() -> void:
	$"..".vampirismo = item.level
