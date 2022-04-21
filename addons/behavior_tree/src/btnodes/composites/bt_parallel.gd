class_name BTParallel, "res://addons/behavior_tree/icons/btparallel.svg"
extends BTComposite

# Executes each child. doesn't wait for completion, always succeeds.

# Public: Returns true once all the childrens _tick functions are ran doesn't check for completion
#
# agent = Is the agent instance
# blackboard = Contains data that the agent has stored
#
# Example
#	_tick(Node.new(), Blackboard.new())
#		=> true
func _tick(agent: Node, blackboard: Blackboard) -> bool:
	for c in children:
		bt_child = c
		bt_child.tick(agent, blackboard)

	return succeed()

