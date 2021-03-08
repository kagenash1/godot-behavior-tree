class_name BTLeaf, "icons/btleaf.svg" 
extends BTNode

# Leaf nodes are used to implement your own behavior logic.
# That can be for example calling functions on the agent, or checking conditions in the blackboard. 
# Good practice is to not make leaf nodes do too much stuff, and to not have flow logic in them.
# Instead, just use them to do a single action or condition check, and use a composite node
# (BTSequence, BTSelector or BTParallel) to define the flow between multiple leaf nodes.


# Override this in your extended script
func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var result = true
	#result = agent.call("some_function", blackboard.get_data("some_argument"))
	if result is GDScriptFunctionState:
		result = yield(result, "completed")
	if result == true:
		return succeed()
	else:
		return fail()
