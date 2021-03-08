class_name BTComposite
extends BTNode

# Executes every child, waiting for completion

var bt_child: BTNode # Used to iterate over children



func _on_tick(result: bool):
	bt_child = null
	return result


func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var result
	
	for c in get_children():
		bt_child = c
		result = bt_child.tick(agent, blackboard)
		
		if bt_child.running() and result is GDScriptFunctionState:
			result = yield(result, "completed")
	
	return succeed()
