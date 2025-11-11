class_name TextBoxTool 
extends CanvasTool

signal show_textBoxDialog
signal edit_existing_textBox

enum State {
	NONE,
	CREATING,
	EDITING
}

@export
var _state = State.NONE
@export
var _position : Vector2

func _ready() -> void:
	super()
	_state = State.NONE

func _process(delta: float) -> void:
	print("State: ", _state)
# -------------------------------------------------------------------------------------------------
func tool_event(event: InputEvent) -> void:
	
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			print(_state)
			if event.pressed && _state == State.NONE:
				print("Create TextEdit Here")
				
				for textBox : Control in get_parent()._textboxes_parent.get_children():
					if textBox is Label:
						print("Label ", event.global_position, textBox.get_rect(), textBox.get_global_rect())
						
						if textBox.get_rect().has_point(event.global_position):
							print("Click inside TextBox")
							edit_existing_textBox.emit(textBox)
							_state = State.EDITING
						else:
							print("Clicking outside TextBox")
					elif textBox is TextEdit:
						print("TextEdit")
				
				if _state == State.NONE:
					show_textBoxDialog.emit(_cursor.global_position)
			
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			print("END Edit")
