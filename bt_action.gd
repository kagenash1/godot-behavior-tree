class_name BTAction, "icons/btaction.svg" 
extends BTNode

export(String) var action_name = name
export(Array, String) var argumentKeys: Array

func Tick(agent: Node, blackboard: Blackboard):
	if fresh:
		if not agent.has_method(name) and not agent.has_method(action_name):
			isActive = false
		for key in argumentKeys:
			if not blackboard.HasData(key):
				isActive = false
	if not isActive:
		return
	else:
		fresh = false
	if debug:
		print(name)
	if Running():
		return
	var args := []
	if argumentKeys.size() > 0:
		for key in argumentKeys:
			var value = blackboard.GetData(key)
			if value != null:
				args.push_back(value)
			else:
				Fail()
				return
	Run()
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
		Succeed()
	else:
		Fail()
