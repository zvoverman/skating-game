extends Node2D

# below line caused godot to crash - moved files outside of editor 
# 'possible cyclic resource inclusion'
# var WorldScene: PackedScene = preload("res://scenes/world.tscn")
@onready var Player = $Player
@onready var Chunks = $Chunks
@onready var Score = $Camera2D/Score
@onready var HighScore = $Camera2D/HighScore
var ChunkScene: PackedScene = preload("res://scenes/chunk.tscn")
var ChunkNoObstacleScene: PackedScene = preload("res://scenes/chunk_no_obstacles.tscn")
var chunks: Array = [];
@export var BASE_SPEED: int = 200;

const UNLOAD_CHUNK_X = -640

var high_score: int = 0;
var total_score: int = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	chunks.append(create_chunk_no_obstacles(0))
	chunks.append(create_chunk(1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed = BASE_SPEED + (int)(total_score / 500) * 50
	total_score += delta * 100
	Score.text = str(total_score)
	update_chunks()
	move_chunks(speed, delta)
	
func move_chunks(speed: int, delta: float):
	for chunk in chunks:
		chunk.position.x -= speed * delta;

func update_chunks():
	for chunk in chunks:
		if chunk.position.x < UNLOAD_CHUNK_X:
			unload_chunk(chunk)
			chunks.append(create_chunk(1))
		
func create_chunk(x_position: int) -> Node2D:
	var chunk = ChunkScene.instantiate() 
	chunk.position = Vector2(x_position, 0) * Vector2(640, 640)
	Chunks.add_child(chunk)
	return chunk

func create_chunk_no_obstacles(x_position: int) -> Node2D:
	var chunk = ChunkNoObstacleScene.instantiate() 
	chunk.position = Vector2(x_position, 0) * Vector2(640, 640)
	Chunks.add_child(chunk)
	return chunk
	
func unload_chunk(chunk):
	chunks.erase(chunk)
	chunk.queue_free()
	
func reset():
	if (!HighScore.visible):
		HighScore.show()
	
	if (total_score > high_score):
		high_score = total_score
		
	HighScore.text = 'HI SCORE:   ' + str(high_score)
	Score.text = "0"	
	total_score = 0
	
	Player.position.y = -100
	for chunk in chunks:
		chunk.queue_free()
	chunks.clear()
	
	chunks.append(create_chunk_no_obstacles(0))
	chunks.append(create_chunk(1))

		
