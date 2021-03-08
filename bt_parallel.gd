class_name BTParallel, "icons/btparallel.svg"
extends BTComposite

# Executes each child. Differently from a base BTComposite, it doesn't wait for completion.
# Useful if you wanna run stuff in... parallel, regardless of the tick result.

func _tick(agent: Node, blackboard: Blackboard) -> bool:
	for c in get_children():
		var bt_child: BTNode = c
		bt_child.tick(agent, blackboard)
	
	return succeed()

