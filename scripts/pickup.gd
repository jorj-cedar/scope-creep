extends RigidBody2D
signal pickup_collected




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#func _on_body_entered(body: Node) -> void:
	#hide()
	#
	#pickup_collected.emit()
	#$CollisionShape2D.set_deferred("disabled", true) 
