extends AudioStreamPlayer

@onready var environment: WorldEnvironment = $"../Environment"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if environment.environment == preload("res://Night.tres") and stream != preload("res://night_music.tres"):
		stream = preload("res://night_music.tres")
		play()
	elif environment.environment == preload("res://Day.tres") and stream == preload("res://night_music.tres"):
		stream = preload("res://day_music.tres")
		play()
