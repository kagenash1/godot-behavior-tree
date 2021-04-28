extends BTLeaf


var distance_to_cover = 4


func _tick(agent: Node, blackboard: Blackboard) -> bool:
	distance_to_cover -= 1
	print("Walking towards cover..")
	yield(get_tree().create_timer(1, false), "timeout")
	
	if distance_to_cover == 0:
		print("Cover reached")
		distance_to_cover = 4
		return succeed()
	
	return fail()

