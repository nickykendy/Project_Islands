extends Node2D


onready var my_tilemap : TileMap = $TileMap
onready var display : Label = $HUD/Control/display
onready var modeName : Label = $HUD/Control/Labelmode2

var squareNum : int = 0
var totalSquareNum : int

const EMPTY : = -1
const SOFT : = 0
const SEA : = 4


func _ready() -> void:
	totalSquareNum = my_tilemap.get_used_cells_by_id(SOFT).size()


func _process(delta : float) -> void:
	if Input.is_action_just_pressed("mode"):
		if Global.mode:
			Global.mode = false
			if my_tilemap.has_method("init_astar"):
				my_tilemap.init_astar()
		else:
			Global.mode = true
	
	if Global.mode:
		var mouse_position = get_global_mouse_position()
		var local_position = my_tilemap.to_local(mouse_position)
		var map_position = my_tilemap.world_to_map(local_position)
		var tile_index = my_tilemap.get_cellv(map_position)
		
		if Input.is_action_just_pressed("left_mouse") and tile_index == SOFT:
			my_tilemap.set_cellv(map_position, SEA)
			squareNum = squareNum + 1
		
		if Input.is_action_just_pressed("right_mouse") and tile_index == SEA and squareNum > 0:
			my_tilemap.set_cellv(map_position, SOFT)
			squareNum = squareNum - 1
	
	_update_display()


func _update_display() -> void:
	display.text = String(squareNum) + "/" + String(totalSquareNum)
	if Global.mode:
		modeName.text = "Construct"
	else:
		modeName.text = "Normal"
#
#
#func _unhandled_input(event : InputEvent) -> void:
#	if not event is InputEventMouseButton:
#		return
#	if event.button_index != BUTTON_LEFT or not event.pressed:
#		return
#
#	var new_path : = nav_2d.get_simple_path(character.global_position, get_global_mouse_position())
#	line_2d.points = new_path
#	character.path = new_path
