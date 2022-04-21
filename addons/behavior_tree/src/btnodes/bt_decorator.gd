class_name BTDecorator, "res://addons/behavior_tree/icons/btdecorator.svg"
extends BTNode

# Accepts only ONE child. Ticks and sets its state the same as the child.
# Can be used to create conditions.

onready var bt_child: BTNode = get_child(0) as BTNode

func _ready():
	assert(get_child_count() == 1, "A BTDecorator can only have one child.")

# Public: Returns true once it's only child's _tick function has completed
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

	return set_state(bt_child.state)
