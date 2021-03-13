class_name BTRevert, "icons/btrevert.svg"
extends BTDecorator

# Succeeds if the child fails and viceversa.

func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var result = bt_child.tick(agent, blackboard)
	
	if result is GDScriptFunctionState:
		result = yield(result, "completed")
	
	if bt_child.succeeded():
		return fail()
	else:
		return succeed()

