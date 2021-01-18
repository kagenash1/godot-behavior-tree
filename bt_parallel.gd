class_name BTParallel, "icons/btparallel.svg"
extends BTNode

func tick(agent: Node, blackboard: Blackboard):
	if not is_active:
		return
	if debug:
		print(name)
	if fresh == true:
		fresh = false
	for c in get_children():
		var bt_child: BTNode = c
		bt_child.tick(agent, blackboard)
	succeed()

