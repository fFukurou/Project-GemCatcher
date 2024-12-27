extends Node2D

const EXPLODE = preload("res://assets/explode.wav")


@export var gem_scene: PackedScene

@onready var score_label: Label = $Label
@onready var timer: Timer = $Timer
@onready var music: AudioStreamPlayer = $Music
@onready var gem_catch_sfx: AudioStreamPlayer2D = $GemCatchSFX



var _score: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_gem()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()



func spawn_gem() -> void:
	var new_gem: Gem = gem_scene.instantiate()
	new_gem.on_gem_off_screen.connect(game_over)
	var xpos: float = randf_range(70, 1050)
	new_gem.position = Vector2(xpos, -50)
	self.add_child(new_gem)
	
func stop_all() -> void:
	timer.stop()
	for child in get_children():
		child.set_process(false)
	

func play_dead() -> void:
	music.stop()
	gem_catch_sfx.stop()
	gem_catch_sfx.stream = EXPLODE
	gem_catch_sfx.play()

func game_over() -> void:
	stop_all()
	play_dead()
	

func _on_timer_timeout() -> void:
	#print("timeout")
	spawn_gem()


func _on_paddle_area_entered(area: Area2D) -> void:
	_score += 1
	score_label.text = "%05d" % _score # <------ Nice way to add padding to the score and shit
	gem_catch_sfx.position = area.position
	gem_catch_sfx.play()
	area.queue_free()
	
	
