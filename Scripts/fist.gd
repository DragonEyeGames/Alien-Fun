extends Node2D
var target
var damage=1

func _ready() -> void:
	$"Hit".pitch_scale+=randf_range(-.1, .1)
	await get_tree().process_frame
	if(target==null):
		queue_free()
		return
	look_at(target.global_position)
	rotation_degrees+=90
	var tween=create_tween()
	tween.tween_property(self, "global_position", target.global_position, .1)
	await get_tree().create_timer(.1).timeout
	await get_tree().process_frame
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body is Enemy):
		body.hurt(damage)
