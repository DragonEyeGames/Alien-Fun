extends Node2D

func _ready() -> void:
	$sound.pitch_scale+=randf_range(-.1, .1)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.get_parent() is Player and not WeaponManager.double):
		var tween=create_tween()
		$sound.play()
		tween.tween_property(self, "global_position", area.get_parent().global_position, .2)
		await get_tree().create_timer(.2).timeout
		await get_tree().process_frame
		area.get_parent().xp+=1
		queue_free()
