extends Node2D

export (int) var GridWidth
export (int) var GridHeight
export (int) var BlockWidth
export (int) var BlockHeight

var step = 50
var player_position

const INVALID = -1
const WATER = 0
const GRASS = 1
const MOUNTAIN = 2
const TOWN = 3

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$PlayerSprite.play()
	
	player_position = Vector2(2, 1)
	
	var init_position = $TileMap.map_to_world(player_position)
	$PlayerSprite.position = init_position
	
	centerWorldOn(player_position)

func center_world_on(map_vector):
	var screen_size = get_viewport_rect().size
	var screen_position = $TileMap.map_to_world(map_vector)
	

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	if Input.is_action_just_pressed("ui_right"):
		if(!can_move(player_position.x + 1, player_position.y)):
			 return
		
		player_position.x += 1
		$TileMap.move_local_x(-1 * step)
		print(str(player_position.x) + " " + str(player_position.y))
		
	elif Input.is_action_just_pressed("ui_left"):
		if(!can_move(player_position.x - 1, player_position.y)):
			 return
		
		player_position.x -= 1
		$TileMap.move_local_x(step)
		print(str(player_position.x) + " " + str(player_position.y))
	
	elif Input.is_action_just_pressed("ui_up"):
		if(!can_move(player_position.x, player_position.y - 1)):
			 return
		
		player_position.y -= 1
		$TileMap.move_local_y(step)
		print(str(player_position.x) + " " + str(player_position.y))
	
	elif Input.is_action_just_pressed("ui_down"):
		if(!can_move(player_position.x, player_position.y + 1)):
			 return
		
		player_position.y += 1
		$TileMap.move_local_y(-1 * step)
		print(str(player_position.x) + " " + str(player_position.y))
	


func can_move(x,y):
	var cell = $TileMap.get_cell(x,y)
	
	match cell:
		INVALID:
			print("INVALID CELL - NO MOVEMENT ALLOWED")
			return false
		WATER:
			print("WATER IN WAY")
			return false
		MOUNTAIN:
			print("MOUNTAIN IN WAY")
			return false
		GRASS, TOWN:
			return true
		_:
			print("Unknown id: " + str(cell))
			return false
