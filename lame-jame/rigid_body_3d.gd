extends CharacterBody3D

var moveSpeed := 5.0
const mouseSensitivity := 0.001


@onready var camera = $Camera3D
@onready var playerObject = $MeshInstance3D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		playerObject.rotate_y(event.relative.x * mouseSensitivity)
		camera.rotate_x(event.relative.y * mouseSensitivity)
	
	
	

func _process(delta: float) -> void:
	var input = Input.get_vector("move_forward", "move_backwards", "move_right", "move_left")
	var direction = (transform.basis * Vector3(input.x, 0, input.y)).normalized()
	if direction:
		velocity.x = direction.x * moveSpeed
		velocity.z = direction.z * moveSpeed
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	
