extends Node2D
var target
var damage=1

func _ready() -> void:
	await get_tree().create_timer(.25).timeout
	$Area2D/CollisionShape2D.set_deferred("disabled", false)

func _process(_delta: float) -> void:
	print(target)
	if(target!=null):
		global_position=target.global_position

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body is Enemy):
		body.hurt(damage)


func _on_sprite_animation_finished() -> void:
	queue_free()
