class_name BTSelector, "icons/btselector.svg"
extends BTComposite

# Ticks its children until ANY of them succeeds, thus succeeding.
# If ALL of the children fails, it fails as well.

func _tick(agent: Node, blackboard: Blackboard) -> bool:
	for c in get_children():
		var bt_child: BTNode = c
		
		var result = bt_child.tick(agent, blackboard)
		if bt_child.running() and result is GDScriptFunctionState:
			yield(result, "completed")
		
		if bt_child.succeeded():
			return succeed()
	
	return fail()
