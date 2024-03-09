extends Node

@onready var weapon_animation_player = $Blade/"Weapon Root"/AnimationPlayer
@onready var weapon_root = $Blade

func _input(event):
	if event.is_action("Slash"):
		weapon_animation_player.play("Swing Back")

func _process(_delta):
	rotate_weapon()

func rotate_weapon():
	var p = get_parent()
	var relative = p.get_global_mouse_position() - p.position
	weapon_root.rotation = atan2(relative.y, relative.x)
