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

var left_hand: String
var right_hand: String

var left_empty := true
var right_empty := true

func hold_item(item: String):
	if not get_right() == "":
		set_left(item)
	else: set_right(item)
	print("item: " + get_right())
	print("item: " + get_left())
	if get_left() == "sword" and left_empty:
		spawn_sword("left")
	if get_right() == "sword" and right_empty:
		spawn_sword("right")
	
func spawn_sword(hand: String):
	var sword = SWORD.instantiate()
	$Camera3D.add_child(sword)
	match hand:
		"left":
			left_empty = false
		"right":
			right_empty = false
#sword overrites fireball


func get_left():
	return left_hand
func get_right():
	return right_hand
func set_left(s: String):
	left_hand = s
func set_right(s: String):
	right_hand = s
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	
	

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
