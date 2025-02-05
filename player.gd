extends CharacterBody3D

@onready var battery: ProgressBar = $Head/Camera3D/CanvasLayer/Control/Battery
const SENSITIVITY = 0.003
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var running = false
@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera3D
@onready var flashlight: SpotLight3D = $Head/Camera3D/Flashlight
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var walking: AnimationPlayer = $Animations/walking

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x,
		deg_to_rad(-60),
		deg_to_rad(90)
		)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Flashlight_Toggle") and (battery.value >= 10 or flashlight.visible == true):
		flashlight.visible = not flashlight.visible
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if Input.is_action_just_pressed("Quit"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_just_pressed("FullScreen"):
		if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_pressed("SPACE") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("A", "D", "W", "S")
	var direction := (head.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if velocity != Vector3():
		if is_on_floor() and not running:
			walking.play("walk")
		else:
			walking.stop()
			audio_stream_player_3d.stop()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if input_dir.x>0:
		head.rotation.z = lerp_angle(head.rotation.z, deg_to_rad(-5),0.05)
	elif input_dir.x<0:
		head.rotation.z = lerp_angle(head.rotation.z, deg_to_rad(5),0.05)
	else:
		head.rotation.z = lerp_angle(head.rotation.z, deg_to_rad(0),0.05)
	
	move_and_slide()

func _play_footstep_audio():
	audio_stream_player_3d.pitch_scale = randf_range(.8,1.2)
	audio_stream_player_3d.play()
