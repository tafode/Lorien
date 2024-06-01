extends PanelContainer
class_name ProjectTab

# -------------------------------------------------------------------------------------------------
var style_active = preload("res://UI/Themes/dark/style_tab_active.tres")
var style_inactive = preload("res://UI/Themes/dark/style_tab_inactive.tres")

# -------------------------------------------------------------------------------------------------
signal selected
signal close_requested

# -------------------------------------------------------------------------------------------------
onready var _filename_button: Button = $HBoxContainer/FilenameButton
onready var _close_button: TextureButton = $HBoxContainer/CloseButton

var is_active := false
var title: String setget set_title
var project_id: int

# -------------------------------------------------------------------------------------------------
func _ready():
	set_active(false)
	_filename_button.text = title

# -------------------------------------------------------------------------------------------------
func set_title(t: String) -> void:
	title = t
	if _filename_button != null:
		_filename_button.text = title

# -------------------------------------------------------------------------------------------------
func _on_FilenameButton_pressed():
	emit_signal("selected", self)

# -------------------------------------------------------------------------------------------------
func _on_CloseButton_pressed():
	emit_signal("close_requested", self)

# -------------------------------------------------------------------------------------------------
func set_active(active: bool) -> void:
	is_active = active
	var new_style = style_inactive
	if is_active:
		new_style = style_active
	set("custom_styles/panel", new_style)

# -------------------------------------------------------------------------------------------------
func on_theme_changed(theme_name) -> void:
	style_active = load("res://UI/Themes/" + theme_name + "/style_tab_active.tres")
	style_inactive = load("res://UI/Themes/" + theme_name + "/style_tab_inactive.tres")
