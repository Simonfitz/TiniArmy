extends RigidBody2D

@export var team: String
@export var sprite_texture: Texture
var health: int = 10
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var destroyed_castle_texture = preload("res://assets/Units/House/Castle_Destroyed.png")

func _ready():
	sprite_2d.texture = sprite_texture

func take_damage(damage):
	health -= damage
	if health <= 0:
		lose()

func lose():
	sprite_2d.texture = destroyed_castle_texture
	#TODO emite some signal to game
