extends Camera3D
@onready var Floor = preload("res://Floor.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_W):
		position.z -= .1
	if Input.is_key_pressed(KEY_S):
		position.z += .1
	if Input.is_key_pressed(KEY_A):
		position.x -= .1
	if Input.is_key_pressed(KEY_D):
		position.x += .1
	if Input.is_action_just_pressed("place"):
		var newt = Floor.instantiate()
		newt.global_position = position
		get_parent().add_child(newt)
