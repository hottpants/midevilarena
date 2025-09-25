extends ShapeCast3D

@export var speed := 20.0
const gravity := 1.03
var velocity := 1.0
@export var damage := 30

const EXPLOSION_SOUND = preload("res://Scenes/3dsound.tscn")
const EXPLOSION = preload("res://Scenes/explosion.tscn")
const EXPLOSION_AREA = preload("res://Scenes/explosion_area.tscn")

func _physics_process(delta: float) -> void:
	position += global_basis * Vector3.FORWARD * delta * speed
	position += global_basis * Vector3.DOWN * delta * velocity
	velocity *= gravity
	target_position = Vector3.FORWARD * delta * speed
	
	force_shapecast_update()

	if is_colliding():
		var collider = get_collider(0)
		#if collider is Enemy:
			#collider.take_damage(damage)
		
		
		global_position = get_collision_point(0)
		var new_sound = EXPLOSION_SOUND.instantiate()
		var new_explosion = EXPLOSION.instantiate()
		var new_explosion_area = EXPLOSION_AREA.instantiate()
		
		add_sibling(new_explosion_area)
		add_sibling(new_explosion)
		new_explosion.global_position = global_position
		new_explosion_area.global_position = global_position
		new_sound.stream = load("res://Audio/explosion-312361.mp3")
		add_sibling(new_sound)
		new_sound.global_position = global_position
		new_sound.set_pitch_scale(randf_range(0.5, 1.5))
		new_sound.play()
		
		
		
		set_physics_process(false)
		queue_free()
	
func cleanup() -> void:
	queue_free()
