extends CanvasLayer

signal start_game




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var columns = ["A","B"]
	#var data = [
		#["blah",1],
		#["blah",1],
		#["blah",1],
		#["blah",1],
		#["blah",1]
	#]
	#
	#var df = DataFrame.New(data, columns)
	#print(df)# Replace with function body.
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

#func flash():
	#var fade_duration = 1.0
	#var tween = get_tree().create_tween()
	#
	#tween.tween_property($ProgressBar, "tint_under", Color.RED, fade_duration)
	#tween.tween_property($ProgressBar, "tint_under", Color.BLACK, fade_duration)



func show_game_over():
	show_message("Your game got too big!")
	await $MessageTimer.timeout
	
	$Message.text = "Dodge the Scope Creep!"
	$Message.show()
	
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

func show_victory():
	show_message("You shipped your game!")
	await $MessageTimer.timeout
	
	$Message.text = "Dodge the Scope Creep!"
	$Message.show()
	
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)
	
func update_pickups(total_pickups):
	#$PickupCounter.text = str(total_pickups)
	$ProgressBar.value = total_pickups

func update_size(max_scope):
	$ProgressBar.size.x = max_scope * 20
	$ProgressBar.max_value = max_scope

func update_size_label(max_scope):
	var game_size
	game_size = max_scope * 10
	$ProgressBar/SizeLabel.text = "Size: " + str(game_size) + "%"

func _on_start_button_pressed() -> void:
	$StartButton.hide()
	start_game.emit()
	
func _on_message_timer_timeout() -> void:
	$Message.hide()
	


func _on_start_game() -> void:
	pass # Replace with function body.
