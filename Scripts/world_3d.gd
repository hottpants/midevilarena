extends Node3D
## penis
const PLAYER = preload("res://Scenes/player.tscn")
const ENEMY = preload("res://Scenes/enemy.tscn")

var player
var paused := false
@onready var MENU = $"../HUD/Menu"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	MENU.visible = false
	player = PLAYER.instantiate()
	add_child(player)
	
	var enemy = ENEMY.instantiate()
	enemy.global_position = Vector3(randi_range(-25, 25), 0, randi_range(-25, 25))
	add_child(enemy)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE: ## PAUSED
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			MENU.visible = false
			paused = false
		else:                                            ## NOT PAUSED
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			MENU.visible = true
			paused = true


func _on_resume_pressed() -> void:
	if paused:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		MENU.visible = false
		paused = false
		player.paused = false
		


func _on_exit_pressed() -> void:
	get_tree().quit()
