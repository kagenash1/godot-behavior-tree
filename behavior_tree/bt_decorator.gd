class_name BTDecorator
extends BTNode

onready var bt_child: BTNode = get_child(0) as BTNode



func _ready():
	assert(get_child_count() == 1)
