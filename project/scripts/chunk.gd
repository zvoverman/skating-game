extends Node2D

@onready var Obstacles = $Obstacles
var Trash_Bin: PackedScene = preload("res://project/scenes/trash_bin.tscn")
var Traffic_Cone: PackedScene = preload("res://project/scenes/traffic_cone.tscn")
var obstacle_types: Array = [Trash_Bin, Traffic_Cone]
var obstacles: Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	obstacles.append(create_obstacle())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_obstacle() -> Node2D:
	var random_index = randi() % obstacle_types.size()
	var ObstacleScene = obstacle_types[random_index]
	var obstacle = ObstacleScene.instantiate() 
	obstacle.position = Vector2(randi_range(140, 500), -16)
	Obstacles.add_child(obstacle)
	return obstacle
