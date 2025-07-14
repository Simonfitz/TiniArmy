extends Panel
@export var IsPlayerRed = false
var selectedUnitIdx = 0
var selectedLevel = 0
var unit_type_array: Array
var selected_unit: UnitInfo
@onready var levels: VBoxContainer = $Information/UnitInfo/HBoxContainer/Levels
@onready var cost_label: Label = $Information/Cost/Hbox/CostLabel
@onready var unit_icon: TextureRect = $Information/UnitInfo/HBoxContainer/UnitIcon
@onready var unit_label: Label = $Information/Selection/HBoxContainer/UnitLabel

func _input(event: InputEvent):
	if not GameManager.IsStarted:
		return

	#if (event is InputEventJoypadButton or event is InputEventJoypadMotion) and event.device + 1 == _idx:
	if (event.is_action_pressed("Up", true) and IsPlayerRed) or (event.is_action_pressed("Up2", true) and not IsPlayerRed):
		selectedLevel+=1
		selectedLevel = clamp(selectedLevel,0 ,2)
		set_level()
	if (event.is_action_pressed("Down", true) and IsPlayerRed) or (event.is_action_pressed("Down2", true) and not IsPlayerRed):
		selectedLevel-=1
		selectedLevel = clamp(selectedLevel,0 ,2)
		set_level()

	if (event.is_action_pressed("Left", true) and IsPlayerRed) or (event.is_action_pressed("Left2", true) and not IsPlayerRed):
		selectedUnitIdx-=1
		if selectedUnitIdx < 0:
			selectedUnitIdx = 3
		set_selection()
	if (event.is_action_pressed("Right", true) and IsPlayerRed) or (event.is_action_pressed("Right2", true) and not IsPlayerRed):
		selectedUnitIdx+=1
		if selectedUnitIdx > 3:
			selectedUnitIdx = 0
		set_selection()

	if (event.is_action_pressed("Spawn", true) and IsPlayerRed) or (event.is_action_pressed("Spawn2", true) and not IsPlayerRed):
		var team = "red" if IsPlayerRed else "blue"
		GameManager.SpawnUnit(team, selectedUnitIdx, selectedLevel)

func set_level():
	for child in levels.get_children():
		child.self_modulate = Color(1,1,1,0.5)
	levels.get_children()[selectedLevel].self_modulate = Color(1,1,1,1)
	set_cost()

func set_selection():
	unit_type_array = GameManager.get_resouce(selectedUnitIdx)
	selected_unit = unit_type_array[selectedLevel]
	unit_icon.texture = unit_type_array[0].icon
	unit_label.text = unit_type_array[0].nice_name
	set_cost()
	
func set_cost():
	cost_label.text = str(selected_unit.cost)
	
