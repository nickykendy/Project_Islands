extends State


func enter() -> void:
	if debug: print(get_state_name(), " state entered.")
	obj.get_node("Timer/IdleTimer").start()
	obj.idle_done = false


func execute(_delta) -> void:
	if obj.idle_done:
		obj.fsm.change_state(obj.fsm.states["Chase"])


func exit() -> void:
	if debug: print(get_state_name(), " state exited.")


func get_state_name() -> String:
	return "Idle"
