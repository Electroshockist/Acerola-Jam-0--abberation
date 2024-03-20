class_name Gun
extends Weapon

const projectile = preload("res://Prefabs/Projectile.tscn")
	
func _input(event):
	if event.is_action_pressed("Fire"):
		try_action()

func do_action():
	var proj = projectile.instantiate()
		
	#adds player velocity to bullet
#	var p = owner as Player
#	var dot = p.velocity.dot(Vector2.from_angle(rotation))
#	var added_vel = dot #* p.velocity.length()
#	proj.speed += added_vel
	
	proj.rotation = rotation
	proj.global_position = owner.global_position
	proj.enemy_group = enemy_group
	
	get_tree().root.add_child(proj)
	
	

func _on_ready_state_entered():
	off_cooldown()
