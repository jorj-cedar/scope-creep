extends Area2D

@export var speed = 400
var screen_size

signal hit
signal embiggen
signal pickup

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	velocity.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else: 
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
		
		


func _on_body_entered(body) -> void:
	#hide()
	#hit.emit()
	
	embiggen.emit()
	body.queue_free()
	#$CollisionShape2D.set_deferred("disabled", true)

	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	


func _on_pickup_finder_body_entered(body: Node2D) -> void:
	pickup.emit()
	
	body.queue_free()
