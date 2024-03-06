extends ProgressBar
@export var health: Health

# Called when the node enters the scene tree for the first time.
func _ready():
	max_value = health.max_health
	value = health.current_health
	health.on_health_changed.connect(_on_hurtbox_on_health_changed)


func _on_hurtbox_on_health_changed(delta_health):
	value += delta_health
