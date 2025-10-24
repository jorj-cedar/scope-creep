extends RigidBody2D

#signal good_collected

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var good_labels = [
		"SENSIBLE PLANNING",
		"JUST A FEW LEVELS",
		"ONE MECHANIC DONE WELL",
		"MINIMUM VIABLE PRODUCT",
		"TIME MANAGEMENT",
		"FINISH WHAT'S THERE",
		"REALISTIC GOALS",
		"IF IT WORKS IT WORKS"
	]

	$GoodTypeLabel.text = good_labels.pick_random()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
