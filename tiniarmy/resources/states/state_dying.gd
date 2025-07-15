class_name StateDying
extends State

@onready var unit: Unit = $"../.."
@onready var animated_sprite_2d: AnimatedSprite2D = $"../../AnimatedSprite2D"


func enter():
	die()

func die():
	unit.healthbar.hide()
	unit.is_dead = true
	unit.can_attack = false
	animated_sprite_2d.hide()
	$"../../CollisionShape2D".disabled = true
	unit.audio_stream_player_2d_spawn_die.finished.connect(on_die_sound_finished)
	unit.audio_stream_player_2d_spawn_die.play()

func on_die_sound_finished():
	unit.audio_stream_player_2d_spawn_die.finished.disconnect(on_die_sound_finished)
	unit.queue_free()
