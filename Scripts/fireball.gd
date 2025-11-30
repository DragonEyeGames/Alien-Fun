extends CharacterBody2D
var target
var damage=1

func _ready() -> void:
	$Hit.pitch_scale+=randf_range(-.1, .1)
	$Launch.pitch_scale+=randf_range(-.1, .1)
	await get_tree().process_frame
	velocity=target.global_position-global_position
	look_at(target.global_position)
	rotation_degrees-=90
	velocity=velocity.normalized()*700
	velocity*=WeaponManager.items["fireball"]["stats"]["speed"]
	
func _physics_process(_delta: float) -> void:
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body is Enemy):
		body.hurt(damage)
		velocity=Vector2.ZERO
		$Sprite.play("explode")
		$Hit.play()


func _on_sprite_animation_finished() -> void:
	queue_free()
