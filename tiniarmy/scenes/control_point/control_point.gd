extends Node2D

var red_tower_texture = preload("res://assets/Units/House/Tower_Red.png")
var blue_tower_texture = preload("res://assets/Units/House/Tower_Blue.png")
var tower_controller = null
@onready var sprite_2d: Sprite2D = $Sprite2D

func _on_body_entered(body: Node2D) -> void:
	change_control(body.team)
		
func change_control(new_controller):
	if tower_controller:
		if tower_controller == new_controller:
			return
		GameManager.remove_modifier(tower_controller, 1)
	GameManager.add_modifier(new_controller, 1)
	
	tower_controller = new_controller
	if new_controller == "red":
		sprite_2d.texture = red_tower_texture
	else:
		sprite_2d.texture = blue_tower_texture
	$AudioStreamPlayer2D.play()
	sprite_2d.modulate = Color.WHITE
