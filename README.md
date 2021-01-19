# godot-behavior-tree
A GDScript implementation of a behavior tree for game AI, based on native Godot nodes and using the built in scene tree editor.

INSTRUCTIONS:
- Copy files in a folder in your project. May have to restart the editor.
- Click the node creation icon. You should see new nodes available. You must use a BehaviourTree as the root node, which should have only a single child. This child can be any of the nodes under the BTNode category, which all inherit from the BTNode class.
- After creating a behavior tree, you must specify who is the owner of the AI (the Agent) and what Blackboard is being used. Blackboards should be created separately and provided with BBServices which act as a kind of 'sensors' to write data on the Blackboard.
- BTActions should be functions present in the Agent's script, and the arguments passed must be arguments present in the Blackboard. For BTConditionals, you can also perform checks on the Agent's properties.
Unlike other implementations, you're not supposed to extend the actions/conditions' script, everything is done from the inspector.
- If argument keys for actions or conditionals are not present in the Blackboard, the branch will be inactivated. The Blackboard performs sanity checks so that if your argument key is still empty, but present, the action is skipped.
- BTGuards can be used to temporarily lock branches. Optionally, you can assign an unlocker, which will override the lock time specified. There is also the option to assign a locker. BTGuards can make your behavior very rich and reactive, as well as optimised, as they avoid unnecessary branching and repetition. They are the essence of this implementation.
- You could have a huge behaviour tree, but the best practice is to follow the component philosophy of Godot and make several smaller behaviour trees for each component of your scene. A behaviour tree can only have one blackboard, but the same blackboard can be used by many trees, so this is particularly handy if you wanna have several trees without also making multiple blackboards.


Tutorials/demos will be included soon. 

If you need support, contact gabriele.torini@outlook.it or on Discord at kagenashi#8224
