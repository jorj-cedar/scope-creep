extends Node

@export var mob_scene: PackedScene
@export var pickup_scene: PackedScene
@export var game_msg_scene: PackedScene
@export var goodmob_scene: PackedScene

var score
var total_pickups: int = 0
var max_scope: int = 10
var game_completion: int = 0
var fullness: int = 0

var scope_list = []
var good_list = []
var bad_list = []

var fatal_feature
var good_feature

var green = Color(0,1,0,1)
var red = Color(1,0,0,1)
	
@onready var pickup_sounds =[
		preload("res://sound/PickingUp1.mp3"),
		preload("res://sound/PickingUp2.mp3"),
		preload("res://sound/PickingUp3.mp3")
]
@onready var hitenemy_sounds =[
	preload("res://sound/damage1.mp3"),
	preload("res://sound/Damage2.mp3"),
	preload("res://sound/negativepickup.mp3")
]

@onready var goodmob_sounds =[
	preload("res://sound/positivepickup1.mp3"),
	preload("res://sound/positivepickup2.mp3"),
	preload("res://sound/positivepickup3.mp3"),
	preload("res://sound/positivepickup4.mp3"),
	preload("res://sound/positivepickup5.mp3"),
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	$MenuMusic.play()
	

	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func game_over() -> void:
	$MenuMusic.play()
	$GameMusic.stop()
	$DeathSound.play()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$PickupTimer.stop()
	if len(bad_list) == 0:
		fatal_feature = "ZERO SCOPE CREEP"
	else:
		fatal_feature = bad_list[len(bad_list)-1]
		
	if len(good_list) == 0:
		good_feature = "DOING NO WORK AT ALL"
	else:
		good_feature = good_list[len(good_list)-1]
	$HUD.show_game_over(fatal_feature,good_feature,max_scope,game_completion)
	get_tree().call_group("mobs", "queue_free")
	get_tree().call_group("pickups", "queue_free")
	get_tree().call_group("goodmobs", "queue_free")
	$Player.hide()
	$Player/CollisionShape2D.set_deferred("disabled", true)
	
func victory():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$PickupTimer.stop()
	if len(bad_list) == 0:
		fatal_feature = "ZERO SCOPE CREEP"
	else:
		fatal_feature = bad_list[len(bad_list)-1]
		
	if len(good_list) == 0:
		good_feature = "DOING NO WORK AT ALL"
	else:
		good_feature = good_list[len(good_list)-1]
	$HUD.show_victory(fatal_feature,good_feature,max_scope)
	get_tree().call_group("mobs", "queue_free")
	get_tree().call_group("pickups", "queue_free")
	get_tree().call_group("goodmobs", "queue_free")
	$Player.hide()
	$Player/CollisionShape2D.set_deferred("disabled", true)

func new_game():
	$MenuMusic.stop()
	$GameMusic.play()
	$StartSound.play()
	score = 30
	total_pickups = 0
	max_scope = 10
	game_completion = 0
	fullness = 0
	scope_list = []
	good_list = []
	bad_list = []
	
	$Player.speed = 400
	$Player.scale.x = 1
	$Player.scale.y = 1
	
	$Player.start($StartPosition.position)
	$Player/CollisionShape2D.set_deferred("disabled", false)
	$StartTimer.start()
	$PickupTimer.start()
	$GoodTimer.start()
	$MobTimer.start()
	$HUD/EndMessage.hide()
	$HUD.wipe_history()
	$HUD.update_score(score)
	$HUD.update_pickups(total_pickups,game_completion)
	$HUD.update_size(max_scope)
	$HUD.show_message("Reach your deadline!")
	$HUD/ProgressBar.flash(false)
	$HUD/ProgressBar/AlmostDead.visible = false
	
	get_tree().call_group("mobs", "queue_free")
	get_tree().call_group("goodmobs", "queue_free")
	get_tree().call_group("pickups", "queue_free")

func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	mob.position = mob_spawn_location.position
	
	var direction = mob_spawn_location.rotation + PI / 2
	
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(100.0, 300.0,), 0.0)
	
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)
	

