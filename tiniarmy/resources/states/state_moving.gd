class_name StateMoving
extends State

enum DIRECTIONS { LEFT, RIGHT }

const MOVE_DISTANCE = 50
const MAX_STATE_DURATION = 5.0

var state_timer := 0.0
var walk_duration := 1.0
var walk_timer := 0.0
var last_direction := DIRECTIONS.LEFT

@onready var monster = $"../.."
@onready var animation = $"../../Animation"


func enter():
	monster.correct_monster_orientation()


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
	if movement_within_bounds(new_monster_pos):
		var movement_tween = create_tween()
		movement_tween.tween_property(monster, "position", new_monster_pos, walk_duration)
		last_direction = DIRECTIONS.LEFT


func walk_right():
	animation.flip_h = true
	animation.play("walk")
	var new_monster_pos = Vector2(monster.position.x + MOVE_DISTANCE, monster.position.y)
	if movement_within_bounds(new_monster_pos):
		var movement_tween = create_tween()
		movement_tween.tween_property(monster, "position", new_monster_pos, walk_duration)
		last_direction = DIRECTIONS.LEFT


func walk_random():
	var rand = randi() % 2 == 0
	if rand:
		walk_current_direction()
	else:
		walk_new_direction()


func walk_current_direction():
	if is_moving_right():
		walk_right()
	else:
		walk_left()


func walk_new_direction():
	if is_moving_right():
		walk_left()
	else:
		walk_right()


func is_moving_right():
	if last_direction == DIRECTIONS.RIGHT:
		return true
	return false


func stop_walking():
	pass


func randomize_state_duration():
	state_timer = randf_range(1, MAX_STATE_DURATION - walk_duration)


func movement_within_bounds(monster_position) -> bool:
	var window_size = get_window().size
	var frame_texture = animation.sprite_frames.get_frame_texture(animation.animation, 0)
	var monster_x_offset = frame_texture.get_width() / 2
	# Check the monster y pos
	if monster_position.y <= window_size.y:
		# Check x position is not out of bounds on either side of window
		if (
			monster_position.x - monster_x_offset > 0
			and monster_position.x + monster_x_offset < window_size.x
		):
			return true
	return false
