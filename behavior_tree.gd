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
	
	while is_active:
		bt_root.tick(agent, blackboard)
		
		if sync_mode == "idle":
			yield(get_tree(), "idle_frame") 
		else:
			yield(get_tree(), "physics_frame")

