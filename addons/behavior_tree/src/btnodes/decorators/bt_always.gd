class_name BTAlways, "res://addons/behavior_tree/icons/btalways.svg"
extends BTDecorator

# Executes the child and always either succeeds or fails.

export(String, "fail", "succeed") var always_what



func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var result = bt_child.tick(agent, blackboard)
	
	if result is GDScriptFunctionState:
		result = yield(result, "completed")
	
	return call(always_what)
