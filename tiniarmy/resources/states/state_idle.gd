class_name StateIdle
extends State

@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"


func enter():
	animated_sprite_2d.play("idle")
	
func update():
	pass
