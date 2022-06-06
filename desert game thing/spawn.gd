extends Spatial


func _ready():
	$AudioStreamPlayer3D.play()
	$AudioStreamPlayer3D2.play()
	$AudioStreamPlayer3D3.play()
	$AudioStreamPlayer3D4.play()
	get_node("Pause").visible = false
	
	get_node("stairs").visible = false
	get_node("stairs/collision/StaticBody/CollisionShape").disabled = true
	get_node("Red").visible = false
	get_node("Red/gate/StaticBody/CollisionShape").disabled = true
	
	
func _process(delta):	

	if get_node("Player").translation.y < -3800 :
		
		get_node("Player").translation = get_node("Spawn").translation
		get_node("Player").rotation = get_node("Spawn").rotation
		get_node("vultures").translation = get_node("vultureTele1").translation

		get_node("stairs").visible = true
		get_node("stairs/collision/StaticBody/CollisionShape").disabled = false
		get_node("Red").visible = true
		get_node("Red/gate/StaticBody/CollisionShape").disabled = false
		
		
		
		get_node("bigvulture").visible = false
		get_node("gates/gate5").visible = true
		get_node("gates/gatedive").visible = false
		get_node("gates/gate4").visible = false
