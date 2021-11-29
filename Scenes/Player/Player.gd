extends KinematicBody2D

export var speed : float = 100.0
export var acc : float = 500.0
export var friction : float = 650.0

var motion : = Vector2.ZERO
var scent_trail = []

onready var fsm := StateMachine.new(self, $States, $States/Idle, true)
onready var weapon : = $Pivot/Sword

const scent_scene = preload("res://Scenes/Scent/Scent.tscn")


func _ready() -> void:
	$Timer/ScentTimer.connect("timeout", self, "add_scent")


func _physics_process(delta):
	fsm.update(delta)
	motion = move_and_slide(motion)


func add_scent():
	var scent = scent_scene.instance()
	scent.player = self
	scent.position = position
	get_parent().add_child(scent)
	scent_trail.push_front(scent)
