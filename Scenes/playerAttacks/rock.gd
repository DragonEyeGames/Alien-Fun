extends CharacterBody2D
var target
var damage=1

func _ready() -> void:
	$Hit.pitch_scale+=randf_range(-.1, .1)
	$Launch.pitch_scale+=randf_range(-.1, .1)
	await get_tree().process_frame
	if(target==null):
		queue_free()
		return
	var targetPos = get_global_mouse_position()
	var distance = global_position.distance_to(targetPos)
	var duration = distance / (WeaponManager.items["fireball"]["stats"]["speed"]*200)
	
	# Create curve
	var curve := Curve2D.new()
	curve.add_point(global_position)

	var peak = (global_position + targetPos) / 2.0
	peak.y -= distance * 0.25  # arc height
	curve.add_point(peak)

	curve.add_point(targetPos)

	# Bake curve for sampling
	var length := curve.get_baked_length()

	# Tween a "travel distance" from 0 → length
	var tween := create_tween()
	tween.tween_method(
		func(d):
			global_position = curve.sample_baked(d),
		0.0, length, duration
	)

	tween.tween_callback(func():
		global_position = targetPos
	)
	
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
