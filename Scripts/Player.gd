extends CharacterBody2D


@export var speed = 300.0

enum {
	BACK,
	FRONT,
	LEFT,
	RIGHT
}

var _facing_dir := FRONT
var _is_idle := true

func _input(event):
	
	if event.is_action("Move Down"):
		if _facing_dir != FRONT:
			_facing_dir = FRONT
			$StateChart.send_event("front")
			
	elif event.is_action("Move Up"):
		if _facing_dir != BACK:
			_facing_dir = BACK
			$StateChart.send_event("back")
			
	elif event.is_action("Move Left"):
		if _facing_dir != LEFT:
			_facing_dir = LEFT
			$StateChart.send_event("left")
			
	elif event.is_action("Move Right"):
		if _facing_dir != RIGHT:
			_facing_dir = RIGHT
			$StateChart.send_event("right")
	

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("Move Left", "Move Right", "Move Up","Move Down")
	
	velocity = direction * speed
	
	if _is_idle && velocity.length() > 0:
		_is_idle = false
		$StateChart.send_event("moving")
		print("Started Moving")
	elif !_is_idle && velocity.length() == 0:
		_is_idle = true
		$StateChart.send_event("idle")
		print("Stopped Moving")
		
	
	move_and_slide()
