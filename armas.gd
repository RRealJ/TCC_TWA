extends Node2D

class_name Arma

@onready var marker = $"../Marker2D"
@onready var mundo = $"../../"
@export var bullet: PackedScene


func _ready():
	atirar()


func _physics_process(delta):
	look_at(get_global_mouse_position())


func atirar():
	var instancia = bullet.instantiate()
	instancia.dir = marker.rotation
	instancia.spawn_pos = marker.global_position
	instancia.spawn_rot = marker.rotation
	instancia.zdex = z_index
	mundo.add_child.call_deferred(instancia)


func _on_timer_timeout():
	atirar()
