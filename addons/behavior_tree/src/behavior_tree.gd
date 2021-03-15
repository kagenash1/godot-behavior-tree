class_name BehaviorTree, "res://addons/behavior_tree/icons/bt.svg" 
extends Node

# This is your main node. Put one of these at the root of the scene and start adding BTNodes.
# A Behavior Tree only accepts ONE entry point (so one child), for example a BTSequence or a BTSelector.

export(bool) var is_active: bool = false
export(NodePath) var _blackboard
export(NodePath) var _agent
export(String, "idle", "physics") var sync_mode
export(bool) var debug = false


func _ready():
	assert(get_child_count() == 1)
	yield(get_tree(), "idle_frame") # To ensure the agent is ready.
	run()


func run():
	var blackboard: Blackboard = get_node(_blackboard)
	var bt_root: BTNode = get_child(0)
	var agent: Node = get_node(_agent)
	var tick_result
	
	while is_active:
		if debug:
			print()
		
		tick_result = bt_root.tick(agent, blackboard)
		
		if tick_result is GDScriptFunctionState:
			tick_result = yield(tick_result, "completed")
		
		if sync_mode == "idle":
			yield(get_tree(), "idle_frame") 
		else:
			yield(get_tree(), "physics_frame")
