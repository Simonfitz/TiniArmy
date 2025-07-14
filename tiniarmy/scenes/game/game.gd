extends Node2D

const UnitScene: PackedScene = preload("res://scenes/unit/unit.tscn")
const UNIT_FIGHTER = preload("res://resources/units/unit_fighter.tres")
const UNIT_RANGER = preload("res://resources/units/unit_ranger.tres")
const UNITS = [UNIT_FIGHTER, UNIT_RANGER]

@onready var red_spawn: SpawnPoint = $SpawnPoints/RedSpawn
@onready var blue_spawn: SpawnPoint = $SpawnPoints/BlueSpawn


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _input(event: InputEvent):
	#if (event is InputEventJoypadButton or event is InputEventJoypadMotion) and event.device + 1 == _idx:
	if event.is_action_pressed("Left", true):
		SpawnRed(UNITS.pick_random())
		return
	
	if event.is_action_pressed("Right", true):
		SpawnBlue(UNITS.pick_random())
		return

func SpawnRed(unitInfo: UnitInfo):
	var unitCost = 1
	if GameManager.PlayerRedGold > unitCost and red_spawn.TrySpawn(unitInfo, UnitScene):
		GameManager.PlayerRedGold -= unitCost

func SpawnBlue(unitInfo: UnitInfo):
	var unitCost = 1
	if GameManager.PlayerBlueGold > unitCost and blue_spawn.TrySpawn(unitInfo, UnitScene):
		GameManager.PlayerBlueGold -= unitCost
