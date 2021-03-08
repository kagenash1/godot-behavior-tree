class_name BTComposite
extends BTNode

# Executes every child, waiting for completion



func _tick(agent: Node, blackboard: Blackboard) -> bool:
	for c in get_children():
		var bt_child: BTNode = c
		var result = bt_child.tick(agent, blackboard)
		
		if bt_child.running() and result is GDScriptFunctionState:
			yield(result, "completed")
	return succeed()
