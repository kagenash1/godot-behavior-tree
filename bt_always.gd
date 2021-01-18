class_name BTAlways extends BTNode

export(String, "Fail", "Succeed") var always
onready var btChild: BTNode = get_child(0) as BTNode

func _ready():
	assert(get_child_count() == 1)

func Tick(agent, blackboard: Blackboard):
	if not isActive or Running():
		return
	if debug:
		print(name)
	if fresh == true:
		fresh = false
	var result = btChild.Tick(agent, blackboard)
	if btChild.Running() and result is GDScriptFunctionState:
		Run()
		yield(result, "completed")
	if always == "Succeed":
		Succeed()
	else:
		 Fail()
