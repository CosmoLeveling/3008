extends Marker3D
const SENSITIVITY = 0.003
const WALK_SPEED = 0.1
@onready var head = $Head
@onready var camera = $Head/Camera3D
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x,
		deg_to_rad(-60),
		deg_to_rad(90)
		)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("SPACE"):
		position.y += 0.1
	if Input.is_action_pressed("CTRL"):
		position.y -= 0.1
	var input_dir = Input.get_vector("A", "D", "W", "S")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		position.x += direction.x * WALK_SPEED
		position.z += direction.z * WALK_SPEED
