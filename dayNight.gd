extends DirectionalLight3D
@onready var environment: WorldEnvironment = $"../Environment"
@export var audio: AudioStreamPlayer
const NIGHT = preload("res://Night.tres")
const DAY = preload("res://Day.tres")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Night"):
		environment.environment = NIGHT
		visible = false
	if event.is_action_pressed("Day"):
		environment.environment = DAY
		visible = true
	audio.swap()
