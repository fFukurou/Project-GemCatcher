extends Area2D

@export var speed: float = 600.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("left") and self.position.x >= 0:
		self.position.x -= delta * speed

	if Input.is_action_pressed("right") and self.position.x <= get_window().size.x:
		self.position.x += delta * speed
		
	
