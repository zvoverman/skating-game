extends Node2D

@onready var Obstacles = $Obstacles
var Trash_Bin: PackedScene = load("res://scenes/trash_bin.tscn")
var Traffic_Cone: PackedScene = load("res://scenes/traffic_cone.tscn")
var Dumpster: PackedScene = load("res://scenes/dumpster.tscn")
var Fallen_Trash_Bin: PackedScene = load("res://scenes/fallen_trash_bin.tscn")
var obstacle_types: Array = [Trash_Bin, Traffic_Cone, Dumpster, Fallen_Trash_Bin]
var obstacles: Array = []

const START_X: int = 40;
const END_X: int = 600

# Called when the node enters the scene tree for the first time.
func _ready():
	obstacles.append(create_obstacle(START_X))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func create_obstacle(x_position: int) -> Node2D:
	var random_index = randi() % obstacle_types.size()
	var ObstacleScene = obstacle_types[random_index]
	var obstacle = ObstacleScene.instantiate() 
	obstacle.position = Vector2(randi_range(x_position, END_X), -16)
	if (obstacles.size() < 2 && obstacle.position.x + 300 < END_X):
		obstacles.append(create_obstacle(obstacle.position.x + 200))
	Obstacles.add_child(obstacle)
	return obstacle
	
func new_obstacle(obstacle_name: String):
	if obstacle_name == "Dumpster":
		obstacle_types.append(Dumpster)
