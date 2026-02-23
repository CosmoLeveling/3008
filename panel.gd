extends Panel

@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var pos = (get_parent().get_parent().get_parent().get_parent().find_child("GridMap").local_to_map(get_parent().get_parent().get_parent().position))
	label.text = str(pos.x/20) +" , " + str(pos.z/20)
