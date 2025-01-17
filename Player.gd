extends CharacterBody3D


var SPEED = 25.0
const JUMP_VELOCITY = 0

var SENSITIVITY = 0.005

@onready var Neck := $NeckNode
@onready var Camera := $NeckNode/Camera3D

var scriptdothingyplease = GlobalVarsScript

var BOB_FREQ = 1.1
var BOB_AMP = 0.075
var t_bob = 0.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			Neck.rotate_y(-event.relative.x * SENSITIVITY)
			Camera.rotate_x(-event.relative.y * SENSITIVITY)
			Camera.rotation.x = clamp(Camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (Neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if Input.is_action_pressed("run"):
		SPEED = 30.0
		BOB_AMP = 0.075
	elif Input.is_action_just_released("run"):
		SPEED = 25.0
		BOB_AMP = 0.09
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	t_bob += delta * velocity.length() * float(is_on_floor())
	Neck.transform.origin = _headbob(t_bob)
	move_and_slide()
	
	GlobalVarsScript.playerPosition = self.transform.origin
	return BOB_AMP

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos

func _on_area_3d_area_entered1(_area):
	GlobalVarsScript.levergodown1 = true

func _on_area_3d_area_entered2(_area):
	GlobalVarsScript.levergodown2 = true

func _on_area_3d_area_entered3(_area):
	GlobalVarsScript.levergodown3 = true

func _on_area_3d_area_entered4(_area):
	GlobalVarsScript.levergodown4 = true

func _on_area_3d_area_entered5(_area):
	GlobalVarsScript.levergodown5 = true

func _on_area_3d_area_entered6(_area):
	GlobalVarsScript.levergodown6 = true
