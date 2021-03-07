class_name BTSelector, "icons/btselector.svg"
extends BTNode

func _tick(agent: Node, blackboard: Blackboard) -> bool:
	for c in get_children():
		var bt_child: BTNode = c
		var result = bt_child.tick(agent, blackboard)
		if bt_child.running() and result is GDScriptFunctionState:
			run()
			yield(result, "completed")
		if bt_child.succeeded():
			return succeed()
	return fail()
