extends Label

var root
var last_position = Vector2(0,0)
var follow = false
var offset = Vector2(0,0)
var blank_card 

func _physics_process(delta):
	if follow == true:
		_set_global_position(get_global_mouse_position() - offset)

func _on_card_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed == true:
			follow = true
			root.card_focused = true
			root.focused_card = self
			last_position = get_global_position() 
			offset = get_global_mouse_position() - self.get_global_position()

#			var index = get_index()
#			get_parent().remove_child(self)
#			root.add_child(self)
			

#			if child_node.get_parent():
#			    child_node.get_parent().remove_child(child_node)
#				add_child(child_node)	
#		elif event.pressed == false:
#			#print("here")
#			follow = false
#			root.card_focused = false
#			root.focused_card = null
#			set_global_position(last_position)	
#			last_position = get_global_position()
#			offset = Vector2(0,0)
			
			
