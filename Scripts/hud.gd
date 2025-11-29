extends CanvasLayer

@export var player: Player
var xpOffset:=0.0
var bar: ProgressBar

var upgrades=[["", "", "", 0, 0], ["", "", "", 0, 0], ["", "", "", 0, 0]]

@export var fireballSpawner: PackedScene
@export var fistSpawner: PackedScene
@export var lightningSpawner: PackedScene
@export var tornadoSpawner: PackedScene
@export var dustSpawner: PackedScene

@export var spawnController: Node2D
@export var doubleScene: PackedScene
var selected:=0

var bossType

var oldPosition:Vector2 = Vector2(0, 0)
var oldHealth:=0.0

func _ready() -> void:
	randomize()
	bar=$XP
	pickWeapon()
	
func pickWeapon():
	var children = $Weapons/VBoxContainer.get_children()
	children.shuffle()
	for i in range(3):
		var child=children[i]
		child.visible=true
		$Weapons/VBoxContainer.remove_child(child)
		$Weapons/VBoxContainer.add_child(child)
	$Weapons.visible=true
	get_tree().paused=true
	
func _process(_delta: float) -> void:
	if(player==null):
		return
	if($Health.max_value!=WeaponManager.items["player"]["stats"]["health"]):
		var health = $Health.value + (WeaponManager.items["player"]["stats"]["health"]-$Health.max_value)
		$Health.max_value=WeaponManager.items["player"]["stats"]["health"]
		$Health.value=health
	$Health.value=player.health
	bar.value=player.xp-xpOffset
	if(bar.value >=bar.max_value):
		bar.value-=bar.max_value
		xpOffset+=bar.max_value
		bar.max_value+=round((bar.max_value/2))
		levelUp()
	if(player.dead and $Over.visible==false):
		await get_tree().create_timer(2).timeout
		$Over.visible=true
		
func levelUp():
	spawnController.quantity+=1
	get_tree().paused=true
	var upgradeChoices = WeaponManager.items.duplicate()
	var keys = upgradeChoices.keys()
	var iteration=0
	for child in $LevelUp/VBoxContainer.get_children():
		var random_key = keys.pick_random()
		var random_item = upgradeChoices[random_key]
		keys.erase(random_key)
		update(child, random_item, random_key, iteration)
		iteration+=1
	$LevelUp.visible=true

func update(node, item, keyName, number):
	if(item["level"]!=0):
		var upgradeChoices = item["stats"].duplicate()
		var keys=upgradeChoices.keys()
		
		var upgrade1 = keys.pick_random()
		keys.erase(upgrade1)
		var upgrade2 = keys.pick_random()
		keys.erase(upgrade2)
		
		node.get_node("title").text=str(keyName)
		
		var current1=WeaponManager.items[keyName]["stats"][upgrade1]
		var final1
		if(WeaponManager.items[keyName]["upgrade_type"][upgrade1]=="mul"):
			final1=current1*WeaponManager.items[keyName]["upgrades"][upgrade1]
		else:
			final1=current1+WeaponManager.items[keyName]["upgrades"][upgrade1]
			
		var current2=WeaponManager.items[keyName]["stats"][upgrade2]
		var final2
		if(WeaponManager.items[keyName]["upgrade_type"][upgrade2]=="mul"):
			final2=current2*WeaponManager.items[keyName]["upgrades"][upgrade2]
		else:
			final2=current2+WeaponManager.items[keyName]["upgrades"][upgrade2]
		node.get_node("description").text=str(upgrade1) + ": " + str(current1) + " -> " + str(final1) +  "    " + str(upgrade2) + ": " + str(current2) + " -> " + str(final2)
		
		upgrades[number][0]=keyName
		upgrades[number][1]=upgrade1
		upgrades[number][2]=upgrade2
		upgrades[number][3]=final1
		upgrades[number][4]=final2
	else:
		node.get_node("title").text=str(keyName)
		node.get_node("description").text=str(item["description"])
		upgrades[number][0]=keyName
		upgrades[number][1]="damage"
		upgrades[number][2]="damage"
		upgrades[number][3]=item["stats"]["damage"]
		upgrades[number][4]=item["stats"]["damage"]

func _on__pressed() -> void:
	option(0)


func _on_two_pressed() -> void:
	option(1)


func _on_three_pressed() -> void:
	option(2)
	
func option(number):
	selected=number
	$LevelUp.visible=false
	if(WeaponManager.items[upgrades[selected][0]]["level"]>=1):
		$DoubleNothing.visible=true
	else:
		upgrade()
	
func upgrade():
	$LevelUp.visible=false
	$DoubleNothing.visible=false
	get_tree().paused=false
	WeaponManager.items[upgrades[selected][0]]["stats"][upgrades[selected][1]]=upgrades[selected][3]
	WeaponManager.items[upgrades[selected][0]]["stats"][upgrades[selected][2]]=upgrades[selected][4]
	WeaponManager.items[upgrades[selected][0]]["level"]+=1
	if(WeaponManager.items[upgrades[selected][0]]["level"]==1):
		if(upgrades[selected][0]=="fireball"):
			_on_fireball_pressed()
		elif(upgrades[selected][0]=="fist"):
			_on_fist_pressed()
		elif(upgrades[selected][0]=="lightning"):
			_on_lightning_pressed()
		elif(upgrades[selected][0]=="tornado"):
			_on_tornado_pressed()
		elif(upgrades[selected][0]=="dust halo"):
			_on_halo_pressed()


