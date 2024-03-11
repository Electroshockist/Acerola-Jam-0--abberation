extends Weapon
@export var damage := 2.0

@onready var animation_player = $"Weapon Root/AnimationPlayer"

var animation_over := true

func _input(event):
	if event.is_action("Slash"):
		try_action(false)

func _on_area_2d_area_entered(area: Area2D):
	if area.is_in_group(owner.enemy_group):
		((area as Node)as Health).modify_health(-damage)

func _on_animation_player_animation_finished(anim_name):
	animation_over = true
	#start cooldown
	cooldown_chart.send_event(cooldown_event)
	on_cooldown = true

func _on_ready_state_entered():
	off_cooldown()

func do_action():
	animation_player.play("Swing Back")
	animation_over = false
