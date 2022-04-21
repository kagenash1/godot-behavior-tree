class_name BTRepeat, "res://addons/behavior_tree/icons/btrepeat.svg"
extends BTDecorator

# Executes child "iterations" times and returns the last state and tick result

export(int, 0, 999) var times_to_repeat: int = 1
export(float) var frequency


# Public: Repeatedly calls the childrens _tick functions until the times_to_repeat is reatched
#
# agent = Is the agent instance
# blackboard = Contains data that the agent has stored
#
# Example
#	_tick(Node.new(), Blackboard.new())
#		=> true
func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var result

	for i in times_to_repeat:
		result = bt_child.tick(agent, blackboard)

		if result is GDScriptFunctionState:
			result = yield(result, "completed")

		yield(get_tree().create_timer(frequency, false), "timeout")

	return set_state(bt_child.state)
