class_name Blade
extends Weapon

@export var damage := 2.0
@export var lifesteal_per_hit := .5

@export var animation_player: AnimationPlayer
@export var swing_anim_name: StringName

var animation_over := true

var hit_objects = []

func _on_area_2d_area_entered(area: Area2D):
	#if area is an enemy
	if area.is_in_group(owner.enemy_group) and not hit_objects.has(area):
		#adds the hit object to a list that prevents it from being hit multiple times in the same swing
		hit_objects.append(area)
		#deal damage and heal user
		(area as Health).modify_health(-damage)
		owner.health.modify_health(lifesteal_per_hit)

func _on_animation_player_animation_finished(anim_name):
	animation_over = true
	#clears hit objects array, allowing the same objects to be hit on another swing
	hit_objects.clear()
	
	#start cooldown
	cooldown_chart.send_event(cooldown_event)
	on_cooldown = true

func _on_ready_state_entered():
	off_cooldown()

func do_action():
	animation_player.play(swing_anim_name)
	animation_over = false
