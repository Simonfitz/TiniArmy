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
	animated_sprite_2d.play("fighting")


func update(delta):
	state_timer += delta
	walk_timer += delta

	if walk_timer >= walk_duration:
		walk_timer = 0.0  # Reset the timer
		walk_random()

	if state_timer >= MAX_STATE_DURATION:
		state_timer = 0.0
		transition.emit(self, "Idle")


func walk_left():
	animation.flip_h = false
	animation.play("walk")
	var new_monster_pos = Vector2(monster.position.x - MOVE_DISTANCE, monster.position.y)
	if can_move(new_monster_pos):
		var movement_tween = create_tween()
		movement_tween.tween_property(monster, "position", new_monster_pos, walk_duration)
		last_direction = DIRECTIONS.LEFT


func walk_right():
	animation.flip_h = true
	animation.play("walk")
	var new_monster_pos = Vector2(monster.position.x + MOVE_DISTANCE, monster.position.y)
	if can_move(new_monster_pos):
		var movement_tween = create_tween()
		movement_tween.tween_property(monster, "position", new_monster_pos, walk_duration)
		last_direction = DIRECTIONS.LEFT

func can_move(new_monster_pos):
	pass
