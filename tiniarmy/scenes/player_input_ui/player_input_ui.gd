extends Panel

@export var IsPlayerRed = false

@onready var labelPlayer: Label = $VBoxContainer/HBoxContainer/LabelPlayer
@onready var label_gold: Label = $VBoxContainer/HBoxContainer/LabelGold

@onready var texture_hand_warrior: TextureRect = $VBoxContainer/GridContainerWarrior/TextureHand
@onready var label_level_warrior: Label = $VBoxContainer/GridContainerWarrior/LabelLevel
@onready var label_name_warrior: Label = $VBoxContainer/GridContainerWarrior/LabelName

@onready var texture_hand_archer: TextureRect = $VBoxContainer/GridContainerArcher/TextureHand
@onready var label_name_archer: Label = $VBoxContainer/GridContainerArcher/LabelName
@onready var label_level_archer: Label = $VBoxContainer/GridContainerArcher/LabelLevel

var selectedUnitIdx = 0
var selectedLevel = 0

func _ready() -> void:
	labelPlayer.text = "Red" if IsPlayerRed else "Blue"
	update_display()

func _process(delta: float) -> void:
	label_gold.text = str(GameManager.PlayerRedGold) if IsPlayerRed else str(GameManager.PlayerBlueGold)

func _input(event: InputEvent):
	#if (event is InputEventJoypadButton or event is InputEventJoypadMotion) and event.device + 1 == _idx:
	if (event.is_action_pressed("Up", true) and IsPlayerRed) or (event.is_action_pressed("Up2", true) and not IsPlayerRed):
		selectedUnitIdx -= 1
		if selectedUnitIdx < 0:
			selectedUnitIdx = 2
		update_display()
	if (event.is_action_pressed("Down", true) and IsPlayerRed) or (event.is_action_pressed("Down2", true) and not IsPlayerRed):
		selectedUnitIdx += 1
		if selectedUnitIdx > 2:
			selectedUnitIdx = 0
		update_display()
		
	if (event.is_action_pressed("Left", true) and IsPlayerRed) or (event.is_action_pressed("Left2", true) and not IsPlayerRed):
		selectedLevel = maxi(0, selectedLevel - 1)
		update_display()
	if (event.is_action_pressed("Right", true) and IsPlayerRed) or (event.is_action_pressed("Right2", true) and not IsPlayerRed):
		selectedLevel = mini(3, selectedLevel + 1)
		update_display()
		
	if (event.is_action_pressed("Spawn", true) and IsPlayerRed) or (event.is_action_pressed("Spawn2", true) and not IsPlayerRed):
		var team = "red" if IsPlayerRed else "blue"
		GameManager.SpawnUnit(team, selectedUnitIdx, selectedLevel)


func update_display():
	label_gold.text = str(GameManager.PlayerRedGold) if IsPlayerRed else str(GameManager.PlayerBlueGold)
	
	label_level_warrior.text = str(selectedLevel)
	label_level_archer.text = str(selectedLevel)
	
	texture_hand_warrior.hide()
	texture_hand_archer.hide()
	if selectedUnitIdx == 0:
		texture_hand_warrior.show()
	elif selectedUnitIdx == 1:
		texture_hand_archer.show()
	
