class_name SpawnPoint extends Node2D

@onready var spawn_point: SpawnPoint = $"."
@export var IsRed = false

var team_name = "red"
var is_vacant = true

func _ready() -> void:
	team_name = "red" if IsRed else "blue"

func _process(delta: float) -> void:
	$SpawnArea2D/VacantIndicator.visible = is_vacant
	pass

func TrySpawn(unitInfo: UnitInfo, unitScene: PackedScene) -> bool:
	if not is_vacant:
		print("Something in the way")
		return false
	
	var unit: Unit = unitScene.instantiate()
	unit.unit_info = unitInfo
	unit.set_team(team_name)
	spawn_point.add_child(unit)
	return true

func _on_spawn_area_2d_body_entered(body: Node2D) -> void:
	if body is not Unit:
		return
		
	if body.team == team_name:
		is_vacant = false

func _on_spawn_area_2d_body_exited(body: Node2D) -> void:
	if body is not Unit:
		return
		
	if body.team == team_name:
		is_vacant = true
