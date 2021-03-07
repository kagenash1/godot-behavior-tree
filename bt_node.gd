class_name BTNode, "icons/btnode.svg" 
extends Node

#############################################
########## READ. THE. COMMENTS. #############
########## READ. THE. COMMENTS. #############
########## READ. THE. COMMENTS. #############
########## READ. THE. COMMENTS. #############
########## READ. THE. COMMENTS. #############
########## READ. THE. COMMENTS. #############
########## READ. THE. COMMENTS. #############
#############################################


# You shouldn't need to mess with this
# Just a fancy way to emulate a C# like enum while waiting 4 Godot
class BTNodeState:
	var success: bool = true  setget set_success
	var failure: bool = false setget set_failure
	var running: bool = false setget set_running
	
	
	func set_success(value: bool = true):
		if value == false:
			print_debug("Ignoring manual change of BTNodeState. Use setters.")
			return
		success = true
		failure = false
		running = false
	
	
	func set_failure(value: bool = true):
		if value == false:
			print_debug("Ignoring manual change of BTNodeState. Use setters.")
			return
		success = false
		failure = true
		running = false
	
	
	func set_running(value: bool = true):
		if value == false:
			print_debug("Ignoring manual change of BTNodeState. Use setters.")
			return
		success = false
		failure = false
		running = true

# Emitted after a tick() call. True is success, false is failure. Can be useful
# to get info on the state of other BTNodes, but if you don't need it you don't 
# have to worry about it
signal tick(result)

export(bool) var is_active = true # Turn this off to block a branch of the BT
export(bool) var debug = false # Turn this on to print the name of the tick()ed BTNode

var state: BTNodeState = BTNodeState.new()
var fresh: bool = true


# You can use these as setters and getters for the BTNodeState of a BTNode
func succeed() -> bool:
	state.set_success()
	emit_signal("tick", true)
	return true
func fail() -> bool:
	state.set_failure()
	emit_signal("tick", false)
	return false
func run():
	state.set_running()
func succeeded() -> bool:
	return state.success
func failed() -> bool:
	return state.failure
func running() -> bool:
	return state.running
func get_state() -> String:
	if succeeded():
		return "success"
	elif failed():
		return "failure"
	else:
		return "running"
func set_state(rhs: BTNodeState):
	if rhs.success:
		return succeed()
	elif rhs.failure:
		return fail()
	else:
		run()

# BEGINNING OF VIRTUAL FUNCTIONS

# These are the base functions to override in your BTAction and BTCondition
# You don't need to call the base manually in your overridden functions

# This is the most important function. Your behavior goes here
func _tick(agent: Node, blackboard: Blackboard) -> bool:
	return succeed()


# This is executed as long as fresh == true, supposedly to have a different behavior on the first tick
func _fresh_tick(agent: Node, blackboard: Blackboard) -> bool:
	fresh = false # When this is false, this function will not be called anymore
	return fresh

# END OF VIRTUAL FUNCTIONS


# DO NOT override this
func fresh_tick(agent: Node, blackboard: Blackboard) -> bool:
	return _fresh_tick(agent, blackboard)


# DO NOT override this
func tick(agent: Node, blackboard: Blackboard) -> bool:
	if not is_active or running():
		return fail()
	if fresh:
		if fresh_tick(agent, blackboard):
			return fail()
	if debug:
		print(name + " at " + get_path())
	return _tick(agent, blackboard)


func _ready():
	if is_active:
		succeed()
	else:
		push_warning(name + ", ID: " + get_path() + " was deactivated.")
		fail()
