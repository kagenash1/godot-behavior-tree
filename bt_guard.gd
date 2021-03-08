class_name BTGuard, "icons/bt_guard.svg"
extends BTDecorator

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


func check_lock(current_locker: BTNode):
	if ((lock_if == "Always"  and not current_locker.running()) 
	or ( lock_if == "Success" and current_locker.succeeded()) 
	or ( lock_if == "Failure" and current_locker.failed())):
		lock()


func _tick(agent: Node, blackboard: Blackboard) -> bool:
	if locked:
		return fail()
	var result = bt_child.tick(agent, blackboard)
	if bt_child.running() and result is GDScriptFunctionState:
		yield(result, "completed")
	if not locker:
		check_lock(bt_child)
	return set_state(bt_child)


func _on_locker_tick(_result):
	check_lock(locker)
	set_state(locker)


func _ready():
	if start_locked:
		lock()
	if locker != null:
		locker.connect("tick", self, "_on_locker_tick")
