extends CanvasLayer

signal start_game




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$EndMessage.hide()

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


func show_game_over(fatal_feature,good_feature,final_scope,final_completion):
	#show_message("Your game got too big!")
	#await $MessageTimer.timeout
	
	
	$EndMessage.text = "
		[font_size=30]YOUR GAME GOT [shake rate=20.0 level=8 connected=1]TOO BIG![/shake][/font_size]\n
		\n
		[font_size=20]Your project's scope increased to [color=#ff0000]" + str(final_scope * 10) + "[/color]%, but you only completed [color=#ff0000]" + str(final_completion) + "[/color]% of it. You failed to reach your deadline.\n
		I guess adding [color=#ff0000]" + fatal_feature + "[/color] was a bridge too far.\n
		Even [color=#00ff00]" + good_feature + "[/color] couldn't help you.\n
		
		
		[/font_size]
	"
	$EndMessage.show()
	
	
	#$Message.text = "Dodge the Scope Creep!"
	#$Message.show()
	
	
	
	#await get_tree().create_timer(1.0).timeout
	$StartButton.text = "Restart"
	$StartButton.show()


func show_victory(fatal_feature,good_feature,final_scope):
	#show_message("You shipped your game!")
	#await $MessageTimer.timeout
	#
	#$Message.text = "Dodge the Scope Creep!"
	#$Message.show()
	#
	#await get_tree().create_timer(1.0).timeout
	if final_scope < 10:
		$EndMessage.text = "
			[font_size=30][wave amp=50.0 freq=5.0 connected=1]YOU SHIPPED YOUR GAME![/wave][/font_size]\n
			\n
			[font_size=20]Not only did you complete your game in time, you reduced your scope to [color=#00FF00]" + str(final_scope * 10) + "[/color]%, which is wild because that [color=#00FF00]never happens[/color] in real life.\n
			[font_size=20]Even adding [color=#ff0000]" + fatal_feature + "[/color] couldn't slow you down.\n
			I guess [color=#00ff00]" + good_feature + "[/color] was a smart move.[/font_size]
		"
	else:
		$EndMessage.text = "
			[font_size=30][wave amp=50.0 freq=5.0 connected=1]YOU SHIPPED YOUR GAME![/wave][/font_size]\n
			\n
			[font_size=20]Despite increasing your project's scope to [color=#FF0000]" + str(final_scope * 10) + "[/color]%, you successfully [color=#00FF00]completed your game[/color] before the deadline.\n
			[font_size=20]Even adding [color=#ff0000]" + fatal_feature + "[/color] couldn't slow you down.\n
			I guess [color=#00ff00]" + good_feature + "[/color] was a smart move.[/font_size]
		"
	$EndMessage.show()
	$StartButton.text = "Restart"
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)
	
func update_pickups(total_pickups,game_completion):
	$ProgressBar.value = total_pickups
	$ProgressBar/CompletionLabel.text = "GAME COMPLETION: " + str(game_completion) + "%"

func update_size(max_scope):
	$ProgressBar.size.x = max_scope * 20
	$ProgressBar.max_value = max_scope

func update_size_label(max_scope):
	$ProgressBar/SizeLabel.text = "GAME SCOPE: " + str(max_scope * 10) + "%"

func update_scope_list(scope_list,item_color):
	if item_color == Color.RED:
		$PickupHistory.text += "\n" + "[color=#ff0000]" + scope_list[len(scope_list)-1] + "[/color]"
	elif item_color == Color.BLUE:
		$PickupHistory.text += "\n" + "[color=#00ff00]" + scope_list[len(scope_list)-1] + "[/color]"

func wipe_history():
	$PickupHistory.text = "DEVLOG"


func _on_start_button_pressed() -> void:
	$StartButton.hide()
	$StartButton.text = "Start"
	start_game.emit()
	
func _on_message_timer_timeout() -> void:
	$Message.hide()
	


func _on_start_game() -> void:
	pass # Replace with function body.
