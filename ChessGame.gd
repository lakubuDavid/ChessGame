extends Spatial

export(int,"Blacks","Whites") var whos_starting = 0

const BLACK_BISHOP = preload("res://scenes/Blacks/Bishop.tscn")
const BLACK_KING = preload("res://scenes/Blacks/King.tscn")
const BLACK_KNIGHT = preload("res://scenes/Blacks/Knight.tscn")
const BLACK_PAWN = preload("res://scenes/Blacks/Pawn.tscn")
const BLACK_QUEEN = preload("res://scenes/Blacks/Queen.tscn")
const BLACK_ROOK = preload("res://scenes/Blacks/Rook.tscn")

const WHITE_BISHOP = preload("res://scenes/Whites/Bishop.tscn")
const WHITE_KING = preload("res://scenes/Whites/King.tscn")
const WHITE_KNIGHT = preload("res://scenes/Whites/Knight.tscn")
const WHITE_PAWN = preload("res://scenes/Whites/Pawn.tscn")
const WHITE_QUEEN = preload("res://scenes/Whites/Queen.tscn")
const WHITE_ROOK = preload("res://scenes/Whites/Rook.tscn")

onready var camera : Camera = get_node("../Camera")
onready var pieces : Spatial = get_node("Pieces")
onready var tween : Tween = get_node("Tween")
onready var hud : Control = get_node("../HUD")

var ray_length = 1000
var tween_running : bool = false
var moving_piece : bool
var moving_piece_group : String = "Blacks"
var grid = []

var timer = 0

var last_focused_piece

# Called when the node enters the scene tree for the first time.
func _ready():
	if(whos_starting == 0):
		moving_piece_group = "Blacks"
	else:
		moving_piece_group = "Whites"

	for x in range(8):
		grid.append([])
		for y in range(8):
			grid[x].append([])
			grid[x][y] = 0
			
	setup_pieces()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_hud()
	update_lights()
	timer += delta
	if(Input.is_action_just_pressed("rotate") and not tween_running):
		rotate_board()
	if(Input.is_action_just_pressed("reset") and not tween_running):
		reset_board()
		pass
	pass

func _input(event):
	if(event is InputEventMouseButton and event.pressed):
		update_pieces()
		var m_pos = get_viewport().get_mouse_position()
		var from = camera.project_ray_origin(m_pos)
		var to = from + camera.project_ray_normal(m_pos) * ray_length
		var ray_res = get_world().direct_space_state.intersect_ray(from,to,[],1,true,true)
		if(ray_res != null and ray_res.has("collider")):
			var col = ray_res["collider"]
			if(col != null):
				if(moving_piece):
					if(col.is_in_group("PossibleMove")):
						if(last_focused_piece != null):
							moving_piece = false
							last_focused_piece.call("move",col.get_meta("possible_move"))
							if(moving_piece_group == "Whites"):
								moving_piece_group = "Blacks"
							else:
								moving_piece_group = "Whites"
							last_focused_piece.set("has_focus",false)
							last_focused_piece = null
					elif(col.is_in_group(moving_piece_group)):
						if(last_focused_piece != null):
							last_focused_piece.set("has_focus",false)
							col.set("has_focus",not col.get("has_focus"))
						moving_piece_group = col.get_groups()[0]
						last_focused_piece = col
						moving_piece = true
				elif(not moving_piece):
					if(col.is_in_group(moving_piece_group)):
						if(last_focused_piece != null):
							last_focused_piece.set("has_focus",false)
						col.set("has_focus",not col.get("has_focus"))
						moving_piece_group = col.get_groups()[0]
						last_focused_piece = col
						moving_piece = true


func update_pieces():
	for x in range(8):
		for y in range(8):
			if(not grid[x][y] is int):
				grid[x][y].set("board_grid",grid)
	pass

func update_hud():
	hud.get_node("debug_rect/label_whos_turn").text = moving_piece_group
	hud.get_node("label_timer").text = str(floor(timer/60.0))+":"+str(int(timer)%60)

func update_lights():
	if(moving_piece_group == "Blacks"):
		get_node("blacks_light").visible = true
		get_node("whites_light").visible = false
	else:
		get_node("blacks_light").visible = false
		get_node("whites_light").visible = true

