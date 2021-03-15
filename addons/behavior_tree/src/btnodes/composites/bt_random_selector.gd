class_name BTRandomSelector, "res://addons/behavior_tree/icons/btrndselector.svg"
extends BTComposite

# Executes a random child and is successful at the first successful tick.
# Attempts a number of ticks equal to the number of children. If no successful
# child was found, it fails.

onready var n_children = get_child_count()



func _tick(agent: Node, blackboard: Blackboard) -> bool:
	randomize()
	var result
	
	for i in n_children:
		bt_child = children[randi() % n_children]
		
		result = bt_child.tick(agent, blackboard)
		
		if result is GDScriptFunctionState:
			result = yield(result, "completed")
		
		if bt_child.succeeded():
			return succeed()
	
	return fail()
