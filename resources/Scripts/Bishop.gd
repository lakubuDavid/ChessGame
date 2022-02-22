extends "res://resources/Scripts/ChessPiece.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Bishops")
	pass # Replace with function body.

func check_possible_moves() -> Array:
	var possible_moves = []
	var k = 0
	#Down-Right
	for i in range(grid_position.x+1,8):
		k+=1
		if(is_valid_move(Vector2(i,grid_position.y + k))):
			possible_moves.append(Vector2(i,grid_position.y + k))
			if(not board.grid[i][grid_position.y+k] is int and not is_same_group(i,grid_position.y + k)):
				break
		else:
			break
	k = 0
	#Down-Left
	for i in range(grid_position.x+1,8):
		k+=1
		if(is_valid_move(Vector2(i,grid_position.y-k))):
			possible_moves.append(Vector2(i,grid_position.y - k))
			if(not board.grid[i][grid_position.y-k] is int and not is_same_group(i,grid_position.y - k)):
				break
		else:
			break
	k = 0
	var r = range(0,grid_position.x+1)
	var i = r.size() - 1
	#Up-Right
	while i >= 0:
		k+=1
		i -= 1
		#if((grid_position.y + k)>=0 and (grid_position.y + k)<8):
		if(is_valid_move(Vector2(i,grid_position.y + k))):
			possible_moves.append(Vector2(i,grid_position.y + k))
			if(not board.grid[i][grid_position.y+k] is int and not is_same_group(i,grid_position.y + k)):
				break
		else:
			break
	i = r.size() - 1
	k = 0
	#Up-Left
	while i >= 0:
		k+=1
		i -= 1
		#if((grid_position.y - k)>=0 and (grid_position.y - k)<8):
		if(is_valid_move(Vector2(i,grid_position.y - k))):
			possible_moves.append(Vector2(i,grid_position.y - k))
			if(not board.grid[i][grid_position.y-k] is int and not is_same_group(i,grid_position.y - k)):
				break
			else:
				break

	return possible_moves
	pass
