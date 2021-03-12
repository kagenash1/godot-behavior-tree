class_name BTComposite
extends BTNode

# Executes every child, waiting for completion. Always succeeds.
# Can be used to create conditions. For example, if we extend this script we can do:
#
# func _tick(agent: Node, blackboard: Blackboard) -> bool:
#    if agent.get("agent_property") and blackboard.get_data("blackboard_entry"):
#        return ._tick(agent, blackboard)
#    return fail()
#
# This will execute the child only if a certain condition is met, and then match state. 
# So you can decorate a leaf node to be executed only under certain conditions.

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
