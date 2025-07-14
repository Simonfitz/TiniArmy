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
	animated_sprite_2d.play("moving")


func update(delta):
	state_timer += delta
	walk_timer += delta

	if walk_timer >= walk_duration:
		walk_timer = 0.0  # Reset the timer
		walk_right() #TODO move direction based on team

	if state_timer >= MAX_STATE_DURATION:
		state_timer = 0.0
		transition.emit(self, "Idle")


func walk_left():
	animated_sprite_2d.flip_h = false
	animated_sprite_2d.play("walk")
	var new_unit_pos = Vector2(unit.position.x - MOVE_DISTANCE, unit.position.y)
	if can_move(new_unit_pos):
		var movement_tween = create_tween()
		movement_tween.tween_property(unit, "position", new_unit_pos, walk_duration)
		last_direction = DIRECTIONS.LEFT


func walk_right():
	animated_sprite_2d.flip_h = true
	animated_sprite_2d.play("walk")
	var new_unit_pos = Vector2(unit.position.x + MOVE_DISTANCE, unit.position.y)
	if can_move(new_unit_pos):
		var movement_tween = create_tween()
		movement_tween.tween_property(unit, "position", new_unit_pos, walk_duration)
		last_direction = DIRECTIONS.LEFT

func can_move(new_unit_pos):
	pass
