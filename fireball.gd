extends CharacterBody2D
var target

func _ready() -> void:
	await get_tree().process_frame
	velocity=target.global_position-global_position
	look_at(target.global_position)
	rotation_degrees-=90
	velocity*=3
	
func _physics_process(_delta: float) -> void:
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body is Enemy):
		body.kill()
		velocity=Vector2.ZERO
		$Sprite.play("explode")


func _on_sprite_animation_finished() -> void:
	queue_free()
