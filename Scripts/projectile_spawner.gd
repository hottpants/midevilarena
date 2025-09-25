extends Node3D

const PROJECTILE = preload("res://Scenes/projectile.tscn");

@onready var timer: Timer = $Timer

func _physics_process(delta: float) -> void:
	if timer.is_stopped():
		if Input.is_action_just_pressed("fireball") and not Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			timer.start(0.5)
			var fireball = PROJECTILE.instantiate()
			add_child(fireball)
			fireball.global_transform = global_transform
