extends "res://resources/Scripts/ChessPiece.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func check_possible_moves() -> Array:
	var possible_moves = []
##	Diagonal moves
	var k = 0
	#Down-Right
	for i in range(grid_position.x+1,8):
		k+=1
		if(is_valid_move(Vector2(i,grid_position.y + k))):
			if(not board.grid[i][grid_position.y + k] is int):
				if(get_groups()[0] == "Blacks"):
					if(board.grid[i][grid_position.y + k].is_in_group("Whites")):
						possible_moves.append(Vector2(i,grid_position.y + k))
						break
					else:
						break
				else:
					if(board.grid[i][grid_position.y + k].is_in_group("Blacks")):
						possible_moves.append(Vector2(i,grid_position.y + k))
						break
					else:
						break
			possible_moves.append(Vector2(i,grid_position.y + k))
		else:
			break
	k = 0
	#Down-Left
	for i in range(grid_position.x+1,8):
		k+=1
		if(is_valid_move(Vector2(i,grid_position.y-k))):
			if(not board.grid[i][grid_position.y - k] is int):
				if(get_groups()[0] == "Blacks"):
					if(board.grid[i][grid_position.y - k].is_in_group("Whites")):
						possible_moves.append(Vector2(i,grid_position.y - k))
						break
					else:
						break
				else:
					if(board.grid[i][grid_position.y - k].is_in_group("Blacks")):
						possible_moves.append(Vector2(i,grid_position.y - k))
						break
					else:
						break
			possible_moves.append(Vector2(i,grid_position.y - k))
		else:
			break
	k = 0
	var r = range(0,grid_position.x+1)
	var i = r.size() - 1
	#Up-Right
	while i >= 0:
		k+=1
		i -= 1
		if((grid_position.y + k)>=0 and (grid_position.y + k)<8):
			if(not board.grid[i][grid_position.y + k] is int):
				if(get_groups()[0] == "Blacks"):
					if(board.grid[i][grid_position.y + k].is_in_group("Whites")):
						possible_moves.append(Vector2(i,grid_position.y + k))
						break
					else:
						break
				else:
					if(board.grid[i][grid_position.y + k].is_in_group("Blacks")):
						possible_moves.append(Vector2(i,grid_position.y + k))
						break
					else:
						break
			possible_moves.append(Vector2(i,grid_position.y + k))
	i = r.size() - 1
	k = 0
	#Up-Left
	while i >= 0:
		k+=1
		i -= 1
		if((grid_position.y - k)>=0 and (grid_position.y - k)<8):
			if(not board.grid[i][grid_position.y - k] is int):
				if(get_groups()[0] == "Blacks"):
					if(board.grid[i][grid_position.y - k].is_in_group("Whites")):
						possible_moves.append(Vector2(i,grid_position.y - k))
						break
					else:
						break
				else:
					if(board.grid[i][grid_position.y - k].is_in_group("Blacks")):
						possible_moves.append(Vector2(i,grid_position.y - k))
						break
					else:
						break
			possible_moves.append(Vector2(i,grid_position.y - k))

## Perpendicular moves
	for j in range(grid_position.x,8):
		if(j == grid_position.x):
			continue
		if(not is_valid_move(Vector2(j,grid_position.y))):
			break
		possible_moves.append(Vector2(j,grid_position.y))
		if(j<7 and (!board.grid[j+1][grid_position.y] is int) and !is_same_group(j+1,grid_position.y)):
			possible_moves.append(Vector2(j+1,grid_position.y))
			break
	for j in range(grid_position.y,8):
		if(j == grid_position.y):
			continue
		if(not is_valid_move(Vector2(grid_position.x,j))):
			break
		possible_moves.append(Vector2(grid_position.x,j))
		if(j<7 and (!board.grid[grid_position.x][j+1] is int) and !is_same_group(grid_position.x,j+1)):
			possible_moves.append(Vector2(grid_position.x,j+1))
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
