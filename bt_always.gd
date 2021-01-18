class_name BTAlways extends BTNode

export(String, "fail", "succeed") var always
onready var bt_child: BTNode = get_child(0) as BTNode

func _ready():
	assert(get_child_count() == 1)

func tick(agent, blackboard: Blackboard):
	if not is_active or running():
		return
	if debug:
		print(name)
	if fresh == true:
		fresh = false
	var result = bt_child.tick(agent, blackboard)
	if bt_child.running() and result is GDScriptFunctionState:
		run()
		yield(result, "completed")
	if always == "succeed":
		succeed()
	else:
		 fail()
