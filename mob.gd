extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types.pick_random()
	$AnimatedSprite2D.play()
	
	var scope_types = ["ROGUELIKE ELEMENTS",\
	"PROCEDURAL GENERATION",\
	"CO-OP MULTIPLAYER",\
	"OPEN WORLD",\
	"SKILL TREES",\
	"MULTIPLE ENDINGS",\
	"CRAFTING MECHANICS",\
	"BRANCHING PATHS",\
	"SECRET LEVELS",\
	"MICROTRANSACTIONS",\
	"STEALTH SECTIONS",\
	"CROSS-SAVES",\
	"METROIDVANIA DESIGN",\
	"DECKBUILDER",\
	"CUSTOM CHARACTERS",\
	"ADAPTIVE SOUNDTRACK",\
	"CHEMISTRY SYSTEMS",\
	"NEW GAME PLUS",\
	"BONUS MINIGAMES",\
	"BOSS RUSH",\
	"LOOT BOXES"]

	$ScopeTypeLabel.text = scope_types.pick_random()
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	
