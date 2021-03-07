class_name BTAlways extends BTNode

export(String, "fail", "succeed") var always_what

onready var bt_child: BTNode = get_child(0) as BTNode



func _ready():
	assert(get_child_count() == 1)


func _tick(agent: Node, blackboard: Blackboard) -> bool:
	var result = bt_child.tick(agent, blackboard)
	if bt_child.running() and result is GDScriptFunctionState:
		run()
		yield(result, "completed")
	if always_what == "succeed":
		return succeed()
	else:
		return fail()
