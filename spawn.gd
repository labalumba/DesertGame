extends Spatial


func _ready():
	$AudioStreamPlayer3D.play()
	$AudioStreamPlayer3D2.play()
	$AudioStreamPlayer3D3.play()
	$AudioStreamPlayer3D4.play()
func _process(delta):	

	if get_node("Player").translation.y < -3800 :
		get_node("Player").translation = get_node("Spawn").translation
		get_node("Player").rotation = get_node("Spawn").rotation
		get_node("vultures").visible = false


