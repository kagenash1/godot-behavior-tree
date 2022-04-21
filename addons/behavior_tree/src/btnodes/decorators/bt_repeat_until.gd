class_name BTRepeatUntil, "res://addons/behavior_tree/icons/btrepeatuntil.svg"
extends BTDecorator

# Repeats until specified state is returned, then sets state to child state

export(int, "Failure", "Success") var until_what
export(float) var frequency

onready var expected_result = bool(until_what)

# Public: Repeatedly calls the childrens _tick functions until the desired result is returned
#
# agent = Is the agent instance
# blackboard = Contains data that the agent has stored
#
# Example
#	_tick(Node.new(), Blackboard.new())
#		=> true
func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var result = not expected_result

	while result != expected_result:
		result = bt_child.tick(agent, blackboard)

		if result is GDScriptFunctionState:
			result = yield(result, "completed")

		yield(get_tree().create_timer(frequency, false), "timeout")

	return set_state(bt_child.state)
