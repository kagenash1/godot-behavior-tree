class_name BTRepeat, "../../../icons/btrepeat.svg"
extends BTDecorator

# Executes child "iterations" times and returns the last state and tick result
 
export(int, 0, 999) var iterations = 1



func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var result
	
	for i in iterations:
		result = bt_child.tick(agent, blackboard)
		
		if result is GDScriptFunctionState:
			result = yield(result, "completed")
	
	return set_state(bt_child)
