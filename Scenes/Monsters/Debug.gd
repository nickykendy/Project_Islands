extends Node2D

onready var ray = get_parent().get_node("RayCast2D")
var rayDisabledColor := Color.yellow
var rayCollisionColor := Color.red


func _process(_delta):
	self.update()


func _draw():
	_draw_ray(ray)


func _draw_ray(_ray:RayCast2D):
	var start = _ray.position
	var rayLenMultiplier = 1.0
	var end = start + _ray.cast_to.rotated(_ray.rotation) * rayLenMultiplier
	var color: Color
	var size = 1.0
	
	if !ray.enabled:
		color = rayDisabledColor
	elif ray.is_colliding():
		color = rayCollisionColor
	
	self.draw_line(start, end, color, size)
