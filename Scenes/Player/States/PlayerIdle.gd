extends Motion


func enter() -> void:
	if debug: print(get_state_name(), " state entered.")


func execute(_delta) -> void:
	var input_direction = get_input_direction();
	if input_direction:
		obj.fsm.change_state(obj.fsm.states["Move"])


func exit() -> void:
	if debug: print(get_state_name(), " state exited.")


func get_state_name() -> String:
	return "PlayerIdle"
