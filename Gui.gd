extends Control

@onready var flashlight: SpotLight3D = $"../../Flashlight"
@onready var battery: ProgressBar = $Battery

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if flashlight.visible:
		battery.value -=.01
	else:
		battery.value +=.01
	
	if battery.value == 0:
		flashlight.visible = false
