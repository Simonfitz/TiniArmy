extends Node

@export var initial_state: State

var states: Dictionary
var current_state: State

@onready var unit: RigidBody2D = $".."
@onready var state_label: Label = $"../StateLabel"



func _ready():
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.transition.connect(state_transition)

	if initial_state:
		initial_state.enter()
		current_state = initial_state


func _process(delta):
	if current_state:
		current_state.update(delta)


func set_state(new_state_name):
	if current_state:
		current_state.exit()

	current_state = states[new_state_name]
	current_state.enter()
	unit.unit_state = new_state_name


func state_transition(state_called_from: State, new_state_name: String):
	# Fast fail invalid states
	if state_called_from != current_state:
		print_debug("A non-active state has called a transition. Ignoring.")
		return
	if new_state_name not in states:
		print_debug("no state named: ", new_state_name)
		return

	current_state.exit()
	await current_state.exited
	current_state = states[new_state_name]
	current_state.enter()
	unit.unit_state = new_state_name
	state_label.text = new_state_name
