class_name State
extends Node

# Used by derived classes so can ignore this debugger warning
@warning_ignore("unused_signal")
signal transition
signal exited


func enter():
	pass


func exit():
	exited.emit()


func _process(_delta):
	pass
