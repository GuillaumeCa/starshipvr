tool
extends Spatial

export var orbit_speed = 0.2
export var earth_speed = 0.2

func _process(delta: float) -> void:
	#$Earth.rotation_degrees.y += earth_speed * delta
	#$pivot.rotation_degrees.y += orbit_speed * delta
