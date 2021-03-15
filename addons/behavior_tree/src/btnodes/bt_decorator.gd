class_name BTDecorator, "res://addons/behavior_tree/icons/btdecorator.svg"
extends BTNode

# Accepts only ONE child. Ticks and sets its state the same as the child.
# Can be used to create conditions. For example, if we extend this script we can do:
#
# func _tick(agent: Node, blackboard: Blackboard) -> bool:
#	assert("agent_property" in agent)
#
#	if not blackboard.has_data("blackboard_property"):
#		return fail()
#
#	if agent.get("agent_property") and blackboard.get_data("blackboard_entry"):
#		return ._tick(agent, blackboard)
#	else:
#		return fail()
#
# This will execute the child only if a certain condition is met, and then match state. 
# So you can decorate a leaf node to be executed only under certain conditions.

onready var bt_child: BTNode = get_child(0) as BTNode



func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var result = bt_child.tick(agent, blackboard)
	
	if result is GDScriptFunctionState:
		result = yield(result, "completed")
	
	return set_state(bt_child)


func _ready():
	assert(get_child_count() == 1)
