class_name Weapon

extends Node2D

@export var cooldown_chart : StateChart
@export var cooldown_event : StringName

var on_cooldown := false

func try_action(start_cooldown := true):
	if not on_cooldown:
		do_action()
		if start_cooldown:
			cooldown_chart.send_event(cooldown_event)
			on_cooldown = true

func off_cooldown():
	on_cooldown = false

func do_action():
	pass
