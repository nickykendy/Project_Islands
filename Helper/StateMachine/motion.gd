extends State
class_name Motion


func get_input_direction() -> Vector2:
	var input_direction := Vector2()
	input_direction.x = int(Input.get_action_strength("move_right")) - int(Input.get_action_strength("move_left"))
	input_direction.y = int(Input.get_action_strength("move_down")) - int(Input.get_action_strength("move_up"))
	return input_direction
