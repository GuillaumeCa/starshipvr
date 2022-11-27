extends KinematicBody

export var target: Vector3
export var speed = 20.0

export var rot_speed = 0.1

var engine_on = false

func _physics_process(delta: float) -> void:
	var newTransform = global_transform.looking_at(target, Vector3.UP)
	var dir = global_translation.direction_to(target)
	var vel = dir * speed * delta
	
	if global_translation.distance_to(target) >= 0.2:
		if !engine_on:
			engine_on = true
			$starship.start_engine()
			
		global_translation += vel
		
		global_transform.basis = global_transform.basis.slerp(newTransform.basis, rot_speed)
	else:
		print("reached", engine_on)
		if engine_on:
			engine_on = false
			$starship.stop_engine()
