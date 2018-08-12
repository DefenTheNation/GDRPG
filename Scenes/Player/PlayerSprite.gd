extends AnimatedSprite

# Setup
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	animation = "down"

# Tick
func _process(delta):
	if Input.is_action_pressed("ui_right"):
		animation = "right"
		flip_h = false
	
	if Input.is_action_pressed("ui_left"):
		animation = "right"
		flip_h = true
	
	if Input.is_action_pressed("ui_up"):
		animation = "down"
	
	if Input.is_action_pressed("ui_down"):
		animation = "down"