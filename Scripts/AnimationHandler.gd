extends AnimationPlayer

func _check_idle() -> bool:
	return $"../..".is_idle

func _on_front_event_received(event):
	if _check_idle():
		current_animation = "Idle_front"
	else:
		current_animation = "Walking_front"

func _on_back_event_received(event):
	if _check_idle():
		current_animation = "Idle_back"
	else:
		current_animation = "Walking_back"

func _on_left_event_received(event):
	if _check_idle():
		current_animation = "Idle_left"
	else:
		current_animation = "Walking_left"

func _on_right_event_received(event):
	if _check_idle():
		current_animation = "Idle_right"
	else:
		current_animation = "Walking_right"


func _on_animation_finished(anim_name):
	$"../../Locomotion".send_event("return")
