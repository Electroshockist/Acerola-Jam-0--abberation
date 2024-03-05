extends Node

@export var max_health := 10.0

var _current_health := max_health

signal on_hurt(damage: float)
signal on_heal(heal: float)
signal on_death

func modify_health(damage: float):
	if damage > 0 and  _current_health + damage <= max_health:
		_current_health += damage
		on_heal.emit(damage)
		return
		
	if _current_health - damage <= 0:
		_current_health = 0
		on_death.emit()
		return
		
	_current_health -= damage
	on_hurt.emit(damage)
