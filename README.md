# godot-behavior-tree
A GDScript implementation of a behavior tree for game AI, based on native Godot nodes and using the built in scene tree editor.

INSTRUCTIONS:
- Copy files in a folder in your project. May have to restart the editor.
- Click the node creation icon. You should see new nodes available. You must use a BehaviourTree as the root node, which should have only a single child. This child can be any of the nodes under the BTNode category, which all inherit from the BTNode class.
- After creating a behavior tree, you must specify who is the owner of the AI (the Agent) and what Blackboard is being used. Blackboards should be created separately and provided with BBServices which act as a kind of 'sensors' to write data on the Blackboard.

Tutorials/demos will be included soon. 
