class_name BTAlways, "res://addons/behavior_tree/icons/btalways.svg"
extends BTDecorator

# Executes the child and always either succeeds or fails.

export(int, "Fail", "Succeed") var always_what

onready var return_func: String = "fail" if always_what == 0 else "succeed"


# Public: Runs the child's _tick function returns the result
#
# agent = Is the agent instance
# blackboard = Contains data that the agent has stored
#
# Example
#	_tick(Node.new(), Blackboard.new())
#		=> true
func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var result = bt_child.tick(agent, blackboard)

	if result is GDScriptFunctionState:
		result = yield(result, "completed")

	return call(return_func)
