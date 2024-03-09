class_name Health
extends Node

@export var max_health := 10.0

var current_health := max_health
var is_dead := false

signal on_health_changed(delta_health: float)
signal on_death

func modify_health(delta_health: float):
	if not is_dead:
		var prev_health = current_health
		current_health += delta_health
		
		#deny overheal
		if current_health > max_health:
			current_health = max_health
		
		#deny overdamage
		elif current_health <= 0:
			current_health = 0
			is_dead = true
			
		on_health_changed.emit(current_health - prev_health)
		if is_dead:
			on_death.emit()
		print(current_health)
