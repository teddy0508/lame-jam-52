extends CharacterBody3D

var moveSpeed := 7.0
const mouseSensitivity := 0.001
@onready var sfx_footsteps = $AudioStreamPlayer3D

const bobFreq = 1.5
const bobAmp = 0.2
var t_bob = 0.0

@onready var object = $Head
@onready var camera = $Head/Camera3D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		object.rotate_y(-event.relative.x * mouseSensitivity)
		
		
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	

func _process(delta: float) -> void:
	var input = Input.get_vector("move_forward", "move_backward", "move_right", "move_left")
	var direction = (object.transform.basis * Vector3(input.x, 0, input.y)).normalized()
	if direction:
		velocity.x = direction.x * moveSpeed
		velocity.z = direction.z * moveSpeed
	else:
		velocity.x = 0.0
		velocity.z = 0.0
		sfx_footsteps.play()
		
		
	t_bob += delta * velocity.length()
	camera.transform.origin = _headbob(t_bob)
	
	move_and_slide()

func _headbob(time) -> Vector3 :
	var pos = Vector3.ZERO
	pos.y = sin(time * bobFreq) * bobAmp
	return pos
	
