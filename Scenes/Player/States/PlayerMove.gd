extends Motion


func enter() -> void:
	if debug: print(get_state_name(), " state entered.")


func execute(_delta) -> void:
	var input_vector := get_input_direction().normalized()
	if input_vector != Vector2.ZERO:
		obj.motion = obj.motion.move_toward(input_vector * obj.speed, obj.acc * _delta)
	else:
		obj.motion = obj.motion.move_toward(Vector2.ZERO, obj.friction * _delta)
	
	if obj.motion == Vector2.ZERO:
		obj.fsm.change_state(obj.fsm.states["Idle"])


func exit() -> void:
	if debug: print(get_state_name(), " state exited.")


func get_state_name() -> String:
	return "PlayerMove"
