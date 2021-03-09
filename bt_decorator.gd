class_name BTDecorator
extends BTNode

# Accepts only ONE child. Executes the child and sets its state the same as the child.

onready var bt_child: BTNode = get_child(0) as BTNode



func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var result = bt_child.tick(agent, blackboard)
	
	if result is GDScriptFunctionState:
		result = yield(result, "completed")
	
	return set_state(bt_child)


func _ready():
	assert(get_child_count() == 1)
