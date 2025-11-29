extends Node2D

var collided=[]
@export var fireball: PackedScene

var canFire=true

func _process(_delta: float) -> void:
	if(len(collided)>=1 and canFire):
		canFire=false
		var newFireball=fireball.instantiate()
		get_parent().get_parent().add_child(newFireball)
		newFireball.global_position=self.global_position
		newFireball.target=collided[0]
		collided.remove_at(0)
		await get_tree().create_timer(get_parent().waitTime).timeout
		canFire=true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body is Enemy):
		collided.append(body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body is Enemy and body in collided):
		collided.erase(body)
