extends KinematicBody2D

onready var fsm := StateMachine.new(self, $States, $States/Idle, false)
onready var ray := $RayCast2D

var idle_done := false
var chase_done := false
var can_track := false

export var speed := 50.0
var dir : Vector2

var target : KinematicBody2D


func _ready():
	target = get_parent().get_node("Player")


func _physics_process(delta):
	fsm.update(delta)


func _exit_tree():
	fsm.free()


func _on_IdleTimer_timeout():
	idle_done = true


func _on_ChaseTimer_timeout():
	chase_done = true


func _on_TrackTimer_timeout():
	can_track = true
