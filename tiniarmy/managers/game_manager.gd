extends Node

const GOLD_TIME = 1

var gold_timer = 0

var PlayerRedGold = 0
var PlayerBlueGold = 0

func BaseDestroyed():
	print("do something")
	
func _process(delta: float) -> void:
	gold_timer  += delta
	if gold_timer > GOLD_TIME:
		PlayerRedGold += 1
		PlayerBlueGold += 1
		gold_timer = 0
	
