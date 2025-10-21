extends Node3D

@onready var anim_player = $AnimationPlayer
@onready var hitbox = $MeshInstance3D/hitbox
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("swing"):
		anim_player.play("attack")
		hitbox.monitoring = true
		
func _on_animation_player_animation_finished(anim_name) -> void:
	print("finished")
	if anim_name == "attack":
		anim_player.play("idle")
		hitbox.monitoring = false
		

func _on_hitbox_body_entered(body: Node3D) -> void:
	if body is Enemy:
		print ("balls hit")
