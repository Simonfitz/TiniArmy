extends Node2D

const UnitScene: PackedScene = preload("res://scenes/unit/unit.tscn")
const UNIT_FIGHTER = preload("res://resources/units/unit_fighter.tres")

@onready var red_spawn: SpawnPoint = $SpawnPoints/RedSpawn
@onready var blue_spawn: SpawnPoint = $SpawnPoints/BlueSpawn


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _input(event: InputEvent):
	#if (event is InputEventJoypadButton or event is InputEventJoypadMotion) and event.device + 1 == _idx:
	if event.is_action_pressed("Right", true):
		SpawnRed(UNIT_FIGHTER)
		return
	
	if event.is_action_pressed("Left", true):
		SpawnRed(UNIT_FIGHTER)
		return


func SpawnRed(unitInfo: UnitInfo):
	red_spawn.TrySpawn(unitInfo, UnitScene)

func SpawnBlue(unitInfo: UnitInfo):
	blue_spawn.TrySpawn(unitInfo, UnitScene)
