class_name BTRandomSequence, "res://addons/behavior_tree/icons/btrndsequence.svg"
extends BTSequence

# Just like a BTSequence, but the children are executed in random order.

# Public: Excutes all it's children in a random order
#
# agent = Is the agent instance. (Unused)
# blackboard = Contains data that the agent has stored.(Unused)
#
# Example
#	_pre_tick(Node.new(), Blackboard.new())
func _pre_tick(_agent: Node, _blackboard: Blackboard) -> void:
	randomize()
	children.shuffle()
