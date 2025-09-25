extends AudioStreamPlayer3D

func _ready():
	finished.connect(kill)

func kill():
	queue_free()
