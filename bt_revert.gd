class_name BTRevert, "icons/btrevert.svg"
extends BTNode

onready var btChild: BTNode = get_child(0) as BTNode

func _ready():
	assert(get_child_count() == 1)

func Tick(agent: Node, blackboard: Blackboard):
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
	if btChild.Succeeded():
		Fail()
	elif btChild.Failed():
		Succeed()

