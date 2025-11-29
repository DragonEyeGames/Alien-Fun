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
	upgrade(0)


func _on_two_pressed() -> void:
	upgrade(1)


func _on_three_pressed() -> void:
	upgrade(2)
	
func upgrade(item):
	$LevelUp.visible=false
	get_tree().paused=false
	WeaponManager.items[upgrades[item][0]]["stats"][upgrades[item][1]]=upgrades[item][3]
	WeaponManager.items[upgrades[item][0]]["stats"][upgrades[item][2]]=upgrades[item][4]
	WeaponManager.items[upgrades[item][0]]["level"]+=1
	if(WeaponManager.items[upgrades[item][0]]["level"]==1):
		if(upgrades[item][0]=="fireball"):
			_on_fireball_pressed()
		elif(upgrades[item][0]=="fist"):
			_on_fist_pressed()
		elif(upgrades[item][0]=="lightning"):
			_on_lightning_pressed()
		elif(upgrades[item][0]=="tornado"):
			_on_tornado_pressed()
		elif(upgrades[item][0]=="dust halo"):
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
