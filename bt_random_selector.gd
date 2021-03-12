class_name BTRandomSelector, "icons/btrndselector.svg"
extends BTComposite

# Executes a random child and is successful at the first successful tick.
# Attempts a number of ticks equal to the number of children. If no successful
# child was found, it fails.

func _tick(agent: Node, blackboard: Blackboard) -> bool:
	randomize()
	var result
	var n_children = get_child_count()
	
	for i in n_children:
		var rand_idx = randi() % n_children
		bt_child = get_child(rand_idx)
		
		result = bt_child.tick(agent, blackboard)
		
		if result is GDScriptFunctionState:
			result = yield(result, "completed")
		
		if bt_child.succeeded():
			return succeed()
	
	return fail()
