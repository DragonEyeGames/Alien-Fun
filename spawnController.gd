extends Node2D

@export var player: Player
var quantity:=3.0
var random=2

@export var enemies:Array[PackedScene] = []

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	spawnWave()
	
func spawnWave():
	for spawning in floor(quantity):
		var toSpawn=enemies.pick_random().instantiate()
		get_parent().add_child(toSpawn)
		toSpawn.player=player
		var offset:Vector2 = Vector2(0, 0)
		offset.x=randf_range(0.0, 1.0)
		offset.y= 1.0 - offset.x
		offset*=1000
		if(randi_range(1, 2)==1):
			offset.x=-offset.x
		if(randi_range(1, 2)==1):
			offset.y=-offset.y
		toSpawn.global_position=player.global_position+offset
	quantity+=.25
	await get_tree().create_timer(4, false).timeout
	spawnWave()
