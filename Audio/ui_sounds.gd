extends Node


@export var root_path : NodePath


@onready var sounds = {
	&"select" : AudioStreamPlayer.new(),
	&"pressed" : AudioStreamPlayer.new()
#	&"UI_Cancel" : AudioStreamPlayer.new(),
#	&"UI_Accept" : AudioStreamPlayer.new()
}


func _ready() -> void:
	assert(root_path != null, "Esvazie o root path para os sons")
	
	for i in sounds.keys():
		sounds[i].stream = load("res://Audio/" + str(i) + ".mp3")
		#mixer
		sounds[i].bus = &"sfx"
		#add na sceneTree
		add_child(sounds[i])

	install_sounds(get_node(root_path))
	
	
func install_sounds(node: Node) -> void:
	for i in node.get_children():
		if i is Button:
			i.focus_entered.connect(play_sfx_audio.bind(&"select"))
			i.pressed.connect(play_sfx_audio.bind(&"pressed"))

		#recurssivo
		install_sounds(i) 
		

func play_sfx_audio(sound: StringName) -> void:
	sounds[sound].play()
		
