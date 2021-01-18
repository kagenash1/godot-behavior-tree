class_name BTSequence, "icons/btsequence.svg" 
extends BTNode

func tick(agent: Node, blackboard: Blackboard):
	if not is_active or running():
		return
	if debug:
		print(name)
	if fresh == true:
		fresh = false
	for c in get_children():
		var bt_child: BTNode = c
		var result = bt_child.tick(agent, blackboard)
		if bt_child.running() and result is GDScriptFunctionState:
			run()
			yield(result, "completed")
		if bt_child.failed():
			fail()
			return
	succeed()
