extends Node

@onready var weapon_animation_player = $Blade/"Weapon Root"/AnimationPlayer
@onready var blade_root = $Blade
@onready var gun_root = $Gun

func _input(event):
	if event.is_action("Slash"):
		weapon_animation_player.play("Swing Back")

func _process(_delta):
	rotate_weapon()

func rotate_weapon():
	var p = get_parent()
	var relative = p.get_global_mouse_position() - p.position
	var rot := atan2(relative.y, relative.x)
	blade_root.rotation = rot
	gun_root.rotation = rot
	
	
	
