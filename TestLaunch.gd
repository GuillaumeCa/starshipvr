extends Spatial

onready var launchpath = $LaunchPath/follow
onready var returnpath = $ReturnPath/follow

var speed = 0 # m/s
var acceleration = 0.02

var phase = "ascent"

func _ready() -> void:
	$booster_base/booster.start_engine()

func _process(delta: float) -> void:
	if phase == "ascent":
		speed += acceleration
		launchpath.offset += speed + 0.2
		_move_booster_towards(launchpath.global_transform.origin)
		if launchpath.unit_offset > 0.999:
			phase = "return"
			speed = 0
			_separate_stage()
			
	elif phase == "return":
		speed += acceleration
		returnpath.offset += speed + 0.2
		_move_booster_towards(returnpath.global_transform.origin)
	
	$Camera.global_transform.origin.y = $booster_base.global_transform.origin.y
	$Camera.global_transform.origin.x = $booster_base.global_transform.origin.x

	
func _move_booster_towards(position: Vector3) -> void:
	var dir = (position - $booster_base.global_transform.origin).normalized()
	$booster_base.look_at(position, Vector3.UP)
	$booster_base.global_transform.origin += dir * speed

func _separate_stage() -> void:
	var ship = $booster_base/booster/starship
	var transform = ship.global_transform
	ship.get_parent().remove_child(ship)
	add_child(ship)
	ship.global_transform = transform
