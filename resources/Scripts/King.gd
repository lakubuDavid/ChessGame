extends "res://resources/Scripts/ChessPiece.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	is_king = true
	add_to_group("Kings")
	pass # Replace with function body.


func check_possible_moves() -> Array:
	var possible_moves = []
	
	if(is_valid_move(Vector2(grid_position.x+1,grid_position.y-1),true)):
		possible_moves.append(Vector2(grid_position.x+1,grid_position.y-1))
	if(is_valid_move(Vector2(grid_position.x+1,grid_position.y),true)):
		possible_moves.append(Vector2(grid_position.x+1,grid_position.y))
	if(is_valid_move(Vector2(grid_position.x+1,grid_position.y+1),true)):
		possible_moves.append(Vector2(grid_position.x+1,grid_position.y+1))
		
	if(is_valid_move(Vector2(grid_position.x,grid_position.y-1),true)):
		possible_moves.append(Vector2(grid_position.x,grid_position.y-1))	
	if(is_valid_move(Vector2(grid_position.x,grid_position.y+1),true)):
		possible_moves.append(Vector2(grid_position.x,grid_position.y+1))
		
	if(is_valid_move(Vector2(grid_position.x-1,grid_position.y-1),true)):
		possible_moves.append(Vector2(grid_position.x-1,grid_position.y-1))
	if(is_valid_move(Vector2(grid_position.x-1,grid_position.y),true)):
		possible_moves.append(Vector2(grid_position.x-1,grid_position.y))
	if(is_valid_move(Vector2(grid_position.x-1,grid_position.y+1),true)):
		possible_moves.append(Vector2(grid_position.x-1,grid_position.y+1))
		
	return possible_moves
