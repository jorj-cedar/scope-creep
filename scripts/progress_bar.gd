extends TextureProgressBar

@export var flash_interval = 0.5 # Seconds

var is_flashing = false
var original_color : Color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func flash():
	$AnimationPlayer.play("progress_flash")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
