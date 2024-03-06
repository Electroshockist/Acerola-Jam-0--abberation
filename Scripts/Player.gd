extends CharacterBody2D
class_name Player

@export var enemy_group: StringName = "Enemy"

@export var speed = 300.0
@onready var weapon_root = $Blade
@onready var locomotion = $Locomotion
@onready var weapon_animation_player = $Blade/WeaponRoot/AnimationPlayer

enum {
	FRONT,
	BACK,
	LEFT,
	RIGHT
}

var _facing_dir := FRONT
var is_idle := true

func _ready():
	locomotion.set_expression_property("direction", 0)

func _input(event):
	if event.is_action("Slash"):
		weapon_animation_player.play("Swing Back")

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("Move Left", "Move Right", "Move Up","Move Down")
	
	velocity = direction * speed
	
	if is_idle && velocity.length() > 0:
		is_idle = false
		locomotion.send_event("walking")
	elif !is_idle && velocity.length() == 0:
		is_idle = true
		locomotion.send_event("idle")
		
	move_and_slide()
	
	_handle_anim_vars()

func _process(_delta):
	rotate_weapon()

func _handle_anim_vars():
	if velocity.y > 0:
			_facing_dir = FRONT
			
	elif velocity.y < 0:
			_facing_dir = BACK
			
	elif velocity.x < 0:
			_facing_dir = LEFT
			
	elif velocity.x > 0:
			_facing_dir = RIGHT
	
	locomotion.set_expression_property("direction", _facing_dir)

func rotate_weapon():
	var relative = get_global_mouse_position() - position
	weapon_root.rotation = atan2(relative.y, relative.x)
