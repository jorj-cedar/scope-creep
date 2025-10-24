extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func flash(onoff):
	if onoff == true:
		$AnimationPlayer.play("progress_flash")
	elif onoff == false:
		$AnimationPlayer.stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
