class_name BTSelector, "icons/btselector.svg"
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
		if bt_child.succeeded():
			succeed()
			return
	fail()
