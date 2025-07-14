extends Node

const GOLD_TIME = 1
const BASE_GOLD_VALUE = 1
var gold_timer = 0

signal OnSpawnUnit

var PlayerRedGold = 0
var PlayerBlueGold = 0
var modifiers: Dictionary = {
	"red": 1,
	"blue": 1,
}
var UNITS_RESOURCES = [
	[
		preload("res://resources/units/unit_fighter.tres")
	],
	[
		preload("res://resources/units/unit_ranger.tres")
	]
]


func BaseDestroyed():
	print("do something")
	
func _process(delta: float) -> void:
	gold_timer  += delta
	if gold_timer > GOLD_TIME:
		PlayerRedGold += BASE_GOLD_VALUE*get_modifier("red")
		PlayerBlueGold += BASE_GOLD_VALUE*get_modifier("blue")
		gold_timer = 0
	
func SpawnUnit(team, unitIdx, unitLevel):
	var unit_data: UnitInfo = UNITS_RESOURCES[unitIdx][unitLevel]

	if team == "red" and PlayerRedGold >= unit_data.cost:
		OnSpawnUnit.emit(team, unit_data)
	if team != "red" and PlayerBlueGold >= unit_data.cost:
		OnSpawnUnit.emit(team, unit_data)

func GetUnitCost(unitIdx, unitLevel) -> int:
	return unitLevel + 1

func add_modifier(team: String, value: int):
	modifiers[team] += value

func remove_modifier(team: String, value: int):
	modifiers[team] -= value
	
func get_modifier(team: String):
	return modifiers[team]
