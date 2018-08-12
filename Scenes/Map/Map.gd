extends GridContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var grass

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	columns = 10
	
	grass = preload("res://Scenes/Map/GrassSprite.tscn")
	
	for i in range(0,100):
		add_child(grass.instance())
	
	print(get_child_count())


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
