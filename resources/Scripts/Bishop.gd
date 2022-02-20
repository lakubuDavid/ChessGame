extends "res://resources/Scripts/ChessPiece.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func check_possible_moves() -> Array:
	var possible_moves = []
	var k = 0
	#Down-Right
	for i in range(grid_position.x+1,8):
		k+=1
		if(is_valid_move(Vector2(i,grid_position.y + k))):
			if(not board.grid[i][grid_position.y + k] is int):
				if(is_black):
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
				if(is_black):
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
				if(is_black):
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
				if(is_black):
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

	return possible_moves
	pass
