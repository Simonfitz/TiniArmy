extends RigidBody2D

@export var team: String
@export var sprite_texture: Texture
@onready var sprite_2d: Sprite2D = $Sprite2D

@onready var destroyed_castle_texture = preload("res://assets/Units/House/Castle_Destroyed.png")
@onready var hitmark_scene: PackedScene = preload("res://scenes/hitmark/hitmark.tscn")

@onready var castle: RigidBody2D = $"."
@onready var healthbar: HealthBar = $Healthbar
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var health: int = 50
var is_dead = false

func _ready():
	sprite_2d.texture = sprite_texture
	healthbar.Setup(health, health)

func take_damage(damage):
	health -= damage
	var hitmarkObj = hitmark_scene.instantiate()
	hitmarkObj.SetDmg(damage)
	castle.add_child(hitmarkObj)
	healthbar.SetHP(health)
	if health <= 0:
		lose()

func lose():
	is_dead = true
	audio_stream_player_2d.play()
	sprite_2d.texture = destroyed_castle_texture
	GameManager.BaseDestroyed(team)
