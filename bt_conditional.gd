class_name BTConditional, "icons/btconditional.svg" 
extends BTNode

# PROTIP: If you wanna wait for an action to complete, do the following:
# 
# run()
# var result = agent.do_something()
# if result is GDScriptFunctionState:
# 	var result = yield(result, "completed")
# if result == true:
# 	return succeed()
# else:
# 	return fail()


func _fresh_tick(agent: Node, blackboard: Blackboard) -> bool:
	# Remove this line and do whatever you want
	return ._fresh_tick(agent, blackboard)


func _tick(agent: Node, blackboard: Blackboard) -> bool:
	# Remove this line and do whatever you want
	return ._tick(agent, blackboard)
