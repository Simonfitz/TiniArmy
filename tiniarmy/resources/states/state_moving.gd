class_name StateMoving
extends State

enum DIRECTIONS { LEFT, RIGHT }

const MOVE_DISTANCE = 50
const MAX_STATE_DURATION = 5.0

var state_timer := 0.0
var walk_duration := 1.0
var walk_timer := 0.0
var last_direction := DIRECTIONS.LEFT

@onready var unit: RigidBody2D = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"


func enter():
	animated_sprite_2d.play("idle")


func update(delta):
	state_timer += delta
	walk_timer += delta

	if walk_timer >= walk_duration:
		walk_timer = 0.0  # Reset the timer
		walk()

	if state_timer >= MAX_STATE_DURATION:
		state_timer = 0.0
		transition.emit(self, "Idle")
		
	if unit.can_attack:
		transition.emit(self, "Fighting")


func walk():
	animated_sprite_2d.play("moving")
	var new_unit_pos = Vector2(unit.position.x + MOVE_DISTANCE*unit.direction, unit.position.y)
	if can_move(new_unit_pos):
		var movement_tween = create_tween()
		movement_tween.tween_property(unit, "position", new_unit_pos, walk_duration)
		last_direction = DIRECTIONS.LEFT


func can_move(new_unit_pos):
	return true
