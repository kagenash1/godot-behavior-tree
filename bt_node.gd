class_name BTNode, "icons/btnode.svg" 
extends Node

# Base class from which every node in the behavior tree inherits. 
# You don't usually need to instance this node directly.
# To define your behaviors, use and extend BTLeaf instead.

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
# to get info on the state of other BTNodes
signal tick(result)

export(bool) var is_active = true # Turn this off to block a branch of the tree
export(bool) var debug = false # Turn this on to print the name of the BTNode

var state: BTNodeState = BTNodeState.new()



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


func set_state(rhs: BTNode):
	if rhs.succeeded():
		return succeed()
	elif rhs.failed():
		return fail()
	else:
		run()


# This is the most important function. Override this and put your behavior here.
func _tick(agent: Node, blackboard: Blackboard) -> bool:
	return succeed()


# DO NOT override this
func tick(agent: Node, blackboard: Blackboard) -> bool:
	if not is_active or running():
		return fail()
	
	if debug:
		print(name + " at " + get_path())
	
	run() 
	
	var result = _tick(agent, blackboard)
	if result is GDScriptFunctionState:
		result = yield(result, "completed")
	
	return result


func _ready():
	if is_active:
		succeed()
	else:
		push_warning(name + ", ID: " + get_path() + " was deactivated.")
		fail()
