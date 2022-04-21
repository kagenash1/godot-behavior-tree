class_name BTConditional, "res://addons/behavior_tree/icons/btconditional.png"
extends BTDecorator

# Used to create conditions. The condition is checked BEFORE ticking,
# and if the condition is met the child node is executed.
# The conditional then returns the same state as the child node, as
# a normal decorator, not the result of the condition.
# If you want to know the result of the condition, store in the blackboard
# during _pre_tick().

export(bool) var reverse: bool = false

var verified: bool = false
var ignore_reverse: bool = false


# Public: Sets verified equal to true
#
# agent = Is the agent instance. (Unused)
# blackboard = Contains data that the agent has stored.(Unused)
#
# Example
#	_pre_tick(Node.new(), Blackboard.new())
func _pre_tick(_agent: Node, _blackboard: Blackboard) -> void:
	verified = true

# Public: Runs when verified is true
#
# agent = Is the agent instance
# blackboard = Contains data that the agent has stored
#
# Example
#	_tick(Node.new(), Blackboard.new())
#		=> true
func _tick(agent: Node, blackboard: Blackboard) -> bool:
	if reverse and not ignore_reverse:
		verified = not verified

	if verified:
		return ._tick(agent, blackboard)
	return fail()

# Public: Runs after tick
#
# agent = Is the agent instance. (Unused)
# blackboard = Contains data that the agent has stored.(Unused)
#
# Example
#	_post_tick(Node.new(), Blackboard.new(), false)
func _post_tick(_agent: Node, _blackboard: Blackboard, _result: bool) -> void:
	pass
