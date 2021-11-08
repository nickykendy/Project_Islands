extends Node

class_name State

# warning-ignore:unused_class_variable
var fsm = null
# warning-ignore:unused_class_variable
var obj = null
# warning-ignore:unused_class_variable
var debug = true


func enter() -> void:
	pass


func execute(_delta) -> void:
	pass


func exit() -> void:
	pass


func get_state_name() -> String:
	return "UnknownState"
