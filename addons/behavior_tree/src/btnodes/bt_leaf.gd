class_name BTLeaf, "res://addons/behavior_tree/icons/btleaf.svg" 
extends BTNode

# Leaf nodes are used to implement your own behavior logic.
# That can be for example calling functions on the agent, or checking conditions in the blackboard. 
# Good practice is to not make leaf nodes do too much stuff, and to not have flow logic in them.
# Instead, just use them to do a single action or condition check, and use a composite node
# (BTSequence, BTSelector or BTParallel) to define the flow between multiple leaf nodes.

# BEGINNING OF VIRTUAL FUNCTIONS
# Override these two in your extended script

# Called after tick()
func _on_tick(result: bool):
	pass


# The following is an abstract example of good practices when defining your actions
func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var result = true
	#result = agent.call("some_function", blackboard.get_data("some_argument"))
	
	# If action is executing, wait for completion and remain in running state
	if result is GDScriptFunctionState:
		# Store what the action returns when completed
		result = yield(result, "completed") 
	
	# If action returns anything but a bool consider it a success
	if not result is bool: 
		result = true
	
	# Once action is complete we set state and return.
	if result == true:
		return succeed()
	else:
		return fail()

# END OF VIRTUAL FUNCTIONS
