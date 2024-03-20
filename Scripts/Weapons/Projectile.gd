extends Area2D

@export var speed := 450.0
@export var damage := 2.0
@export var max_lifetime := 5.0

var enemy_group : StringName

var _lifetime := 0.0

func _physics_process(delta):
	global_position += Vector2.from_angle(rotation) * speed * delta
	
	_lifetime += delta
	if _lifetime >= max_lifetime:
		queue_free()
	

func _on_area_entered(area: Area2D):
	if area.is_in_group(enemy_group):
		if area is Health:
			(area as Health).modify_health(-damage)
			queue_free()
