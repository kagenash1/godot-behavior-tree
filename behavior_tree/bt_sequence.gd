class_name BTSequence, "icons/btsequence.svg" 
extends BTComposite

func _tick(agent: Node, blackboard: Blackboard) -> bool:
	for c in get_children():
		var bt_child: BTNode = c
		var result = bt_child.tick(agent, blackboard)
		if bt_child.running() and result is GDScriptFunctionState:
			yield(result, "completed")
		if bt_child.failed():
			return fail()
	return succeed()
