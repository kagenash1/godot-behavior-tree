class_name BTRepeatUntil, "res://addons/behavior_tree/icons/btrepeatuntil.svg"
extends BTDecorator

# Repeats until specified state is returned, then sets state to child state

export(int, "failure", "success") var until_what

onready var expected = bool(until_what)



func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var result = not expected
	
	while result != expected:
		result = bt_child.tick(agent, blackboard)
		
		if result is GDScriptFunctionState:
			result = yield(result, "completed")
	
	return set_state(bt_child)
