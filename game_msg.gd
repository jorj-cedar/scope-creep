extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	var fade_duration = 1.0
	var tween = get_tree().create_tween()
	
	tween.parallel().tween_property(self, "modulate", Color.TRANSPARENT, fade_duration)
	tween.parallel().tween_property(self, "scale", Vector2(3,3), 1.0)
	
	tween.tween_callback(self.queue_free)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
