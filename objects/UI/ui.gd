extends Control

@onready var btn_no_clip_texture: TextureRect = $MarginContainer/ActionbarBackground/MarginContainer/HBoxContainer/NoClip/TextureRect


func _init() -> void:
	Global.ui = self


func _on_btn_no_clip_pressed() -> void:
	if Global.game.player:
		Global.game.player.no_clip = not Global.game.player.no_clip


func update_no_clip_button() -> void:
	if Global.game.player.no_clip:
		btn_no_clip_texture.modulate = Color(1, 1, 1, 1)
	else:
		btn_no_clip_texture.modulate = Color(1, 1, 1, 0.5)
