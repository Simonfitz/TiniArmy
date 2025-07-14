class_name StateIdle
extends State

const MAX_STATE_DURATION = 5.0
var state_timer := 0.0
@onready var unit: Unit = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"


func enter():
	randomize_state_duration()
	begin_idle()


func update(delta):
	state_timer += delta
	if state_timer >= MAX_STATE_DURATION:
		transition.emit(self, "moving")


func begin_idle():
	animated_sprite_2d.play("idle")


func randomize_state_duration():
	state_timer = randf_range(1, MAX_STATE_DURATION)
