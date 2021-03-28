extends VBoxContainer

onready var new_card_button = $new_card_name

export  (NodePath) var demo_card_path setget set_path

var root
var last_position = Vector2(0,0)

var follow = false
var offset = Vector2(0,0)

#variables_for children movement
var blank_card
var demo_card
var card_focused = false
var focused_card = false

func _ready():
#	print($detail.owner.name)
#	print($new_card_name.owner.name)

	pass

func _physics_process(delta):
	if follow == true:
		_set_global_position(get_global_mouse_position() - offset)
	
	
	
func _on_new_card_name_text_entered(new_text):
	if new_text!= "" :
		var new_card = demo_card.duplicate(4)
		
		add_child_below_node(get_child(get_child_count()-2),new_card)
		new_card.set_owner(root)
		new_card.mouse_filter = MOUSE_FILTER_PASS
		new_card.text = new_text
		new_card.root = root
		new_card.blank_card = blank_card
		new_card.connect("gui_input",new_card,"_on_card_gui_input")
		
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
			root.child_focused = false
			var posx = (get_global_rect().size.x + root.list_container.get("custom_constants/separation")) * (get_index())
			last_position = root.list_container.get_global_position() + Vector2((posx),0) - Vector2(root.project_view.scroll_horizontal,root.project_view.scroll_vertical) - - Vector2(root.project_view.scroll_horizontal,root.project_view.scroll_vertical)
			#last_position = true
			set_global_position(last_position)
			follow = false
			root.child_focused = false
			root.focused_node = null
			offset = Vector2(0,0)


