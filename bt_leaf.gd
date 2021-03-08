class_name BTLeaf, "icons/btleaf.svg" 
extends BTNode

# Leaf nodes are used to implement your own behavior logic.
# That can be for example calling functions on the agent, or checking conditions in the blackboard. 
# Good practice is to not make leaf nodes do too much stuff, and to not have flow logic in them.
# Instead, just use them to do a single action or condition check, and use a composite node
# (BTSequence, BTSelector or BTParallel) to define the flow between multiple leaf nodes.


# PROTIP: If you wanna wait for an action or check to complete, do the following: 
# run()
# var result = agent.do_something()
# if result is GDScriptFunctionState:
# 	var result = yield(result, "completed")
# if result == true:
# 	return succeed()
# else:
# 	return fail()


# BEGINNING OF VIRTUAL FUNCTIONS 
# Extend this script and override the following functions to define your behavior.

func _tick(agent: Node, blackboard: Blackboard) -> bool:
	return ._tick(agent, blackboard)


func _fresh_tick(agent: Node, blackboard: Blackboard) -> bool:
	# Remove this line and do whatever you want
	return ._fresh_tick(agent, blackboard)
 
 # END OF VIRTUAL FUNCTIONS

