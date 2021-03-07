class_name BTGuard, "icons/bt_guard.svg"
extends BTNode

export(bool) var start_locked = false
export(bool) var permanent = false
export(NodePath) var _locker
export(String, "Failure", "Success", "Always") var lock_if
export(NodePath) var _unlocker
export(int, "Failure", "Success") var unlock_if
export(float) var lock_time = get_physics_process_delta_time()

var locked: bool = false

onready var unlocker: BTNode = get_node_or_null(_unlocker)
onready var locker: BTNode = get_node_or_null(_locker)
onready var bt_child: BTNode = get_child(0) as BTNode



func lock():
	locked = true
	if permanent:
		return
	elif unlocker:
		while locked:
			var result = yield(unlocker, "tick")
			if result == bool(unlock_if):
				locked = false
	else:
		yield(get_tree().create_timer(lock_time, false), "timeout")
		locked = false


func check_lock():
	if lock_if == "Always" or (succeeded() and lock_if == "Success") or (failed() and lock_if == "Failure"):
		lock()


func _tick(agent: Node, blackboard: Blackboard) -> bool:
	if locked:
		return fail()
	var result = bt_child.tick(agent, blackboard)
	if bt_child.running() and result is GDScriptFunctionState:
		run()
		result = yield(result, "completed")
	if not locker:
		check_lock()
		return set_state(bt_child.state)
	elif result == true:
		return succeed()
	else:
		return fail()


func _on_locker_tick(_result):
	check_lock()
	set_state(locker.state)


func _ready():
	assert(get_child_count() == 1)
	if start_locked:
		lock()
	if locker != null:
		locker.connect("tick", self, "_on_locker_tick")
