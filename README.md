# godot-behavior-tree
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](http://paypal.me/GabrieleTorini) 

A GDScript implementation of a behavior tree for game AI, based on native Godot nodes and using the built in scene tree editor.

INSTALLATION
- Copy the 'addons' folder into the main directory of your project.
- Enable the plugin from project settings, THEN RESTART Godot, otherwise it will not recognize the new classes (that's a bug of the engine).
- Optionally, you can also drag the bt_example folder into the main directory of your project.
- To see the example working, run the agent.tscn scene. The ex_behavior_tree.tscn scene is an example of how the tree is built.

![alt text](https://raw.githubusercontent.com/GabrieleTorini/godot-behavior-tree/main/bt_images/Screenshot%202021-03-13%20085615.png)![alt text](https://raw.githubusercontent.com/GabrieleTorini/godot-behavior-tree/main/bt_images/Screenshot%202021-03-13%20085633.png)

INSTRUCTIONS:
- Click the node creation icon. You should see new nodes available (if you don't, restart Godot). You must use a BehaviourTree as the root node, which should have only a single child. This child can be any of the nodes under the BTNode category, which all inherit from the BTNode class.
- After creating a behavior tree, you must specify who is the owner of the AI (the Agent) and what Blackboard is being used. Blackboards can be put anywhere (given it is outside the tree), and even shared among different trees. The system is flexible enough to allow you to decide how and when to update your blackboard data. For example, you can make a plain Node with a script that handles updating the blackboard, eg. with signal callbacks or even in process(). Or you can do it from anywhere else, even from inside the tree, just make sure to design things in a way you can maintain and keep track of.
- A Behavior Tree flows executing each of its children, which return some kind of success or failure state. Only those branches following a successful node will be executed.  A BTNode must return either success or failure, and can suspend execution only with a yield() call, after which it will remain in a running state until execution is completed. When a BTNode is in running state, the tree will progressively suspend execution (with the only exeption being BTParallel ) until all of the children complete execution. This is for optimisation purposes.
- The flow of the tree is defined by the so called composite nodes: BTSequence, BTSelector, BTRandomSelector, BTRandomSequence, BTParallel which all inherit from BTComposite. A sequence is successfull if all the children are successful, while it fails if one of the children fails. The selector is the logical opposite, it succeeds if one children succeeds, and fails if all the children fail. A parallel will run all the children and always succeed regardless, WITHOUT waiting for children to complete execution. The base composite node runs all the children and always succeeds, but it also waits for execution completion.
- The actions of your AI behavior are carried out in BTLeaf nodes. Add a BTLeaf, then do 'extend script'. Now you can define your own behavior in this script by overriding the _ _tick()_  method. Your actions will go here. Make sure to read the comments in the base script to know the best practices. Also remember BTLeaf shouldn't have children.
- BTDecorator is used to customise the execution of a child node. They can only have ONE child. 
- BTConditional is the most common type of decorator. Add a BTConditional and extend the script, then override the _ _pre_tick()_ method to define the conditions under which the child will be executed. Make sure you read the comment cause there is a useful example there. 
- BTGuards are decorators which can be used to temporarily lock branches. Optionally, you can assign an unlocker, which will override the lock time specified. There is also the option to assign a locker. BTGuards can make your behavior very rich and reactive, as well as optimised, as they avoid unnecessary branching and repetition.
- Other decorators allow you to loop execution, reverse the result of tick, and so on. There is a lot you can do by customising execution through decorators.
- Good practice is to use the provided nodes and follow the design pattern of the behavior tree. But since this is a purely code based implementation without any visual editor, you have a lot of control over the design and thus a margin of error. These are just useful scripts that follow some "good practices" but are not bound to them, if not for a couple of basic rules. It is up to you to decide how you design your behavior tree, but keep in mind that if you misuse it you will not benefit from the power of the behavior tree pattern. (for example, you could even use the base BTNode for everything and just extend it everytime, although it would be a mess)
- You could have a huge behaviour tree, but the best practice is to follow the component philosophy of Godot and make several smaller behaviour trees for each component of your scene. For example, a tree for your movement controller, a tree for your weapon controller, a tree for your pathfinder component, etc.. A behaviour tree can only have one blackboard, but the same blackboard can be used by many trees, so this is particularly handy if you wanna have several trees without also making multiple blackboards. Personally, the reason why I have the blackboard as a decoupled component, is because I wanted to make squads of enemies sharing the same data but behaving independently, so this is a use case for this. Moreover, I usually have several components in my actors, and I wanna use the same database for different tree.


Tutorials/demos will be included soon. 
If you need support, reach out to me at gabriele.torini@outlook.it or on Discord at kagenashi#8224


If you make amazing AI with the Behavior Tree, consider offerring me a coffee so I can stay awake and improve it :)

[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](http://paypal.me/GabrieleTorini) 
