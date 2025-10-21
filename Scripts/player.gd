class_name Player

extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var friction := 0.8

var paused := false

var look_dir: Vector2
@onready var camera = $Camera3D
var camera_sens = 50
const SWORD = preload("res://Scenes/sword.tscn")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	var sword = SWORD.instantiate()
	add_child(sword)
	
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	elif not velocity == Vector3(0,0,0) and is_on_floor():
		velocity *= friction
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("pause"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE: ## PAUSED
			paused = false
		else:                                            ## NOT PAUSED
			paused = true
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	_rotate_camera(delta)
	move_and_slide()


func _input(event: InputEvent):
	if event is InputEventMouseMotion: look_dir = event.relative * 0.01

func _rotate_camera(delta: float, sens_mod: float = 1.0):
	if not paused:
		var input = Input.get_vector("look_left", "look_right", "look_down", "look_up")
		look_dir += input
		rotation.y -= look_dir.x * camera_sens * delta
		camera.rotation.x = clamp(camera.rotation.x - look_dir.y * camera_sens * sens_mod * delta, -1.5, 1.5)
		look_dir = Vector2.ZERO 
