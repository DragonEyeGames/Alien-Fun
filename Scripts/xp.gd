extends Node2D


func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.get_parent() is Player):
		var tween=create_tween()
		tween.tween_property(self, "global_position", area.get_parent().global_position, .2)
		await get_tree().create_timer(.2).timeout
		await get_tree().process_frame
		area.get_parent().xp+=1
		queue_free()
