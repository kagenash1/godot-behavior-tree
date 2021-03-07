class_name BTParallel, "icons/btparallel.svg"
extends BTNode

func _tick(agent: Node, blackboard: Blackboard) -> bool:
	for c in get_children():
		var bt_child: BTNode = c
		bt_child.tick(agent, blackboard)
	return succeed()

