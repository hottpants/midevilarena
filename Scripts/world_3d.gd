extends Node3D

const PLAYER = preload("res://Scenes/player.tscn")
const ENEMY = preload("res://Scenes/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var player = PLAYER.instantiate()
	add_child(player)
	
	var enemy = ENEMY.instantiate()
	enemy.global_position = Vector3(randi_range(-25, 25), 0, randi_range(-25, 25))
	add_child(enemy)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
