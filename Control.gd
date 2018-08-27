extends Control

export (String) var FullMessage
export (int) var MessageSpeed

enum MESSAGE {
	Displaying,
	AwaitingInput,
	Closing,
	Closed
}

var state
var count
var totalDelta
var threshold


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	state = MESSAGE.Closed
	totalDelta = 0
	count = 0
	
	
	
	threshold = 0.08 / MessageSpeed
	
	pass

func displayMessage(var message):
	FullMessage = message
	$ColorRect/Label.text = FullMessage
	$ColorRect/Label.visible_characters = 0
	
	show()
	
	state = MESSAGE.Displaying

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	totalDelta += delta
	
	match state:
		MESSAGE.Displaying:
			if(totalDelta > threshold):
				if(count < FullMessage.length()):
					$ColorRect/Label.visible_characters += 1
					count += 1
				else:
					state = AwaitingInput
					count = 0
				totalDelta = 0
		_:
			if(Input.is_action_just_pressed("ui_accept")):
				state = MESSAGE.Closed
				count = 0
				totalDelta = 0
				$ColorRect/Label.visible_characters = 0
				hide()
	
