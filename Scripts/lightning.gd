extends Node2D
var target
var damage=1

func _ready() -> void:
	visible=false
	await get_tree().process_frame
	visible=true
	if(target!=null):
		global_position=target.global_position
		$Sound.pitch_scale+=randf_range(-.1, .1)
	else:
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body is Enemy):
		body.hurt(damage)


func _on_sprite_animation_finished() -> void:
	queue_free()
