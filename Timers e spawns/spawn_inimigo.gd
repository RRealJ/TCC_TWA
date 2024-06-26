extends Node2D


@export var spawns: Array[Spawn_info] = []

@onready var player = $"../Player"

var time = 0

func _ready():
	if player == null:
		get_tree().get_nodes_in_group("Player")
	
	
func _on_timer_timeout():
	if get_tree().paused == false:
		time += 1
		var inimigo_spawns = spawns
		if get_tree().paused == false:
			for i in inimigo_spawns:
				await get_tree().paused == false
				if time >= i.time_start and time <= i.time_end:
					if i.inimigo_delay_counter < i.inimigo_spawn_delay:
						i.inimigo_delay_counter += 1
					else:
						i.inimigo_delay_counter = 0
						var novo_inimigo = load(str(i.inimigo.resource_path))			
						var counter = 0
						while counter < i.inimigo_num:
							var inimigo_spawn = novo_inimigo.instantiate()
							inimigo_spawn.global_position = get_random_position()
							add_child(inimigo_spawn)
							counter += 1
					
						
func get_random_position():
	var vpr = get_viewport_rect().size * randf_range(1.1, 1.4)
	var top_left = Vector2(player.global_position.x - vpr.x/2, player.global_position.y - vpr.y/2)
	var top_right = Vector2(player.global_position.x + vpr.x/2, player.global_position.y - vpr.y/2)
	var bottom_left = Vector2(player.global_position.x - vpr.x/2, player.global_position.y + vpr.y/2)
	var bottom_right = Vector2(player.global_position.x + vpr.x/2, player.global_position.y + vpr.y/2)
	var pos_lado = ["up", "down", "right", "left"].pick_random()
	var spawn_pos1 = Vector2.ZERO
	var spawn_pos2 = Vector2.ZERO
	
	match pos_lado:
		"up":
			spawn_pos1 = top_left
			spawn_pos2 = top_right
		"down":
			spawn_pos1 = bottom_left
			spawn_pos2 = bottom_right
		"right":
			spawn_pos1 = top_right
			spawn_pos2 = bottom_right
		"left":
			spawn_pos1 = top_left
			spawn_pos2 = bottom_left
			
	var x_spawn = randf_range(spawn_pos1.x, spawn_pos2.x)
	var y_spawn = randf_range(spawn_pos1.y, spawn_pos2.y)
	return Vector2(x_spawn, y_spawn)
