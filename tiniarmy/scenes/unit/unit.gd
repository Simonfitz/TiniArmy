class_name Unit
extends RigidBody2D

var unit_info: UnitInfo
var unit_state: String = "Moving"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite_2d.sprite_frames = unit_info.spriteframes
	animated_sprite_2d.play("moving")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func die():
	queue_free()
