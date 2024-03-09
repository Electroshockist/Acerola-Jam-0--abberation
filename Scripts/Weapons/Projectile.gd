extends Area2D

@export var speed := 300.0

func _physics_process(delta):
	global_position += Vector2.from_angle(rotation) * speed * delta
