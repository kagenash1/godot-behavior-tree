class_name BTWait, "res://addons/behavior_tree/icons/btwait.svg"
extends BTLeaf

# Waits for wait_time seconds, then succeeds. time_in_bb is the key where,
# if desired, another amount can be specified. In that case, wait_time is overridden.


export(float) var wait_time: float
export(String) var time_in_bb: String

# Public: Returns true once the yield is completed
#
# agent = Is the agent instance
# blackboard = Contains data that the agent has stored
#
# Example
#	_tick(Node.new(), Blackboard.new())
#		=> true
func _tick(agent: Node, blackboard: Blackboard) -> bool:
	if time_in_bb:
		wait_time = blackboard.get_data(time_in_bb)

	var timer = create_and_start_timer(agent)
	yield(timer, "timeout")
	agent.remove_child(timer)

	return succeed()

# Internal: At timer is created for agent and started
#
# agent = The instance the timer will be added to
#
# Example
#	create_and_start_timer(Node.new())
#		=> Timer.new()
func create_and_start_timer(agent: Node) -> Timer:
	var timer = Timer.new()
	timer.wait_time = wait_time
	agent.add_child(timer)
	timer.start()
	return timer
