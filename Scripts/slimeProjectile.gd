extends CharacterBody2D
var target
var type=""
var damage=1

func _ready() -> void:
	$Hit.pitch_scale+=randf_range(-.1, .1)
	$Launch.pitch_scale+=randf_range(-.1, .1)
	await get_tree().process_frame
	$Projectile.play(type)
	if(target==null):
		queue_free()
		return
	look_at(target.global_position)
	rotation_degrees-=90
	velocity=target.global_position-global_position
	velocity=velocity.normalized()*700
	
func _physics_process(_delta: float) -> void:
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.get_parent() is Player):
		body.get_parent().attack(damage)
		velocity=Vector2.ZERO
		$Projectile.play(type + "Burst")
		$Hit.play()


func _on_sprite_animation_finished() -> void:
	queue_free()
