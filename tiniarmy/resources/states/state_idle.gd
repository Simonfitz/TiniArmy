class_name StateIdle
extends State

@onready var unit: Unit = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"


func enter():
	begin_idle()


func update(_delta):
	if not unit.blocked:
		transition.emit(self, "Moving")


func begin_idle():
	animated_sprite_2d.play("idle")
