extends KinematicBody


export(Array, float) var stops = [] 
export var speed = 0.5

var target_stop = 0

var player: Spatial = null
var moving = false

func _ready() -> void:
	var id = 0
	for button in $buttons.get_children():
		button.connect("button_pressed", self, "_on_button_pressed", [id])
		id += 1
	$door_collision.disabled = true

func _physics_process(delta: float) -> void:
	var target_stop_h = stops[target_stop]
	
	if abs(target_stop_h - translation.y) > 0.2:
		var move_amount = sign(target_stop_h - translation.y) * speed * delta
		translation.y += move_amount
		moving = true
		if player:
			vr.vrOrigin.global_transform.origin.y += move_amount
	elif moving:
		# reached a stop
		$door_collision.disabled = true
		moving = false

func go_to_stop(idx: int) -> void:
	if idx >= 0 and idx < stops.size():
		target_stop = idx

func _on_button_pressed(idx: int):
#	vr.show_dbg_info("button pressed idx", idx)
	go_to_stop(idx)
	$door_collision.disabled = false


func _on_Area_area_entered(area: Area) -> void:
	if "player" in area.name:
		player = area.get_parent()


func _on_Area_area_exited(area: Area) -> void:
	if "player" in area.name:
		player = null
