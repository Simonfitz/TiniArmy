class_name Unit
extends RigidBody2D

const MOVE_TIMER = 3
const CURRENCY_TIMER = 2
const WALKSPEED = 300
const THROW_MODIFIER = 0.2

var monster_info: MonsterLoaded
var on_floor: bool = false
var move_timer = 0
var monster_state: String = "Falling"



# Called when the node enters the scene tree for the first time.
func _ready():
	animation.sprite_frames = monster_info.spriteframes
	animation.play("default")
	adjust_node_scales_and_positions()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	currency_timer += delta
	if currency_timer > CURRENCY_TIMER:
		currency_timer = 0
		generate_currency()

	if dragging:
		global_position = get_global_mouse_position() + drag_offset

	is_on_floor()


func _physics_process(delta):
	if dragging:
		var current_mouse_pos = get_global_mouse_position()
		global_position = current_mouse_pos + drag_offset

		# Estimate velocity
		velocity_on_release = (current_mouse_pos - last_mouse_pos) / delta
		last_mouse_pos = current_mouse_pos


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			print("pressed: " + monster_info.name)
			if get_global_mouse_position().distance_to(global_position) < 32:
				# Begin dragging
				dragging = true
				state_machine.set_state("Dragging")
				drag_offset = global_position - get_global_mouse_position()
		elif dragging == true:
			# End dragging
			dragging = false
			state_machine.set_state("Falling")
			print("throwing: " + monster_info.name)
			linear_velocity = velocity_on_release * THROW_MODIFIER


func die():
	GameManager.remove_active_monster(monster_info)
	queue_free()


func is_on_floor():
	if detect_floor.is_colliding():
		on_floor = true
	else:
		on_floor = false


func correct_monster_orientation():
	if rotation != 0:
		rotation = 0


func collect_currency():
	var currency_orbs_to_generate = reduce_to_base_10_values(monster_info.accumulated_currency)
	for orb_value in currency_orbs_to_generate:
		var new_popup = currency_popup.instantiate()
		new_popup.collection_position = get_menu_character_position()
		new_popup.value = orb_value
		add_child(new_popup)
	monster_info.accumulated_currency = 0


func reduce_to_base_10_values(number: int) -> Array:
	var units = []
	var str_num = str(number)
	var length = str_num.length()

	for i in range(length):
		var digit = int(str_num[i])
		var place_value = pow(10, length - i - 1)
		for value in range(digit):
			units.append(int(place_value))
	return units


func get_menu_character_position():
	var character_position = get_parent().get_node_or_null("NewCornerMenu").get_character_location()
	return character_position


func generate_currency():
	var currency_modifier = 1 * get_value_mofifier()
	var currency_total = monster_info.value * currency_modifier
	monster_info.accumulated_currency += currency_total


func get_value_mofifier():
	var mod = get_currency_modifiers() * get_family_modifiers() * get_rarity_modifier()
	return mod


func get_currency_modifiers():
	var modifier = 1.0
	var all_modifiers = GameManager.currency_modifiers
	for mod in all_modifiers:
		modifier += float(all_modifiers[mod])
	return modifier


func get_family_modifiers():
	var modifier = 1.0
	var all_modifiers = GameManager.monster_modifiers
	for family in all_modifiers:
		for mod in all_modifiers[family]:
			modifier += float(all_modifiers[family][mod])
	return modifier


func get_rarity_modifier():
	var rarity_modifiers = {
		0: 1.0,
		1: 1.1,
		2: 1.2,
		3: 1.3,
		4: 1.5,
		5: 2.0,
	}
	return rarity_modifiers[monster_info.rarity]


func adjust_node_scales_and_positions():
	adjust_monster_animation()
	adjust_monster_hitbox()
	adjust_monster_button()


func adjust_monster_animation():
	var frame_texture = animation.sprite_frames.get_frame_texture(animation.animation, 0)
	var height = frame_texture.get_height() * monster_info.sprite_scale.y
	animation.scale = monster_info.sprite_scale
	animation.position = Vector2(0, -height / 2)


func adjust_monster_hitbox():
	var frame_texture = animation.sprite_frames.get_frame_texture(animation.animation, 0)
	var size = frame_texture.get_size() * monster_info.sprite_scale
	hitbox.shape.size = size
	hitbox.position = Vector2(0, -size.y / 2)


func adjust_monster_button():
	var frame_texture = animation.sprite_frames.get_frame_texture(animation.animation, 0)
	var size = frame_texture.get_size() * monster_info.sprite_scale
	button.size = size
	button.position = Vector2(-size.x / 2, -size.y)


func _on_button_remove_monster_button_down():
	timer.start()


func _on_button_remove_monster_button_up():
	if not timer.is_stopped():
		die()
