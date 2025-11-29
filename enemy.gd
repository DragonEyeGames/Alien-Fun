extends CharacterBody2D
class_name Enemy

@export var player: Player
@export var speed:= 1.0

var dead=false

func _physics_process(_delta: float) -> void:
	if(not dead):
		velocity=player.global_position-global_position
		velocity*=speed
		move_and_slide()

func kill():
	dead=true
	$Icon.play("dead")
	


func _on_icon_animation_finished() -> void:
	queue_free()
