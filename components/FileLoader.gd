class_name FileLoader
extends Node

@export_file("*.txt") var file_path

@onready var content = FileAccess.open(file_path, FileAccess.READ)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func as_text():
	return content.get_as_text()

var strings: Array[String] = []

func as_string_array() -> Array[String]:
	if strings.size() > 0:
		return strings
	
	while !content.eof_reached():
		strings.push_back(content.get_line())
	
	return strings
