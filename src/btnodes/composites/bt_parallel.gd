class_name BTParallel, "../../../icons/btparallel.svg"
extends BTComposite

# Executes each child. doesn't wait for completion, always succeeds.

func _tick(agent: Node, blackboard: Blackboard) -> bool:
	for c in children:
		bt_child = c
		bt_child.tick(agent, blackboard)
	
	return succeed()

