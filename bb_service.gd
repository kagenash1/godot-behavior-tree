class_name BBService, "icons/bbservice.svg"
extends Node


# These don't do much by default. 
# When you create a BBService, you're supposed to extend this script 
# for whatever you wanna run in parallel with the Behavior Tree.
#
# The purpose of services is to update the blackboard, in a way
# that is independent of the Behavior Tree flow.
#
# They are a good way to decouple the behavior from the data update.


# If you don't change this, the service will run at each physics frame
export(float) var frequency: float = get_physics_process_delta_time()
export(bool) var is_active: bool = true
export(NodePath) var _agent
export(NodePath) var _blackboard = get_parent().get_path()

onready var blackboard: Blackboard = get_node(_blackboard) as Blackboard
onready var agent: Node = get_node_or_null(_agent)


# BEGINNIG OF VIRTUAL FUNCTIONS
# Override these in your services

func _run():
	return true

func _stop() -> bool:
	is_active = false
	return is_active

# END OF VIRTUAL FUNCTIONS


func run() -> bool:
	while is_active:
		if _run():
			yield(get_tree().create_timer(frequency, false), "timeout")
		else:
			break
	
	return false


func stop() -> bool:
	return _stop()


