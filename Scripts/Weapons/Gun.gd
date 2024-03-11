extends Weapon

var projectile_root:Node

const projectile = preload("res://Prefabs/Projectile.tscn")

func _ready():
	projectile_root = Node.new()
	add_child(projectile_root)
	
func _input(event):
	if event.is_action_pressed("Fire"):
		try_action()
		
		

func do_action():
	var proj = projectile.instantiate()
		
#		var p = owner as Player
#
#		var dot = p.velocity.dot(Vector2.from_angle(rotation))
#
#		print(Vector2.from_angle(rotation).length())
#
#		var added_vel = dot #* p.velocity.length()
#
#		proj.speed += added_vel
	
	proj.rotation = rotation
	proj.global_position = owner.global_position
	projectile_root.add_child(proj)
	
	

func _on_ready_state_entered():
	off_cooldown()
