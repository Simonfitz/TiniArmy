class_name Unit
extends RigidBody2D

const LAYERS = {
	"red": 2,
	"blue": 3,
}

var direction: int = 1 # positive or negitive to multiply speed by
var can_attack: bool = false
var blocked: bool = false
var enemy_team: String
@export var team: String
@export var unit_info: UnitInfo
@export var unit_state: String = "Moving"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var enemy_ray_cast_2d: RayCast2D = $EnemyRayCast2D
@onready var ally_ray_cast_2d: RayCast2D = $AllyRayCast2D


# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite_2d.sprite_frames = unit_info.spriteframes
	update_values_for_team()
	set_layers()
	set_masks()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	enemy_in_range()
	ally_in_range()

func die():
	queue_free()
	
func set_team(team_name: String):
	team = team_name

func update_values_for_team():
	if team == "red":
		direction = 1
		animated_sprite_2d.flip_h = false
		enemy_team = "blue"
	else:
		direction = -1
		animated_sprite_2d.flip_h = true
		enemy_team = "red"
	update_range()
	
func update_range():
	enemy_ray_cast_2d.target_position = enemy_ray_cast_2d.target_position * direction
	ally_ray_cast_2d.target_position = ally_ray_cast_2d.target_position * direction

func enemy_in_range():
	if enemy_ray_cast_2d.is_colliding():
		can_attack = true
	else:
		can_attack = false
		
func ally_in_range():
	if ally_ray_cast_2d.is_colliding():
		blocked = true
	else:
		blocked = false
	
func set_layers():
	set_collision_layer_value(LAYERS[team], true)
	
func set_masks():
	set_collision_mask_value(LAYERS[team], true)
	ally_ray_cast_2d.set_collision_mask_value(LAYERS[team], true)
	enemy_ray_cast_2d.set_collision_mask_value(LAYERS[enemy_team], true)
