class_name BBService, "icons/bbservice.svg"
extends Node

export(float) var frequency: float = get_physics_process_delta_time()
export(bool) var active: bool = true
export(String) var blackboard_key: String
onready var blackboard: Blackboard = get_parent() as Blackboard

func _ready():
	assert(blackboard.HasData(blackboard_key))
