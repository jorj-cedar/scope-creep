extends Node

@export var mob_scene: PackedScene
@export var pickup_scene: PackedScene
@export var game_msg_scene: PackedScene

var score
var total_pickups: int = 0
var max_scope: int = 10
var death_scope: int = 15

var green = Color(0,1,0,1)
var red = Color(1,0,0,1)
	

	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$PickupTimer.stop()
	$HUD.show_game_over()
	
func victory():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$PickupTimer.stop()
	$HUD.show_victory()
	get_tree().call_group("mobs", "queue_free")

func new_game():
	score = 30
	total_pickups = 0
	max_scope = 10
	
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$PickupTimer.start()
	$HUD.update_score(score)
	$HUD.update_pickups(total_pickups)
	$HUD.update_size(max_scope)
	$HUD.show_message("Reach your deadline!")
	$HUD/ProgressBar/AlmostDead.visible = false
	
	get_tree().call_group("mobs", "queue_free")
	get_tree().call_group("pickups", "queue_free")

func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	mob.position = mob_spawn_location.position
	
	var direction = mob_spawn_location.rotation + PI / 2
	
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0,), 0.0)
	
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)
	
#func scope_increased_msg(player_position):
	#var scope_msg = scope_msg_scene.instantiate()
	#
	#scope_msg.position = player_position
	#
	#add_child(scope_msg)

func show_msg(player_position, message, msg_color):
	var show_msg = game_msg_scene.instantiate()
	show_msg.text = message
	show_msg.position = player_position
	show_msg.set("theme_override_colors/font_color",msg_color)
	
	add_child(show_msg)


func _on_score_timer_timeout() -> void:
	score -= 1
	$HUD.update_score(score)
	
	if score == 0:
		game_over()
		
		

func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
	$PickupTimer.start()
	


func _on_pickup_timer_timeout() -> void:
	var pickup = pickup_scene.instantiate()
	
	var pickup_spawn_location = $MobPath/MobSpawnLocation
	pickup_spawn_location.progress_ratio = randf()
	pickup.position = pickup_spawn_location.position
	
	var direction = pickup_spawn_location.rotation + PI / 2
	
	direction += randf_range(-PI / 4, PI / 4)
	pickup.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0,), 0.0)
	
	pickup.linear_velocity = velocity.rotated(direction)
	
	add_child(pickup)


func _on_player_pickup() -> void:
	total_pickups += 1
	$HUD.update_pickups(total_pickups)
	show_msg($Player.position,"COMPLETION UP!",green)
	if total_pickups == max_scope:
		victory()
		


func _on_player_embiggen() -> void:
	max_scope += 1
	$HUD.update_size(max_scope)
	show_msg($Player.position,"SCOPE INCREASED!",red)
	if max_scope >= death_scope - 2:
		$HUD/ProgressBar/AlmostDead.visible = true
		$HUD/ProgressBar.flash()
		
	elif max_scope == death_scope:
		game_over()
		
