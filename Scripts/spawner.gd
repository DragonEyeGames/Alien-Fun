extends Node2D
class_name Spawner

var collided=[]
@export var projectile: PackedScene
@export var item:=""

@export var always=false

var canFire=true

func _process(_delta: float) -> void:
	if(not WeaponManager.double):
		if(len(collided)>=1):
			for enemy in collided:
				if(enemy.health<=0):
					collided.erase(enemy)
		if((len(collided)>=1 or always) and canFire):
			canFire=false
			var newProjectile=projectile.instantiate()
			get_parent().get_parent().add_child(newProjectile)
			newProjectile.global_position=self.global_position
			if(not always):
				newProjectile.target=collided.pick_random()
			else:
				newProjectile.target=get_parent()
			var damage=WeaponManager.items[item]["stats"]["damage"]
			newProjectile.damage=damage
			newProjectile.scale=Vector2(WeaponManager.items[item]["stats"]["size"], WeaponManager.items[item]["stats"]["size"])
			await get_tree().create_timer(1.0/WeaponManager.items[item]["stats"]["count"]).timeout
			canFire=true
	else:
		for thingy in collided:
			if(not thingy.boss):
				collided.erase(thingy)
		if(len(collided)>=1 and canFire and get_parent().get_parent().boss!=null):
			canFire=false
			var newProjectile=projectile.instantiate()
			get_parent().get_parent().add_child(newProjectile)
			newProjectile.global_position=self.global_position
			if(not always):
				newProjectile.target=get_parent().get_parent().boss
			else:
				newProjectile.target=get_parent()
			var damage=WeaponManager.items[item]["stats"]["damage"]
			newProjectile.damage=damage
			newProjectile.scale=Vector2(WeaponManager.items[item]["stats"]["size"], WeaponManager.items[item]["stats"]["size"])
			await get_tree().create_timer(1.0/WeaponManager.items[item]["stats"]["count"]).timeout
			canFire=true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body is Enemy):
		collided.append(body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body is Enemy and body in collided):
		collided.erase(body)
