class_name BTSelector, "res://addons/behavior_tree/icons/btselector.svg"
extends BTComposite

# Ticks its children until ANY of them succeeds, thus succeeding.
# If ALL of the children fails, it fails as well.

# Public: Runs through all the childrens _tick functions and stops once one has succeeded
#
# agent = Is the agent instance
# blackboard = Contains data that the agent has stored
#
# Example
#	_tick(Node.new(), Blackboard.new())
#		=> true
func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var result

	for c in children:
		bt_child = c

		result = bt_child.tick(agent, blackboard)

		if result is GDScriptFunctionState:
			result = yield(result, "completed")

		if bt_child.succeeded():
			return succeed()

	return fail()
