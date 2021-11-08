extends Node

class_name StateMachine

var state_cur : State
var state_nxt : State
var state_lst : State
var states = {}
var debug := false
var obj = null


func _init(_obj, states_parent_node:Node, _int_state:State, _debug:=true) -> void:
	obj = _obj
	debug = _debug
	
	_set_states_parent_node(states_parent_node)
	state_cur = _int_state
	if state_cur != null:
		state_cur.enter()


func _set_states_parent_node(pnode:Node) -> void:
	if debug: print("Found ", pnode.get_child_count(), " states")
	
	if pnode.get_child_count() == 0:
		return
	
	var state_nodes = pnode.get_children()
	for state_node in state_nodes:
		if debug: print("Adding state: ", state_node.name)
		states[state_node.name] = state_node
		state_node.fsm = self
		state_node.obj = self.obj


func change_state(next_state:State) -> void:
	state_nxt = next_state
	if state_cur != null:
		state_lst = state_cur
		state_cur.exit()
	
	state_cur = state_nxt
	if state_cur != null:
		state_cur.enter()


func back() -> void:
	if state_cur != null:
		state_cur.exit()
		state_nxt = state_cur
		state_cur = state_lst
	
	if state_cur != null:
		state_lst = null
		state_cur.enter()


func update(delta) -> void:
	if state_cur != null:
		state_cur.execute(delta)


func is_state(state_name:String) -> bool:
	if state_cur == null:
		return false
		
	return state_cur.get_state_name() == state_name
