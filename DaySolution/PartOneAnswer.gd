extends Label

@onready var file_loader: FileLoader = $"../FileLoader" as FileLoader

# Called when the node enters the scene tree for the first time.
func _ready():
	var value = get_parent().part_one(
		file_loader.as_string_array()
	)
	
	set_text(str(value))
