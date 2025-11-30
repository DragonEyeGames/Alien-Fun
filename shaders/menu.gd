extends Control


func _on_texture_button_pressed() -> void:
	$Blocker/AnimationPlayer.play("show")
	await get_tree().create_timer(.5).timeout
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_texture_button_mouse_entered() -> void:
	var tween=create_tween()
	tween.tween_property($TextureButton, "scale", Vector2(1.1, 1.1), .1)


func _on_texture_button_mouse_exited() -> void:
	var tween=create_tween()
	tween.tween_property($TextureButton, "scale", Vector2(1, 1), .1)
