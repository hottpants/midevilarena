class_name Enemy

extends CharacterBody3D

const DAMAGE_TEXTURE = preload("res://Resources/damage_texture.tres")
const ENEMY_TEXTURE = preload("res://Resources/enemy_texture.tres")
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

const _3DSOUND = preload("res://Scenes/3dsound.tscn")

@export var health = 100

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func take_damage(damage: int):
	var new_sound = _3DSOUND.instantiate()
	new_sound.stream = load("res://Audio/young-man-being-hurt-95628.mp3")
	add_sibling(new_sound)
	new_sound.global_position = global_position
	new_sound.play()
	$EnemyShape/DamageTimer.start()
	$EnemyShape.set_surface_override_material(0, DAMAGE_TEXTURE)
	health -= damage
	if health <= 0:
		
		queue_free()

func _on_damage_timer_timeout() -> void:
	$EnemyShape.set_surface_override_material(0, ENEMY_TEXTURE)
