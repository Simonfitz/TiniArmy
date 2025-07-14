extends Panel

@export var IsPlayerRed = false

@onready var labelPlayer: Label = $VBoxContainer/LabelPlayer
@onready var label_gold: Label = $VBoxContainer/HBoxContainer/LabelGold


func _ready() -> void:
	labelPlayer.text = "Red" if IsPlayerRed else "Blue"

func _process(delta: float) -> void:
	label_gold.text = str(GameManager.PlayerRedGold) if IsPlayerRed else str(GameManager.PlayerBlueGold)
