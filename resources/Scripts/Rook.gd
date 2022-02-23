extends "res://resources/Scripts/ChessPiece.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Rooks")
	pass # Replace with function body.


func check_possible_moves() -> Array:
	var possible_moves = []
	#Move right
	for i in range(grid_position.x,8):
		if(i == grid_position.x):
			continue
		if(not is_valid_move(Vector2(i,grid_position.y))):
			break
		possible_moves.append(Vector2(i,grid_position.y))
		if(i<7 and (!board.grid[i+1][grid_position.y] is int) and !is_same_group(i+1,grid_position.y)):
			possible_moves.append(Vector2(i+1,grid_position.y))
			break
	#Move down
	for i in range(grid_position.y,8):
		if(i == grid_position.y):
			continue
		if(not is_valid_move(Vector2(grid_position.x,i))):
			break
		possible_moves.append(Vector2(grid_position.x,i))
		if(i<7 and (!board.grid[grid_position.x][i+1] is int) and !is_same_group(grid_position.x,i+1)):
			possible_moves.append(Vector2(grid_position.x,i+1))
			break
	
	var h = range(0,grid_position.x).size()
	var v = range(0,grid_position.y).size()
	#Move left
	while(h>=0):
		if(h == grid_position.x):
			h-=1
			continue
		if(not is_valid_move(Vector2(h,grid_position.y))):
			break
		possible_moves.append(Vector2(h,grid_position.y))
		if(h>0 and (not board.grid[h-1][grid_position.y] is int and !is_same_group(h-1,grid_position.y))):
			possible_moves.append(Vector2(h-1,grid_position.y))
			break
		h-=1
	#Move Up
	while(v>=0):
		if(v == grid_position.y):
			v-=1
			continue
		if(not is_valid_move(Vector2(grid_position.x,v))):
			break

		possible_moves.append(Vector2(grid_position.x,v))
		if(v>0 and (not board.grid[grid_position.x][v-1] is int and !is_same_group(grid_position.x,v-1))):
			possible_moves.append(Vector2(grid_position.x,v-1))
			break
		v-=1

	return possible_moves
	pass
