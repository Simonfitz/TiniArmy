class_name StateMoving
extends State

enum DIRECTIONS { LEFT, RIGHT }

const BASE_MOVE_DISTANCE = Vector2(100, 0)

var walk_duration := 0.1
var walk_timer := 0.0

@onready var unit: RigidBody2D = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"


func enter():
	walk()


func update(delta):
	walk_timer += delta
	if walk_timer >= walk_duration:
		walk_timer = 0.0  # Reset the timer
		walk()
		
	if unit.can_attack:
		transition.emit(self, "Fighting")
		
	if unit.blocked:
		transition.emit(self, "Idle")


func walk():
	if can_move():
		animated_sprite_2d.play("moving")
		unit.linear_velocity = BASE_MOVE_DISTANCE * unit.direction


func can_move():
	return true
