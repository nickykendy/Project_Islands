extends StateMachine

var fsm : StateMachine

onready var enemy = get_parent()

func _init(enemy, params):
	chase_target()

func chase_target():
	var look = enemy.get_node("RayCast2D")
	look.cast_to = (enemy.target.position - enemy.position)
	look.force_raycast_update()
	
	# if we can see the target, chase it
	if !look.is_colliding():
		enemy.dir = look.cast_to.normalized()
	# or chase first scent we can see
	else:
		for scent in enemy.target.scent_trail:
			look.cast_to = (scent.position - enemy.position)
			look.force_raycast_update()
			if !look.is_colliding():
				enemy.dir = look.cast_to.normalized()
			break

func _physics_process(delta):
	var motion = enemy.dir * enemy.speed
	enemy.move_and_slide(motion)
