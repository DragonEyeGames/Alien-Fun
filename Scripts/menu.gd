extends Control
	
func _on_texture_button_pressed() -> void:
	$Blocker/AnimationPlayer.play("show")
	var tween=create_tween()
	tween.tween_property($AudioStreamPlayer2D, "volume_db", -80, .5)
	await get_tree().create_timer(.5).timeout
	await get_tree().process_frame
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://Scenes/story.tscn")


func _on_texture_button_mouse_entered() -> void:
	var tween=create_tween()
	tween.tween_property($TextureButton, "scale", Vector2(1.1, 1.1), .1)


func _on_texture_button_mouse_exited() -> void:
	var tween=create_tween()
	tween.tween_property($TextureButton, "scale", Vector2(1, 1), .1)


func _on_full_pressed() -> void:
	DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN)


func _on_full_mouse_entered() -> void:
	var tween=create_tween()
	tween.tween_property($Full, "scale", Vector2(1.1, 1.1), .1)


func _on_full_mouse_exited() -> void:
	var tween=create_tween()
	tween.tween_property($Full, "scale", Vector2(1, 1), .1)
