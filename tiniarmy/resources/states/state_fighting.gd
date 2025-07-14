class_name StateFighting
extends State

enum DIRECTIONS { LEFT, RIGHT }

var walk_timer := 0.0
var last_direction := DIRECTIONS.LEFT
var is_attacking = false

@onready var unit: RigidBody2D = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func enter():
	animated_sprite_2d.play("idle")

func update(delta):
	if not is_attacking:
		is_attacking = true
		animated_sprite_2d.play("fighting")
		await animated_sprite_2d.animation_finished
		unit.target.take_damage(unit.unit_info.attack)
		is_attacking = false
	
	if not unit.can_attack:
		transition.emit(self, "Idle")
