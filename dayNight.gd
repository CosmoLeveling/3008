extends DirectionalLight3D
@onready var environment: WorldEnvironment = $"../Environment"
const NIGHT = preload("res://Night.tres")
const DAY = preload("res://Day.tres")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_K):
		environment.environment = NIGHT
		visible = false
	if Input.is_key_pressed(KEY_G):
		environment.environment = DAY
		visible = true
	
