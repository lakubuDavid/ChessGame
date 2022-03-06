extends Control

var upgraded : bool = false
var final_piece : String
var final_group : String
var final_grid_position : Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func popup(grid_position,group):
	visible = true
	get_tree().paused = true
	final_group = group
	final_grid_position = grid_position
	pass

func _process(delta):
	if(upgraded):
		var final_piece_n = load("res://scenes/"+final_group+"/"+final_piece+".tscn").instance()
		final_piece_n.translation = Vector3(final_grid_position.y*2,0,final_grid_position.x*2)
		final_piece_n.grid_position = final_grid_position
		Game.board.grid[final_grid_position.x][final_grid_position.y].replace_by(final_piece_n)
		get_tree().paused = false
		visible = false
		upgraded = false
		queue_free()
		pass
	pass

func _on_btn_bishop_pressed():
	final_piece = "Bishop"
	upgraded = true
	pass # Replace with function body.


func _on_btn_knight_pressed():
	final_piece = "Knight"
	upgraded = true
	pass # Replace with function body.


func _on_btn_queen_pressed():
	final_piece = "Queen"
	upgraded = true
	pass # Replace with function body.


func _on_btn_rook_pressed():
	final_piece = "Rook"
	upgraded = true
	pass # Replace with function body.
