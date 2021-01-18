class_name BTParallel, "res://Src/BehaviourTree/icons/btparallel.svg"
extends BTNode

func Tick(agent: Node, blackboard: Blackboard):
	if not isActive:
		return
	if debug:
		print(name)
	if fresh == true:
		fresh = false
	for c in get_children():
		var btChild: BTNode = c
		btChild.Tick(agent, blackboard)
	Succeed()

