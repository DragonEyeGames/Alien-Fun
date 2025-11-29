extends CanvasLayer

@export var player: Player
var xpOffset:=0.0
var bar: ProgressBar

var upgrades=[["", "", "", 0, 0], ["", "", "", 0, 0], ["", "", "", 0, 0]]

func _ready() -> void:
	bar=$ProgressBar
	levelUp()
	
func _process(_delta: float) -> void:
	bar.value=player.xp-xpOffset
	if(bar.value >=bar.max_value):
		bar.value-=bar.max_value
		xpOffset+=bar.max_value
		bar.max_value+=round((bar.max_value/2))
		levelUp()
		
func levelUp():
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
