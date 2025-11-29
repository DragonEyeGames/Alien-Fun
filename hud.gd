extends CanvasLayer

@export var player: Player
var xpOffset:=0.0
var bar: ProgressBar
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
	$LevelUp.visible=true


func _on__pressed() -> void:
	print("1")


func _on_two_pressed() -> void:
	print("2")


func _on_three_pressed() -> void:
	print("3")
