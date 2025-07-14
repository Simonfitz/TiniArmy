extends Panel
const UNIT_RESOURSE_DIR = "res://resources/units/"
@export var IsPlayerRed = false
var selectedUnitIdx = 0
var selectedLevel = 0
var units: Array

func _ready() -> void:
	for unit in load_resources_from_folder():
		units.append(unit)

func _input(event: InputEvent):
	if not GameManager.IsStarted:
		return
		
	#if (event is InputEventJoypadButton or event is InputEventJoypadMotion) and event.device + 1 == _idx:
	if (event.is_action_pressed("Up", true) and IsPlayerRed) or (event.is_action_pressed("Up2", true) and not IsPlayerRed):
		selectedLevel+=1
		selectedLevel = clamp(selectedLevel,1 ,3)
		set_level()
	if (event.is_action_pressed("Down", true) and IsPlayerRed) or (event.is_action_pressed("Down2", true) and not IsPlayerRed):
		selectedLevel-=1
		selectedLevel = clamp(selectedLevel,1 ,3)
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
	pass
	
func set_selection():
	pass
	
func load_resources_from_folder(
	folder_path := UNIT_RESOURSE_DIR, extensions := ["tres", "res"]
) -> Array:
	var resources = []
	var dir = DirAccess.open(folder_path)

	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				for ext in extensions:
					if file_name.ends_with("." + ext):
						var full_path = folder_path + "/" + file_name
						var res = ResourceLoader.load(full_path)
						if res:
							resources.append(res)
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		push_error("Failed to open folder: " + folder_path)

	return resources
