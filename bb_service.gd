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


# Turn this on if you want the survice to run continuously.
export(bool) var is_active: bool = false

# If you don't change this, the service will run at each physics frame when active
export(float) var frequency: float = get_physics_process_delta_time()

export(NodePath) var _agent
export(NodePath) var _blackboard = get_parent().get_path()

onready var blackboard: Blackboard = get_node(_blackboard) as Blackboard
onready var agent: Node = get_node_or_null(_agent)


# BEGINNIG OF VIRTUAL FUNCTIONS
# Override these in your custom services if you plan on using them in parallel (is_active == true)

func _run():
	return true

func _stop():
	is_active = false
	return is_active

# END OF VIRTUAL FUNCTIONS

# There are several cases where, instead, you just want to have some kind of callback in the service,
# rather than running it several times, to optimise performance.
# For example suppose we have an Area called PlayerDetector which collides only with the 
# 'player' collision layer.
# We connect that area to the following method:
#
# func _on_PlayerDetector_area_entered(area: Area):
#	if area and area.owner is Player:
#		blackboard.set_data("player_position", area.owner.position)
#		blackboard.set_data("player_nearby", true)
#		
#
# func _on_PlayerDetector_area_exited(area: Area):
#	if area and area.owner is Player:
#		blackboard.set_data("player_position", null)
#		blackboard.set_data("player_nearby", false)


# Do not override this
func run():
	is_active = true
	while is_active:
		_run()
		yield(get_tree().create_timer(frequency, false), "timeout")


# Do not override this
func stop():
	_stop()


func _ready():
	if is_active:
		run()
