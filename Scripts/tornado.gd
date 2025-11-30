extends CharacterBody2D
var target
var damage=1
var pulling=[]
var hit=[]

func _ready() -> void:
	$Sound.pitch_scale+=randf_range(-.1, .1)
	await get_tree().process_frame
	velocity=target.global_position-global_position
	velocity=velocity.normalized()*300
	velocity*=WeaponManager.items["tornado"]["stats"]["speed"]
	await get_tree().create_timer(WeaponManager.items["tornado"]["stats"]["duration"]-.1, false).timeout
	var tween=create_tween()
	tween.tween_property($Sound, "volume_db", -80, .1)
	await get_tree().create_timer(.1).timeout
	queue_free()
	
func _physics_process(_delta: float) -> void:
	for enemy in pulling:
		var toMove=global_position-enemy.global_position
		toMove=toMove.normalized()*8
		enemy.global_position+=(toMove)
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body is Enemy and not body in hit):
		body.hurt(damage)
		hit.append(body)


func _on_pull_body_entered(body: Node2D) -> void:
	if(body is Enemy):
		pulling.append(body)


func _on_pull_body_exited(body: Node2D) -> void:
	if(body is Enemy and body in pulling):
		pulling.erase(body)
