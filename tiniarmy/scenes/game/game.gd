extends Node2D

const UnitScene: PackedScene = preload("res://scenes/unit/unit.tscn")

@onready var red_spawn: SpawnPoint = $SpawnPoints/RedSpawn
@onready var blue_spawn: SpawnPoint = $SpawnPoints/BlueSpawn

@onready var game_over_panel: Panel = $CanvasLayer/GameOverPanel
@onready var label_red: Label = $CanvasLayer/GameOverPanel/VBoxContainer/LabelRed
@onready var label_blue: Label = $CanvasLayer/GameOverPanel/VBoxContainer/LabelBlue

@onready var game_start_panel: Panel = $CanvasLayer/GameStartPanel
@onready var label_red_ready: Label = $CanvasLayer/GameStartPanel/VBoxContainer/LabelRed
@onready var label_blue_ready: Label = $CanvasLayer/GameStartPanel/VBoxContainer/LabelBlue
@onready var audio_stream_player_ready: AudioStreamPlayer = $AudioStreamPlayerReady


var is_red_ready:= false
var is_blue_ready:= false
var is_game_over:= false

var game_over_cooldown = 2

func _ready() -> void:
	GameManager.OnSpawnUnit.connect(on_unit_spawn)
	GameManager.OnGameOver.connect(on_game_over)
	game_over_panel.hide()
	game_start_panel.show()

func _process(delta: float) -> void:
	if is_game_over:
		game_over_cooldown -= delta

func _input(event: InputEvent):
	if GameManager.IsStarted:
		return
		
	if event.is_action_pressed("Spawn", true):
		is_red_ready = true
		label_red_ready.text = "Red Ready!"
		audio_stream_player_ready.play()
	if event.is_action_pressed("Spawn2", true):
		is_blue_ready = true
		label_blue_ready.text = "Blue Ready!"
		audio_stream_player_ready.play()

	if is_red_ready and is_blue_ready:
		game_start_panel.hide()
		GameManager.IsStarted = true

func on_unit_spawn(team: String, unit_data: UnitInfo):
	if game_over_cooldown < 0:
		get_tree().reload_current_scene()

	if team == "red":
		if red_spawn.TrySpawn(unit_data, UnitScene):
			GameManager.PlayerRedGold -= unit_data.cost
	else:
		if blue_spawn.TrySpawn(unit_data, UnitScene):
			GameManager.PlayerBlueGold -= unit_data.cost

func on_game_over(team_died):
	is_game_over = true
	if team_died == "red":
		label_red.hide()
		label_blue.show()
	else:
		label_red.show()
		label_blue.hide()
		
	game_over_panel.show()

func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
	
