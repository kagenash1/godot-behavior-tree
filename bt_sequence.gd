class_name BTSequence, "icons/btsequence.svg" 
extends BTComposite

# Ticks its children as long as ALL of them are successful.
# Successful if ALL the children are successful.
# Fails if ANY of the children fails.



func _tick(agent: Node, blackboard: Blackboard) -> bool:
	for c in get_children():
		var bt_child: BTNode = c
		var result = bt_child.tick(agent, blackboard)
		if bt_child.running() and result is GDScriptFunctionState:
			yield(result, "completed")
		if bt_child.failed():
			return fail()
	return succeed()
