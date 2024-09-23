extends TextEdit


@onready var label = $MarginContainer/Label

var texto := "" as String

func mostrar_texto(texto_mostrar: String):
	label.text = texto_mostrar
