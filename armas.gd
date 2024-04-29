extends Node2D

class_name Arma


@onready var mundo = $"../../" #mundo atual
@export var bullet: PackedScene


func _ready():
	atirar()


func _physics_process(delta):
	look_at(get_global_mouse_position())
	

func atirar():
	var instancia = bullet.instantiate()
	instancia.dir = rotation
	instancia.spawn_pos = global_position
	instancia.spawn_rot = rotation
	instancia.zdex = z_index
	mundo.add_child.call_deferred(instancia)


func _on_cooldown_timeout():
	atirar()
