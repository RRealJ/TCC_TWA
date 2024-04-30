extends Node2D

@onready var anim = $anim


func _on_anim_animation_finished(anim_name):
	queue_free()
