extends Node2D


func _ready():
	$AnimationPlayer.play("fade_in")
	await get_tree().create_timer(1).timeout
	$CanvasLayer/NinePatchRect/AnimatedSprite2D.play("intro")
	

func _on_animated_sprite_2d_animation_finished():
	$AnimationPlayer.play("fade_out")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")


func _unhandled_input(event):
	if event.is_action_pressed("enter"):
		get_tree().change_scene_to_file("res://Menus/main_menu.tscn")
