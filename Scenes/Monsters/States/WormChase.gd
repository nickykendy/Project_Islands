extends State


func enter() -> void:
	if debug: print(get_state_name(), " state entered.")
	obj.get_node("Timer/ChaseTimer").start()
	obj.get_node("Timer/TrackTimer").start()
	obj.chase_done = false
	obj.can_track = true


func execute(_delta) -> void:
	if obj.target and obj.can_track:
		chase_target()
		obj.can_track = false
	
	if obj.target and !obj.chase_done:
		var motion = obj.dir.normalized()
		obj.move_and_slide(motion * obj.speed)
	
	if obj.chase_done:
		obj.fsm.change_state(obj.fsm.states["Idle"])


func exit() -> void:
	if debug: print(get_state_name(), " state exited.")


func get_state_name() -> String:
	return "Chase"


func chase_target():
	var look :RayCast2D = obj.ray
	look.cast_to = (obj.target.global_position - obj.global_position)
	look.force_raycast_update()
	
	# if we can see the target, chase it
	if !look.is_colliding():
		obj.dir = look.cast_to.normalized()
	
	# or chase the first scent we can see
	else:
		for scent in obj.target.scent_trail:
			look.cast_to = (scent.global_position - obj.global_position)
			look.force_raycast_update()
			
			if !look.is_colliding():
				obj.dir = look.cast_to.normalized()
				break
