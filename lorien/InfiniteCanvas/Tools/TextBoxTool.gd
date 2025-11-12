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

# -------------------------------------------------------------------------------------------------
func tool_event(event: InputEvent) -> void:
		
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed && _state == State.NONE:
				
				for textBox : Control in get_parent()._textboxes_parent.get_children():
					if textBox is Label:
						if textBox.get_rect().has_point(event.global_position):
							edit_existing_textBox.emit(textBox)
							_state = State.EDITING
				
				if _state == State.NONE:
					show_textBoxDialog.emit(_cursor.global_position)
