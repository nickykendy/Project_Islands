extends State


func enter() -> void:
	if debug: print(get_state_name(), " state entered.")


func execute(_delta) -> void:
	pass


func exit() -> void:
	if debug: print(get_state_name(), " state exited.")


func get_state_name() -> String:
	return "PlayerHurt"