func setup_pieces():
	grid[0][0] = WHITE_ROOK.instance()
	grid[0][0].grid_position = Vector2(0,0)
	pieces.add_child(grid[0][0])
	grid[0][0].translation = Vector3(0,0,0)
	grid[0][1] = WHITE_KNIGHT.instance()
	grid[0][1].grid_position = Vector2(0,1)
	pieces.add_child(grid[0][1])
	grid[0][1].translation = Vector3(2,0,0)
	grid[0][2] = WHITE_BISHOP.instance()	
	grid[0][2].grid_position = Vector2(0,2)
	pieces.add_child(grid[0][2])
	grid[0][2].translation = Vector3(4,0,0)
	grid[0][3] = WHITE_QUEEN.instance()
	grid[0][3].grid_position = Vector2(0,3)
	pieces.add_child(grid[0][3])
	grid[0][3].translation = Vector3(6,0,0)
	grid[0][4] = WHITE_KING.instance()
	grid[0][4].grid_position = Vector2(0,4)
	pieces.add_child(grid[0][4])
	grid[0][4].translation = Vector3(8,0,0)
	grid[0][5] = WHITE_BISHOP.instance()
	grid[0][5].grid_position = Vector2(0,5)
	pieces.add_child(grid[0][5])
	grid[0][5].translation = Vector3(10,0,0)
	grid[0][6] = WHITE_KNIGHT.instance()
	grid[0][6].grid_position = Vector2(0,6)
	pieces.add_child(grid[0][6])
	grid[0][6].translation = Vector3(12,0,0)
	grid[0][7] = WHITE_ROOK.instance()
	grid[0][7].grid_position = Vector2(0,7)
	pieces.add_child(grid[0][7])
	grid[0][7].translation = Vector3(14,0,0)
	
	for i in range(8):
		grid[1][i] = WHITE_PAWN.instance()
		grid[1][i].grid_position = Vector2(1,i)
		pieces.add_child(grid[1][i])
		grid[1][i].translation = Vector3(i*2,0,2)
	
	
	
	grid[7][0] = BLACK_ROOK.instance()
	grid[7][0].grid_position = Vector2(7,0)
	pieces.add_child(grid[7][0])
	grid[7][0].translation = Vector3(0,0,14)
	grid[7][1] = BLACK_KNIGHT.instance()
	grid[7][1].grid_position = Vector2(7,1)
	pieces.add_child(grid[7][1])
	grid[7][1].translation = Vector3(2,0,14)
	grid[7][2] = BLACK_BISHOP.instance()	
	grid[7][2].grid_position = Vector2(7,2)
	pieces.add_child(grid[7][2])
	grid[7][2].translation = Vector3(4,0,14)
	grid[7][3] = BLACK_QUEEN.instance()
	grid[7][3].grid_position = Vector2(7,3)
	pieces.add_child(grid[7][3])
	grid[7][3].translation = Vector3(6,0,14)
	grid[7][4] = BLACK_KING.instance()
	grid[7][4].grid_position = Vector2(7,4)
	pieces.add_child(grid[7][4])
	grid[7][4].translation = Vector3(8,0,14)
	grid[7][5] = BLACK_BISHOP.instance()
	grid[7][5].grid_position = Vector2(7,5)
	pieces.add_child(grid[7][5])
	grid[7][5].translation = Vector3(10,0,14)
	grid[7][6] = BLACK_KNIGHT.instance()
	grid[7][6].grid_position = Vector2(7,6)
	pieces.add_child(grid[7][6])
	grid[7][6].translation = Vector3(12,0,14)
	grid[7][7] = BLACK_ROOK.instance()
	grid[7][7].grid_position = Vector2(7,7)
	pieces.add_child(grid[7][7])
	grid[7][7].translation = Vector3(14,0,14)
	
	for i in range(8):
		grid[6][i] = BLACK_PAWN.instance()
		grid[6][i].grid_position = Vector2(6,i)
		pieces.add_child(grid[6][i])
		grid[6][i].translation = Vector3(i*2,0,12)
	
	pass

func rotate_board():
	tween.interpolate_property(self, "rotation_degrees",
	rotation_degrees, rotation_degrees + Vector3(0,180,0), 1,
	Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()
	tween_running = true
	yield(tween,"tween_completed")
	tween_running = false
	
func reset_board():
	timer = 0
	last_focused_piece = null
	moving_piece = false
	for c in pieces.get_children():
		c.get_parent().remove_child(c)
		c.queue_free()
	for x in range(8):
		for y in range(8):
			if(not grid[x][y] is int):
				grid[x][y] = 0
	yield(get_tree(),"idle_frame")
	setup_pieces()
