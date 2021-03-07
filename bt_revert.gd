class_name BTRevert, "icons/btrevert.svg"
extends BTNode

onready var bt_child: BTNode = get_child(0) as BTNode



func _ready():
	assert(get_child_count() == 1)


func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var result = bt_child.tick(agent, blackboard)
	if bt_child.running() and result is GDScriptFunctionState:
		run()
		yield(result, "completed")
	if bt_child.succeeded():
		return fail()
	elif bt_child.failed():
		return succeed()

