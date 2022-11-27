tool
extends Spatial

onready var particles = $CPUParticles
export var particle_count = 30
export var particle_lifetime = 2.0

export var gen = false setget _generate
export var emit = false setget toggle_emit

func _generate(val):
	init_particles()

func toggle_emit(on: bool):
	emit = on
	$CPUParticles.emitting = on

func init_particles():
	var positions = []
	for child in get_children():
		if child is Position3D:
			positions.append(child.transform.origin)

	if not positions.empty():
		particles.emission_points = PoolVector3Array(positions)
		particles.amount = particle_count * positions.size()
		particles.lifetime = particle_lifetime

func _ready() -> void:
	init_particles()
