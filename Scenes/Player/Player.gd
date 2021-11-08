extends KinematicBody2D

export var speed : float = 100.0
export var acc : float = 500.0
export var friction : float = 650.0

var motion : = Vector2.ZERO
var scent_trail = []

#onready var fsm := StateMachine.new(self, $States, $States/Idle, true)

const scent_scene = preload("res://Scenes/Scent/Scent.tscn")


func _ready() -> void:
	$Timer/ScentTimer.connect("timeout", self, "add_scent")


func _physics_process(delta):
	var input_vector := Vector2.ZERO
	var _right = Input.get_action_strength("move_right")
	var _left = Input.get_action_strength("move_left")
	var _up = Input.get_action_strength("move_up")
	var _down = Input.get_action_strength("move_down")
	
	input_vector.x = int(_right) - int(_left)
	input_vector.y = int(_down) - int(_up)
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		motion = motion.move_toward(input_vector * speed, acc * delta)
	else:
		motion = motion.move_toward(Vector2.ZERO, friction * delta)
	
	motion = move_and_slide(motion)


func add_scent():
	var scent = scent_scene.instance()
	scent.player = self
	scent.position = position
	get_parent().add_child(scent)
	scent_trail.push_front(scent)
