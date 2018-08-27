extends Node2D

var step = 50
var player_position

const player_x_offset = 0
const player_y_offset = -25

const INVALID = -1
const WATER = 0
const GRASS = 1
const MOUNTAIN = 2
const TOWN = 3

func _ready():
	player_position = Vector2(0, 0)
	
	center_player()
	center_world_on(player_position)
	
	$PlayerSprite.play()
	
	$DialogueBox.displayMessage("Welcome to Draconia! You are the next in line for succession. Do you have what it takes to become king?")

func center_player():
	var screen_size = get_viewport_rect().size
	
	$PlayerSprite.position.x = screen_size.x / 2 + player_x_offset
	$PlayerSprite.position.y = screen_size.y / 2 + player_y_offset

func center_world_on(map_vector):
	var screen_size = get_viewport_rect().size
	var screen_position = $TileMap.map_to_world(map_vector)
	
	var map_width = floor(screen_size.x / step)
	var map_height = floor(screen_size.y / step)
	
	var shift_width = floor(map_width / 2) - map_vector.x
	var shift_height = floor(map_height / 2) - map_vector.y
	
	$TileMap.move_local_x(shift_width * step)
	$TileMap.move_local_y(shift_height * step)
	

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
