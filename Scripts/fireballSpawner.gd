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
		newFireball.target=collided.pick_random()
		var fireballDamage=WeaponManager.items["fireball"]["stats"]["damage"]
		newFireball.damage=fireballDamage
		await get_tree().create_timer(1/WeaponManager.items["fireball"]["stats"]["count"]).timeout
		canFire=true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body is Enemy):
		collided.append(body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body is Enemy and body in collided):
		collided.erase(body)
