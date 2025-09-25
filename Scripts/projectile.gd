extends ShapeCast3D

@export var speed := 20.0
const gravity := 1.03
var velocity := 1.0
@export var damage := 30

func _physics_process(delta: float) -> void:
	position += global_basis * Vector3.FORWARD * delta * speed
	position += global_basis * Vector3.DOWN * delta * velocity
	velocity *= gravity
	target_position = Vector3.FORWARD * delta * speed
	
	force_shapecast_update()
	
	
	
	if is_colliding():
		var collider = get_collider(0)
		print("PENIS")
		if collider is Enemy:
			collider.take_damage(damage)
		global_position = get_collision_point(0)
		set_physics_process(false)
		queue_free()
	
func cleanup() -> void:
	queue_free()
