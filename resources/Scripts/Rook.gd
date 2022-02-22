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
	for i in range(grid_position.x,8):
		if(i == grid_position.x):
			continue
		if(not is_valid_move(Vector2(i,grid_position.y))):
			break
		possible_moves.append(Vector2(i,grid_position.y))
		if(i<7 and (!board.grid[i+1][grid_position.y] is int) and !is_same_group(i+1,grid_position.y)):
			possible_moves.append(Vector2(i+1,grid_position.y))
			break
	for i in range(grid_position.y,8):
		if(i == grid_position.y):
			continue
		if(not is_valid_move(Vector2(grid_position.x,i))):
			break
		possible_moves.append(Vector2(grid_position.x,i))
		if(i<7 and (!board.grid[grid_position.x][i+1] is int) and !is_same_group(grid_position.x,i+1)):
			possible_moves.append(Vector2(grid_position.x,i+1))
			break
	var l = range(0,grid_position.x).size()
	var m = range(0,grid_position.y).size()
	while(l>=0):
		if(l == grid_position.x):
			l-=1
			continue
		if(not is_valid_move(Vector2(l,grid_position.y))):
			break
		possible_moves.append(Vector2(l,grid_position.y))
		if(l>0 and (not board.grid[l-1][grid_position.y] is int and !is_same_group(l-1,grid_position.y))):
			possible_moves.append(Vector2(l-1,grid_position.y))
			break
		l-=1
	while(m>=0):
		if(m == grid_position.y):
			m-=1
			continue
		if(not is_valid_move(Vector2(grid_position.x,m))):
			break

		possible_moves.append(Vector2(grid_position.x,m))
		if(m>0 and (not board.grid[grid_position.x][m-1] is int and !is_same_group(grid_position.x,m-1))):
			possible_moves.append(Vector2(grid_position.x,m-1))
			break
		m-=1

	return possible_moves
	pass
