extends KinematicBody2D

export var speed : float = 100.0

var velocity : Vector2
var scent_trail = []

const scent_scene = preload("res://Scenes/Scent.tscn")


func _ready() -> void:
	$ScentTimer.connect("timeout", self, "add_scent")


func _physics_process(delta):
	var _right = Input.is_action_pressed("move_right")
	var _left = Input.is_action_pressed("move_left")
	var _up = Input.is_action_pressed("move_up")
	var _down = Input.is_action_pressed("move_down")
	
	var hspd = int(_right) - int(_left)
	var vspd = int(_down) - int(_up)
	
	velocity = Vector2(hspd, vspd).normalized()
	
	velocity = move_and_slide(velocity * speed)


func add_scent():
	var scent = scent_scene.instance()
	scent.player = self
	scent.position = position
	get_parent().add_child(scent)
	scent_trail.push_front(scent)