func show_msg(player_position, message, msg_color):
	var game_msg = game_msg_scene.instantiate()
	game_msg.text = message
	game_msg.position = player_position
	game_msg.set("theme_override_colors/font_color",msg_color)
	
	add_child(game_msg)


func _on_score_timer_timeout() -> void:
	score -= 1
	$HUD.update_score(score)
	
	if score == 0:
		game_over()
		
		

func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
	$PickupTimer.start()
	$GoodTimer.start()


func _on_pickup_timer_timeout() -> void:
	var pickup = pickup_scene.instantiate()
	
	var screen_size = get_viewport().size
	
	pickup.position = Vector2(screen_size.x * randf(), screen_size.y * randf())

	pickup.rotation = randf() * TAU
	
	add_child(pickup)

func _on_good_timer_timeout() -> void:
	var goodmob = goodmob_scene.instantiate()
	
	var goodmob_spawn_location = $MobPath/MobSpawnLocation
	goodmob_spawn_location.progress_ratio = randf()
	goodmob.position = goodmob_spawn_location.position
	
	var direction = goodmob_spawn_location.rotation + PI / 2
	
	direction += randf_range(-PI / 4, PI / 4)
	goodmob.rotation = direction
	
	var velocity = Vector2(randf_range(100.0, 300.0,), 0.0)
	
	goodmob.linear_velocity = velocity.rotated(direction)
	
	add_child(goodmob)

func update_completion():
	game_completion = (float(total_pickups) / max_scope) * 100
	
	if game_completion <= 30:
		fullness = 0
	elif game_completion > 30 and game_completion < 65:
		fullness = 1
	elif game_completion >= 65:
		fullness = 2	
	$Player.update_sprite(fullness)

func _on_player_pickup() -> void:
	
	var random_sound = pickup_sounds.pick_random()
	$PickUpSound.stream = random_sound
	$PickUpSound.play()

	total_pickups += 2
	update_completion()
	
	$HUD.update_pickups(total_pickups,game_completion)
	show_msg($Player.position,"COMPLETION UP!",green)
	if total_pickups >= max_scope:
		victory()
		


func _on_player_embiggen() -> void:
	var random_sound = hitenemy_sounds.pick_random()
	$HitEnemySound.stream = random_sound
	$HitEnemySound.play()
	max_scope += 1
	update_completion()
	
	if $Player.speed <= 75:
		game_over()
	else:
		$Player.speed -= 50
	
	$Player.scale.x += 0.25
	$Player.scale.y += 0.25
	$HUD.update_size(max_scope)
	$HUD.update_size_label(max_scope)
	$HUD.update_pickups(total_pickups,game_completion)
	show_msg($Player.position,"SCOPE INCREASED!",red)
	if max_scope == 14:
		$HUD/ProgressBar.flash(true)
		
func _on_player_shrink() -> void:
	var random_sound = goodmob_sounds.pick_random()
	$GoodMobSound.stream = random_sound
	$GoodMobSound.play()
	
	max_scope -= 1
	$Player.speed += 50
	$Player.scale.x -= 0.25
	$Player.scale.y -= 0.25
	$HUD.update_size(max_scope)
	$HUD.update_size_label(max_scope)
	update_completion()
	$HUD.update_pickups(total_pickups,game_completion)
	show_msg($Player.position,"SCOPE DECREASED!",Color.BLUE)
	
	if max_scope <= total_pickups:
		victory()


func _on_player_add_scope(scope_name,item_color) -> void:
	scope_list.append(scope_name)
	if item_color == Color.RED:
		bad_list.append(scope_name)
	elif item_color == Color.BLUE:
		good_list.append(scope_name)
	$HUD.update_scope_list(scope_list,item_color)
	