func _on_fireball_pressed() -> void:
	$Weapons.visible=false
	WeaponManager.items["fireball"]["level"]=1
	get_tree().paused=false
	var fireSpawner = fireballSpawner.instantiate()
	player.add_child(fireSpawner)
	fireSpawner.global_position=player.global_position
	


func _on_lightning_pressed() -> void:
	$Weapons.visible=false
	WeaponManager.items["lightning"]["level"]=1
	get_tree().paused=false
	var lightSpawner = lightningSpawner.instantiate()
	player.add_child(lightSpawner)
	lightSpawner.global_position=player.global_position


func _on_fist_pressed() -> void:
	$Weapons.visible=false
	WeaponManager.items["fist"]["level"]=1
	get_tree().paused=false
	var spawner = fistSpawner.instantiate()
	player.add_child(spawner)
	spawner.global_position=player.global_position
	
func _on_tornado_pressed() -> void:
	$Weapons.visible=false
	WeaponManager.items["tornado"]["level"]=1
	get_tree().paused=false
	var spawner = tornadoSpawner.instantiate()
	player.add_child(spawner)
	spawner.global_position=player.global_position
	
func _on_halo_pressed() -> void:
	$Weapons.visible=false
	WeaponManager.items["dust halo"]["level"]=1
	get_tree().paused=false
	var spawner = dustSpawner.instantiate()
	player.add_child(spawner)
	spawner.global_position=player.global_position


func _on_dead_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_double_pressed() -> void:
	oldHealth=player.health
	player.get_node("MainCamera").position_smoothing_enabled=false
	get_tree().paused=false
	$XP.visible=false
	$DoubleNothing.visible=false
	oldPosition=player.global_position
	var newDouble=doubleScene.instantiate()
	get_parent().add_child(newDouble)
	spawnController.process_mode=Node.PROCESS_MODE_DISABLED
	WeaponManager.double=true
	newDouble.global_position=player.global_position
	var toSpawn=null
	for key in spawnController.spawn_table:
		if(spawnController.spawn_table[key]==0):
			var path="res://Scenes/enemies/" + str(key) + ".tscn"
			bossType=key
			toSpawn=load(path).instantiate()
			newDouble.add_child(toSpawn)
			newDouble.boss=toSpawn
			var newOffset:=Vector2.ZERO
			newOffset.x=randf_range(-1.0, 1.0)
			newOffset.y=randf_range(-1.0, 1.0)
			newOffset=newOffset.normalized()
			newOffset*=1000
			toSpawn.global_position=player.global_position+newOffset
			toSpawn.player=player
			toSpawn.boss=true
			toSpawn.hud=self
			break
	if(toSpawn==null):
		var path="res://Scenes/enemies/yellow.tscn"
		bossType="yellow"
		toSpawn=load(path).instantiate()
		newDouble.add_child(toSpawn)
		newDouble.boss=toSpawn
		var newOffset:=Vector2.ZERO
		newOffset.x=randf_range(-1.0, 1.0)
		newOffset.y=randf_range(-1.0, 1.0)
		newOffset=newOffset.normalized()
		newOffset*=1000
		toSpawn.global_position=player.global_position+newOffset
		toSpawn.player=player
		toSpawn.boss=true
		toSpawn.hud=self
	await get_tree().process_frame
	reparent(newDouble)
	player.reparent(newDouble)
	player.z_index+=10
	await get_tree().process_frame
	player.get_node("MainCamera").position_smoothing_enabled=true

func bossDefeated():
	if($Lost.visible or $BossDefeated.visible):
		return
	await get_tree().create_timer(1).timeout
	$BossDefeated.visible=true


func _on_beaten_pressed() -> void:
	if($Lost.visible):
		return
	player.health=oldHealth
	spawnController.process_mode=Node.PROCESS_MODE_INHERIT
	upgrade()
	upgrade()
	var double=get_parent()
	reparent(double.get_parent())
	player.reparent(get_parent())
	double.queue_free()
	WeaponManager.double=false
	player.z_index-=10
	$XP.visible=true
	$BossDefeated.visible=false
	spawnController.spawn_table[bossType]+=.05
	player.global_position=oldPosition
	player.get_node("MainCamera").position_smoothing_enabled=false
	await get_tree().process_frame
	await get_tree().process_frame
	player.get_node("MainCamera").position_smoothing_enabled=true

func playerDied():
	if($Lost.visible or $BossDefeated.visible):
		return
	await get_tree().create_timer(1).timeout
	$Lost.visible=true


func _on_defeated_pressed() -> void:
	if($BossDefeated.visible):
		return
	player.dead=false
	player.health=oldHealth
	spawnController.process_mode=Node.PROCESS_MODE_INHERIT
	var double=get_parent()
	reparent(double.get_parent())
	player.reparent(get_parent())
	double.queue_free()
	WeaponManager.double=false
	player.z_index-=10
	$XP.visible=true
	$Lost.visible=false
	player.global_position=oldPosition
	player.get_node("MainCamera").position_smoothing_enabled=false
	await get_tree().process_frame
	await get_tree().process_frame
	player.get_node("MainCamera").position_smoothing_enabled=true
