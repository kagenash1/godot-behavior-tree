class_name BehaviorTree, "icons/bt.svg" 
extends Node

export(bool) var is_active: bool = false
export(NodePath) var _blackboard
export(NodePath) var _agent
export(String, "idle", "physics") var sync_mode



func _ready():
	assert(get_child_count() == 1)
	
	var blackboard: Blackboard = get_node(_blackboard)
	var bt_root: BTNode = get_child(0)
	
	yield(get_tree(), "idle_frame") # To ensure the agent is ready.
	
	var agent: Node = get_node(_agent)
	var tick_result
	
	while is_active:
		tick_result = bt_root.tick(agent, blackboard)
		if bt_root.running() and tick_result is GDScriptFunctionState:
			tick_result = yield(tick_result, "completed")
		
		if sync_mode == "idle":
			yield(get_tree(), "idle_frame") 
		else:
			yield(get_tree(), "physics_frame")

