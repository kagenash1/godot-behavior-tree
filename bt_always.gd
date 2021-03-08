class_name BTAlways 
extends BTDecorator

# Executes the child and always either succeeds or fails, depending on what you set from the inspector


export(String, "fail", "succeed") var always_what



func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var result = bt_child.tick(agent, blackboard)
	if bt_child.running() and result is GDScriptFunctionState:
		yield(result, "completed")
	if always_what == "succeed":
		return succeed()
	else:
		return fail()
