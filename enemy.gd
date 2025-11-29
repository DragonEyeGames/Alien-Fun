extends CharacterBody2D
class_name Enemy

@export var player: Player
@export var speed:= 1.0

func _physics_process(_delta: float) -> void:
	velocity=player.global_position-global_position
	velocity*=speed
	move_and_slide()
