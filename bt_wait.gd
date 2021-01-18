class_name BTWait, "icons/btwait.svg"
extends BTNode

export(float) var wait_time 

# warning-ignore:unused_argument
func tick(agent: Node, blackboard: Blackboard):
	if not is_active:
		return
	else:
		fresh = false
	if running():
		return
	if debug:
		print(name)
	run()
	yield(get_tree().create_timer(wait_time, false), "timeout")
	succeed()
