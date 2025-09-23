extends Node3D


@onready var Player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player_character = preload("res://player.tscn")
	Player = player_character.instantiate()
	add_child(Player)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
