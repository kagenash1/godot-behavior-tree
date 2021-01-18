class_name BTSequence, "icons/btsequence.svg" 
extends BTNode

func Tick(agent: Node, blackboard: Blackboard):
	if not isActive or Running():
		return
	if debug:
		print(name)
	if fresh == true:
		fresh = false
	for c in get_children():
		var btChild: BTNode = c
		var result = btChild.Tick(agent, blackboard)
		if btChild.Running() and result is GDScriptFunctionState:
			Run()
			yield(result, "completed")
		if btChild.Failed():
			Fail()
			return
	Succeed()
