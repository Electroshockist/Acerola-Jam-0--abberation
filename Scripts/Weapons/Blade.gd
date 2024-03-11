extends Node2D
@export var damage := 2.0

func _on_area_2d_area_entered(area: Area2D):
	if area.is_in_group(owner.enemy_group):
		((area as Node)as Health).modify_health(-damage)
