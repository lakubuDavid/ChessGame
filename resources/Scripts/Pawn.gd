extends "res://resources/Scripts/ChessPiece.gd"

onready var upgrade_menu = preload("res://scenes/UpgardePawnMenu.tscn").instance()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var first_move : bool 

# Called when the node enters the scene tree for the first time.
func _ready():
	first_move = true
	connect("moved",self,"when_moved")
	pass # Replace with function body.

func when_moved():
	if(is_black):
		if(grid_position.x == 0):
			upgrade_pawn()
	else:
		if(grid_position.x == 7):
			upgrade_pawn()
	first_move =false

func upgrade_pawn():
	upgrade_menu.visible = false
	hud.add_child(upgrade_menu)
	upgrade_menu.popup(grid_position,get_groups()[0])
	pass

func check_possible_moves() -> Array:
	var possible_moves = []
	if(is_black):
		if(board.grid[grid_position.x-1][grid_position.y] is int):
			possible_moves.append(Vector2(grid_position.x-1,grid_position.y))
		
		if(grid_position.y >=0 and (not board.grid[grid_position.x-1][grid_position.y-1] is int) and !is_same_group(grid_position.x-1,grid_position.y-1)):
			possible_moves.append(Vector2(grid_position.x-1,grid_position.y-1))
		if(grid_position.y <7 and (not board.grid[grid_position.x-1][grid_position.y+1] is int) and !is_same_group(grid_position.x-1,grid_position.y+1)):
			possible_moves.append(Vector2(grid_position.x-1,grid_position.y+1))
	else:
		if(board.grid[grid_position.x+1][grid_position.y] is int):
			possible_moves.append(Vector2(grid_position.x+1,grid_position.y))

		if(grid_position.y >= 0 and (not board.grid[grid_position.x+1][grid_position.y-1] is int) and !is_same_group(grid_position.x+1,grid_position.y-1)):
			possible_moves.append(Vector2(grid_position.x+1,grid_position.y-1))
		if(grid_position.y < 7 and (not board.grid[grid_position.x+1][grid_position.y+1] is int) and !is_same_group(grid_position.x+1,grid_position.y+1)):
			possible_moves.append(Vector2(grid_position.x+1,grid_position.y+1))
	
	if(first_move):
		if(is_black):
			if(board.grid[grid_position.x-1][grid_position.y] is int and board.grid[grid_position.x-2][grid_position.y] is int):
				possible_moves.append(Vector2(grid_position.x-2,grid_position.y))
		else:
			if(board.grid[grid_position.x+1][grid_position.y] is int and board.grid[grid_position.x+2][grid_position.y] is int):
				possible_moves.append(Vector2(grid_position.x+2,grid_position.y))
	return possible_moves
