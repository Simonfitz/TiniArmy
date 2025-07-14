extends Node2D

const UnitScene: PackedScene = preload("res://scenes/unit/unit.tscn")

@onready var red_spawn: SpawnPoint = $SpawnPoints/RedSpawn
@onready var blue_spawn: SpawnPoint = $SpawnPoints/BlueSpawn


func _ready() -> void:
	GameManager.OnSpawnUnit.connect(on_unit_spawn)

func _process(delta: float) -> void:
	pass	

func on_unit_spawn(team: String, unit_data: UnitInfo):
	if team == "red":
		if red_spawn.TrySpawn(unit_data, UnitScene):
			GameManager.PlayerRedGold -= unit_data.cost
	else:
		if blue_spawn.TrySpawn(unit_data, UnitScene):
			GameManager.PlayerBlueGold -= unit_data.cost
