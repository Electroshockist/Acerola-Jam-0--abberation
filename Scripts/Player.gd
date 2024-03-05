extends CharacterBody2D
class_name Player

@export var speed = 300.0

enum {
	BACK,
	FRONT,
	LEFT,
	RIGHT
}

var _facing_dir := FRONT
var is_idle := true

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("Move Left", "Move Right", "Move Up","Move Down")
	
	velocity = direction * speed
	
	if is_idle && velocity.length() > 0:
		is_idle = false
		$Locomotion.send_event("walking")
		print("Started Moving")
	elif !is_idle && velocity.length() == 0:
		is_idle = true
		$Locomotion.send_event("idle")
		print("Stopped Moving")
		
	
	move_and_slide()
	
	_handle_anim_vars()

func _handle_anim_vars():
	if velocity.y < 0:
			_facing_dir = FRONT
			
	elif velocity.y > 0:
			_facing_dir = BACK
			
	elif velocity.x < 0:
			_facing_dir = LEFT
			
	elif velocity.x > 0:
			_facing_dir = RIGHT
			
	$Locomotion.set_expression_property("direction", _facing_dir)
