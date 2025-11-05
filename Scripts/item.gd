extends Node3D

const SWORD = preload("res://Scenes/sword.tscn")
const FIREBALL = preload("res://Scenes/fireball_body.tscn")

#@onready var player = get_sibling(Player)
#signal to set fireball
var weapon_selected

var weapons = [SWORD,FIREBALL]

#signal item_picked_up(item_name)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	weapon_selected = weapons.pick_random()
	var weapon = weapon_selected.instantiate()
	add_child(weapon)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_hitbox_body_entered(body: Node3D) -> void:
	if body is Player:
		if weapon_selected == FIREBALL: 
			body.hold_item("fireball")
		if weapon_selected == SWORD: 
			body.hold_item("sword")
		queue_free()
