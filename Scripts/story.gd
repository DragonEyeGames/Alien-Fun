extends Control

var time=0.0

var page=0

func _ready() -> void:
	$ColorRect2/RichTextLabel.visible_characters=0
	
func _process(delta: float) -> void:
	if($ColorRect2/RichTextLabel.visible_ratio<1):
		time+=delta
		if(time>=.05):
			time-=.05
			$ColorRect2/RichTextLabel.visible_characters+=1
	else:
		$Continue.visible=true


func _on_continue_pressed() -> void:
	page+=1
	if(page==1):
		$ColorRect2/RichTextLabel.visible_characters=0
		$ColorRect2/RichTextLabel.text="But then an alien planet showed up and started to invade."
		$Continue.visible=false
		$StoryTeller.play("queuePlanet")
	if(page==2):
		$ColorRect2/RichTextLabel.visible_characters=0
		$ColorRect2/RichTextLabel.text="They took every single last natural resource from the planet."
		$Continue.visible=false
		$StoryTeller.play("drain")
	if(page==3):
		$ColorRect2/RichTextLabel.visible_characters=0
		$ColorRect2/RichTextLabel.text="Now it is your job to fight back for our planet and beat these aliens."
		$Continue.visible=false
	if(page==4):
		$ColorRect2/RichTextLabel.visible_characters=0
		$ColorRect2/RichTextLabel.text="Good Luck"
		$Continue.visible=false
	if(page==5):
		_on_skip_pressed()


func _on_skip_pressed() -> void:
	$ColorRect3/AnimationPlayer.play("leave")
	await get_tree().create_timer(.5).timeout
	await get_tree().process_frame
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_skip_mouse_entered() -> void:
	var tween=create_tween()
	tween.tween_property($Skip, "modulate:a", 1, .1)


func _on_skip_mouse_exited() -> void:
	var tween=create_tween()
	tween.tween_property($Skip, "modulate:a", .5, .1)


func _on_continue_mouse_entered() -> void:
	var tween=create_tween()
	tween.tween_property($Continue, "scale", Vector2(.5, .5), .1)


func _on_continue_mouse_exited() -> void:
	var tween=create_tween()
	tween.tween_property($Continue, "scale", Vector2(.45, .45), .1)
