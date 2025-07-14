class_name StateFighting
extends State

enum DIRECTIONS { LEFT, RIGHT }

var attack_timer := 0.0
var attack_cooldown := 1.0
var walk_timer := 0.0
var last_direction := DIRECTIONS.LEFT

@onready var unit: RigidBody2D = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"

func enter():
	animated_sprite_2d.play("fighting")

func update(delta):
	attack_timer += delta

	if attack_timer >= attack_cooldown:
		attack_timer = 0.0  # Reset the timer
	
	#TODO
	# if no valid enemy, transition state
