extends Node2D

var damage=0

func _ready():
	visible=false
	await get_tree().process_frame
	visible=true
	$RichTextLabel.text=str(damage)
	await get_tree().create_timer(1).timeout
	queue_free()
