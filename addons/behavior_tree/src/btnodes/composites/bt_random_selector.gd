class_name BTRandomSelector, "res://addons/behavior_tree/icons/btrndselector.svg"
extends BTSelector

# Executes a random child and is successful at the first successful tick.
# Attempts a number of ticks equal to the number of children. If no successful
# child was found, it fails.

# Public: Randomized witch child will run
#
# agent = Is the agent instance. (Unused)
# blackboard = Contains data that the agent has stored.(Unused)
#
# Example
#	_pre_tick(Node.new(), Blackboard.new())
func _pre_tick(_agent: Node, _blackboard: Blackboard) -> void:
	randomize()
	children.shuffle()
