extends Node

const GOLD_TIME = 1

var gold_timer = 0

signal OnSpawnUnit
signal OnGameOver

var PlayerRedGold = 0
var PlayerBlueGold = 0
var IsStarted = false

var UNITS_RESOURCES = [
	[
		preload("res://resources/units/unit_fighter.tres")
	],
	[
		preload("res://resources/units/unit_ranger.tres")
	]
]


func BaseDestroyed(team):
	OnGameOver.emit(team)
	
func _process(delta: float) -> void:
	if not IsStarted:
		return
		
	gold_timer  += delta
	if gold_timer > GOLD_TIME:
		PlayerRedGold += 1
		PlayerBlueGold += 1
		gold_timer = 0
	
func SpawnUnit(team, unitIdx, unitLevel):
	var unit_data: UnitInfo = UNITS_RESOURCES[unitIdx][unitLevel]

	if team == "red" and PlayerRedGold >= unit_data.cost:
		OnSpawnUnit.emit(team, unit_data)
	if team != "red" and PlayerBlueGold >= unit_data.cost:
		OnSpawnUnit.emit(team, unit_data)

func GetUnitCost(unitIdx, unitLevel) -> int:
	return unitLevel + 1
	
