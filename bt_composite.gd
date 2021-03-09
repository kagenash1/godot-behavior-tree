class_name BTComposite
extends BTNode

# Executes every child, waiting for completion. Always succeeds.

var bt_child: BTNode # Used to iterate over children



func _on_tick(result: bool):
	bt_child = null


func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var result
	
	for c in get_children():
		bt_child = c
		result = bt_child.tick(agent, blackboard)
		
		if result is GDScriptFunctionState:
			result = yield(result, "completed")
	
	return succeed()
