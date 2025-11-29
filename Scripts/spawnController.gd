extends Node2D

@export var player: Player
var quantity:=3.0
var random=2
var wave=0

@export var enemies:Array[PackedScene] = []

var spawn_table = {
	"smallRed": 50,
	"smallBlue": 30,
	"smallBlack": 10,
	"smallGreen": 5,
	"smallPurple": 3,
	"smallYellow": 1,
	"red": 0,
	"blue": 0,
	"black": 0,
	"green": 0,
	"purple": 0,
	"yellow": 0
}

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	spawnWave()
	
func updateTable():
	var item=0.0
	for key in spawn_table.keys():
		spawn_table[key]+=wave*(item+1)/50.0
		item+=1.0
	print(spawn_table)
	
func spawnWave():
	wave+=1
	updateTable()
	for spawning in floor(quantity):
		print(pickSpawn())
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

func pickSpawn():
	var total = 0.0
	for weight in spawn_table.values():
		total += weight
	var r = randf() * total
	var cumulative = 0.0
	for enemy in spawn_table.keys():
		cumulative += spawn_table[enemy]
		if r < cumulative:
			return enemy
