extends VBoxContainer

onready var new_card_button = $new_card_name

export  (NodePath) var demo_card_path setget set_path

var root
var last_position = Vector2(0,0)

var follow = false
var offset = Vector2(0,0)

#variables_for children movement

var child_focused = false
var focused_node = null
var demo_card


func _ready():
	pass

func _physics_process(delta):
	if follow == true:
		_set_global_position(get_global_mouse_position() - offset)
	
	if child_focused == true:
		var mouse_position = get_global_mouse_position()
		for i in get_children():
			if i.get_global_rect().has_point(mouse_position) and i != focused_node and i != $detail and i != $new_card_name:
				#print(i.get_rect())
				#print(get_global_mouse_position())
				move_child(focused_node,i.get_index())
				focused_node.last_position = i.get_global_position()
	
	
	
func _on_new_card_name_text_entered(new_text):
	if new_text!= "" :
		var new_card = demo_card.duplicate(4)
		add_child_below_node($new_card_name,new_card)
		new_card.text = new_text
		new_card_button.text = "" 
		new_card.root = self
		print(new_card.connect("gui_input",new_card,"_on_card_gui_input"))


func set_path(val):
	pass


func _on_detail_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed == true:
			follow = true
			root.child_focused = true
			root.focused_node = self
			last_position = get_global_position()
			offset = get_global_mouse_position() - self.get_global_position()
		elif event.pressed == false:
			set_global_position(last_position)
			follow = false
			root.list_container.move_child(self,self.get_index())
			root.child_focused = false
			root.focused_node = null
			last_position = get_global_position()
			offset = Vector2(0,0)


