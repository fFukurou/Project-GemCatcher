extends Area2D

class_name Gem

signal on_gem_off_screen

@export var speed: float = 550.0



func _ready() -> void:
	pass
	
	
	
func _process(delta: float) -> void:
	position.y += speed * delta
	
	if position.y > get_viewport_rect().size.y + 10:
		on_gem_off_screen.emit()
		set_process(false)
		queue_free()
