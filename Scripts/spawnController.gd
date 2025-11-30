extends Node2D

@export var player: Player
var quantity:=3.0
var random=2
var wave=0

var toIncrease=0

@export var enemies:Array[PackedScene] = []

var spawn_table = {
	"smallRed": 90,
	"smallBlue": 5,
	"smallBlack": 3,
	"smallGreen": 2.5,
	"smallPurple": 2,
	"smallYellow": 1,
	"red": 0,
	"blue": 0,
	"black": 0,
	"green": 0,
	"purple": 0,
	"yellow": 0
}

var dictLookups = ["smallRed", "smallBlue", "smallBlack", "smallGreen", "smallPurple", "smallYellow", "red", "blue", "black", "green", "purple", "yellow"]

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	spawnWave()
	
func updateTable():
	toIncrease=ceil(wave/5.0)
	if(toIncrease-4>=0):
		spawn_table[dictLookups[toIncrease-4]]-=1
		if(spawn_table[dictLookups[toIncrease-4]]<0):
			spawn_table[dictLookups[toIncrease-4]]=0
	if(toIncrease-2>=0):
		spawn_table[dictLookups[toIncrease-2]]+=.25
	if(toIncrease-1>=0):
		spawn_table[dictLookups[toIncrease-1]]+=.5
	if(toIncrease+1<=len(dictLookups)):
		spawn_table[dictLookups[toIncrease]]+=1
	if(toIncrease+2<=len(dictLookups)):
		spawn_table[dictLookups[toIncrease+1]]+=.5
	if(toIncrease+3>len(dictLookups)):
		spawn_table[dictLookups[toIncrease+2]]+=.25
	print(spawn_table)
	
func spawnWave():
	while WeaponManager.double:
		await get_tree().process_frame
	wave+=1
	updateTable()
	for spawning in floor(quantity):
		var path="res://Scenes/enemies/" + str(pickSpawn()) + ".tscn"
		var toSpawn=load(path).instantiate()
		get_parent().add_child(toSpawn)
		toSpawn.player=player
		var offset:Vector2 = Vector2(0, 0)
		offset.x=randf_range(-1.0, 1.0)
		offset.y=randf_range(-1.0, 1.0)
		offset=offset.normalized()
		offset*=1750
		toSpawn.global_position=player.global_position+offset
		if(toSpawn.global_position.x>5370):
			toSpawn.global_position.x=5370
		if(toSpawn.global_position.y<-3333):
			toSpawn.global_position.y=-3333
		if(toSpawn.global_position.x<-4115):
			toSpawn.global_position.x=-4115
		if(toSpawn.global_position.y>3090):
			toSpawn.global_position.y=3090
		await get_tree().create_timer(4.0/quantity, false).timeout
	quantity*=1.05
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
