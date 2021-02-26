class_name BTNode, "icons/btnode.svg" 
extends Node

class BTNodeState:
	var success: bool = true  setget set_success
	var failure: bool = false setget set_failure
	var running: bool = false setget set_running
	
	func set_success(value: bool = true):
		if value == false:
			print_debug("Ignoring manual change of BTState member. Use setters.")
			return
		success = true
		failure = false
		running = false
	func set_failure(value: bool = true):
		if value == false:
			print_debug("Ignoring manual change of BTState member. Use setters.")
			return
		success = false
		failure = true
		running = false
	func set_running(value: bool = true):
		if value == false:
			print_debug("Ignoring manual change of BTState member. Use setters.")
			return
		success = false
		failure = false
		running = true
	func equals(rhs: BTNodeState):
		if rhs.success:
			set_success()
		elif rhs.failure:
			set_failure()
		else:
			set_running()

export(bool) var is_active = true
export(bool) var debug = false
var state: BTNodeState = BTNodeState.new()
var fresh: bool = true

signal tick(result)

func succeed():
	state.set_success()
	emit_signal("tick", true)
func fail():
	state.set_failure()
	emit_signal("tick", false)
func run():
	state.set_running()
func succeeded():
	return state.success
func failed():
	return state.failure
func running():
	return state.running
	
func get_state() -> String:
	if succeeded():
		return "success"
	elif failed():
		return "failure"
	else:
		return "running"

# warning-ignore:unused_argument
# warning-ignore:unused_argument
func tick(agent: Node, blackboard: Blackboard):
	if not is_active or running():
		return
	if fresh == true:
		fresh = false
	if debug:
		print(name)

func _ready():
	if is_active:
		succeed()
	else:
		push_warning(name + ", ID: " + get_path() + " was deactivated.")
		fail()
