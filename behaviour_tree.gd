class_name BehaviourTree, "icons/bt.svg" 
extends Node

export(bool) var is_active: bool = false
export(NodePath) var _blackboard
export(NodePath) var _agent


func _ready():
	assert(get_child_count() == 1)
	var blackboard: Blackboard = get_node(_blackboard)
	var bt_root: BTNode = get_child(0)
	yield(get_tree(), "idle_frame")
	var agent: Node = get_node(_agent)
	while is_active:
		bt_root.tick(agent, blackboard)
		yield(get_tree(), "idle_frame")

