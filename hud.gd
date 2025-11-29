extends CanvasLayer

@export var player: Player
var xpOffset:=0.0
var bar: ProgressBar
var options=["Fireball", "Lightning", "Player"]
var powerups = [["Damage", "Projectiles", "Speed", "Size"], ["Speed", "Health"]]
func _ready() -> void:
	bar=$ProgressBar
	
func _process(_delta: float) -> void:
	bar.value=player.xp-xpOffset
	if(bar.value >=bar.max_value):
		bar.value-=bar.max_value
		xpOffset+=bar.max_value
		bar.max_value+=round((bar.max_value/2))
		levelUp()
		
func levelUp():
	get_tree().paused=true
	var backupOptions = options.duplicate()
	var choice = backupOptions.pick_random()
	
	var backupPowers = powerups.duplicate()
	
	$LevelUp/VBoxContainer/Slot/RichTextLabel.text=choice
	var backupPowerList = backupPowers[options.find(choice)]
	backupOptions.erase(choice)
	var item1 = backupPowerList.pick_random()
	backupPowerList.erase(item1)
	var item2 = backupPowerList.pick_random()
	backupPowerList.erase(item2)
	$LevelUp/VBoxContainer/Slot/RichTextLabel2.text=item1 + ": 1 -> 2, " + item2 + ": 1 -> 2"
	choice = backupOptions.pick_random()
	$LevelUp/VBoxContainer/Slot2/RichTextLabel.text=choice
	backupOptions.erase(choice)
	choice = backupOptions.pick_random()
	$LevelUp/VBoxContainer/Slot3/RichTextLabel.text=choice
	backupOptions.erase(choice)
	$LevelUp.visible=true


func _on__pressed() -> void:
	print("1")


func _on_two_pressed() -> void:
	print("2")


func _on_three_pressed() -> void:
	print("3")
