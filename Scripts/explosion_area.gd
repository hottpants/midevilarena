extends Area3D

var damage := 30
@export var size := 5

func _ready() -> void:
	$CollisionShape3D.shape.set_radius(size)

func _on_body_entered(body: Node3D) -> void:
	if body is Enemy:
		var distance = sqrt(((global_position.x - body.global_position.x) ** 2) + ( (global_position.y - body.global_position.y) ** 2) + ( (global_position.z - body.global_position.z) ** 2))
		body.take_damage(damage * (size - distance)/size)
		print("DAMAGE: " + str(damage * (size - distance)/size))
	queue_free()
