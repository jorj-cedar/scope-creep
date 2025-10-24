extends Area2D

@export var speed = 400
var screen_size

signal embiggen
signal pickup
signal add_scope
signal shrink
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.animation = "folder_empty"
	screen_size = get_viewport_rect().size
	hide()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	
	
	if velocity.length() > 0:
		velocity *= speed
		#$AnimatedSprite2D.play()
	#else: 
		#$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if abs(velocity.x) > abs(velocity.y):
		#$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif abs(velocity.y) > abs(velocity.x):
		#$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0



func _on_body_entered(body) -> void:
	if body.is_in_group("mobs"):
		embiggen.emit()
		add_scope.emit(body.get_node("ScopeTypeLabel").text,Color.RED)
	elif body.is_in_group("goodmobs"):
		shrink.emit()
		add_scope.emit(body.get_node("GoodTypeLabel").text,Color.BLUE)
	
	body.queue_free()
	
func update_sprite(fullness):
	if fullness == 0:
		$AnimatedSprite2D.animation = "folder_empty"
	elif fullness == 1:
		$AnimatedSprite2D.animation = "folder_some"
	elif fullness == 2:
		$AnimatedSprite2D.animation = "folder_full"
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	


func _on_pickup_finder_body_entered(body: Node2D) -> void:
	pickup.emit()
	body.queue_free()
