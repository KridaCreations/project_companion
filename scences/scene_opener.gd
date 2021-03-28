extends Button

var root
var followed = false
var associated_scene : String
var last_position = Vector2(0,0)
var follow = false
var offset = Vector2(0,0)

func _ready():
	pass

func _physics_process(delta):
	if follow == true:
		_set_global_position(get_global_mouse_position() - offset)
		root.get_node("delete_option").visible = true
		if root.get_node("delete_option").get_global_rect().has_point(get_global_mouse_position()):
			root.get_node("delete_option/sprite").frame = 1
		else:
			root.get_node("delete_option/sprite").frame = 0	 
	
func open_scene():
	if followed == false:
		get_tree().change_scene(associated_scene)
	else:
		followed = false

func gui_input(event):
	if event is InputEventMouseMotion and follow == true:
		if event.relative.length() > 4:
			followed = true
		
	if event is InputEventMouseButton:
		if event.pressed == true:
			follow = true
			last_position = get_global_position()
			offset = get_global_mouse_position() - self.get_global_position()
			
		elif event.pressed == false:
			if root.get_node("delete_option").get_global_rect().has_point(get_global_mouse_position()):
				var dir = Directory.new()
				root.get_node("delete_option").visible = false
				if dir.file_exists(associated_scene):
					dir.remove(associated_scene)
				queue_free()
			set_global_position(last_position)
			follow = false
			offset = Vector2(0,0)
