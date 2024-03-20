extends CharacterBody2D
class_name Player

@export var enemy_group: StringName = "Enemy"

@export var speed = 300.0
@onready var locomotion = $"Locomotion Anim"

@export var health : Health
@export var blade : Blade
@export var gun : Gun

enum {
	FRONT,
	BACK,
	LEFT,
	RIGHT
}

var _facing_dir := FRONT
var is_idle := true

func _ready():
	gun.enemy_group = enemy_group
	blade.enemy_group = enemy_group
	
	locomotion.set_expression_property("direction", 0)
	
	if not health:
		health = $Hurtbox

func _input(event):
	if event.is_action("Slash"):
		blade.try_action(false)

func _physics_process(_delta):
	if Input.is_action_just_pressed("Hurt myself today"):
		$Hurtbox.modify_health(-1)
		
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

func _on_hurtbox_on_death():
	queue_free()
	set_process(false)
	set_physics_process(false)
	
	_disable_children(self)
		
#todo: fix
func _disable_children(node: Node):
	for child in node.get_children():
		print(child.name)
		_disable_children(child)
		child.queue_free()
