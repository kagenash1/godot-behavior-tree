class_name BTAction, "icons/btaction.svg" 
extends BTNode

export(String) var action_name = name
export(Array, String) var argument_keys: Array

func tick(agent: Node, blackboard: Blackboard):
	if fresh:
		if not agent.has_method(name) and not agent.has_method(action_name):
			is_active = false
		for key in argument_keys:
			if not blackboard.has_data(key):
				is_active = false
	if not is_active:
		return
	else:
		fresh = false
	if debug:
		print(name)
	if running():
		return
	var args := []
	if argument_keys.size() > 0:
		for key in argument_keys:
			var value = blackboard.get_data(key)
			if value != null:
				args.push_back(value)
			else:
				fail()
				return
	run()
	var result
	if action_name != "":
		result = agent.callv(action_name, args)
	else:
		result = agent.callv(name, args)
	if result is GDScriptFunctionState:
		result = yield(result, "completed")
	if result == null:
		result = true
	if result == true:
		succeed()
	else:
		fail()
