tool
extends MeshInstance

export var earth_scale = 6.0 setget set_earth_scale

func set_earth_scale(new_scale):
	earth_scale = new_scale
	
	var scale_val = new_scale * 10
	scale.x = scale_val
	scale.y = scale_val
	scale.z = scale_val
