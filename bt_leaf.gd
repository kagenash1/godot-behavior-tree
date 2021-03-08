class_name BTLeaf, "icons/btleaf.svg" 
extends BTNode

# Leaf nodes are used to implement your own behavior logic.
# That can be for example calling functions on the agent, or checking conditions in the blackboard. 
# Good practice is to not make leaf nodes do too much stuff, and to not have flow logic in them.
# Instead, just use them to do a single action or condition check, and use a composite node
# (BTSequence, BTSelector or BTParallel) to define the flow between multiple leaf nodes.


# BEGINNING OF VIRTUAL FUNCTIONS 
# Extend this script and override the following functions to define your behavior.
# The following are just abstract examples, take them as a reference and insert your own logic.


func _tick(agent: Node, blackboard: Blackboard) -> bool:
	run() # We set this node in a running state so parent composite nodes will wait for the end of execution
	var result = agent.call("some_function") # Name your function here
	if result is GDScriptFunctionState:
		result = yield(result, "completed") # Wait for the function to complete
	if result: # If result is not null we succeed
		return succeed()
	else:
		return fail()


func _fresh_tick(agent: Node, blackboard: Blackboard) -> bool:
	if fresh:
		var result: bool = agent.call("find_path", Vector2(100, 100)) # For example, on the first tick we find the path to a point. 
		if result: # Let's suppose if a path is found we return true
			fresh = false # This function won't be executed anymore
			return succeed()
		else:
			push_warning("Path not found!")
			return fail() # This will run again until we find a path.
 
 # END OF VIRTUAL FUNCTIONS

