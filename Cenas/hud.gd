extends CanvasLayer

signal reinicia

func _on_button_pressed() -> void:
	emit_signal("reinicia")
