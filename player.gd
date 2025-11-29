extends CharacterBody2D

@export var speed=100

func _physics_process(_delta: float) -> void:
	velocity=Input.get_vector("Left", "Right", "Up", "Down")
	velocity*=speed
	move_and_slide()
