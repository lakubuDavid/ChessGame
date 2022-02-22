extends Area


signal moved
signal killed

onready var SelectedPieceMat : SpatialMaterial = preload("res://resources/Materials/SelectedPieceMat.tres")
onready var PossibleTargetMoveMat : SpatialMaterial = preload("res://resources/Materials/PossibleTargetMoveMat.tres")
onready var MoveSfx : AudioStream = preload("res://resources/Audio/Sfx/Minimalist7.wav")
onready var EatingTargetMoveMat : SpatialMaterial = preload("res://resources/Materials/EatingTargetMoveMat.tres")
onready var hud : Control = get_node("../../../HUD")
onready var board = get_node("../..")

var move_sfx : AudioStreamPlayer
var is_king : bool
var move_indicators : Array = []
var grid_position : Vector2
var indicator : MeshInstance
var tween : Tween
var tween2 : Tween
var tween_running : bool = false
var has_focus : bool = false setget set_focus,get_has_focus
# Called when the node enters the scene tree for the first time.
func _ready(): 
	tween = Tween.new()
	tween2 = Tween.new()
	indicator = MeshInstance.new()
	indicator.translation.y = 0.001
	indicator.mesh = PlaneMesh.new()
	indicator.mesh.size = Vector2(2,2)
	indicator.material_override = SelectedPieceMat
	indicator.visible = false

	move_sfx = AudioStreamPlayer.new()
	move_sfx.stream = MoveSfx
	
	add_child(tween)
	add_child(tween2)
	add_child(indicator)
	add_child(move_sfx)
	
	pass # Replace with function body.

func set_focus(value):
	has_focus = value
	indicator.visible = has_focus
	if (has_focus):
		hud.get_node("debug_rect/label_grid_position").text = "Grid position : "+str(grid_position)
		var p_moves : Array = check_possible_moves()
		for i in range(p_moves.size()):
			var indicator_mesh = MeshInstance.new()
			indicator_mesh.mesh = PlaneMesh.new()
			indicator_mesh.mesh.size = Vector2(2.0,2.0)
			if(is_killing_move(Vector2(p_moves[i].x,p_moves[i].y))):
				indicator_mesh.material_override = EatingTargetMoveMat
			else:
				indicator_mesh.material_override = PossibleTargetMoveMat
			indicator_mesh.visible = true
			
			var move_indicator = Area.new()
			move_indicator.set_meta("possible_move",p_moves[i])
			
			move_indicator.add_to_group("PossibleMove")
			move_indicator.translation = Vector3(p_moves[i].y*2,0,p_moves[i].x*2)
			
			var collision_shape = CollisionShape.new()
			collision_shape.shape = BoxShape.new()
			collision_shape.shape.extents = Vector3(1,.25,1)
			
			move_indicator.add_child(collision_shape)
			move_indicator.add_child(indicator_mesh)
			
			get_parent().add_child(move_indicator)
			
			move_indicators.append(move_indicator)
	else:
		for i in range(move_indicators.size()):
			if(move_indicators[i] != null):
				move_indicators[i].set("visible",false)
				move_indicators[i].queue_free()
				
		move_indicators.clear()
		pass
		pass
		
func is_same_group(x,y):
	if(x>=8 or x<0 or y>=8 or y<0):
		print_debug("Invalid move ("+str(x)+";"+str(y)+")")
		return false
	return ((not board.grid[x][y] is int) and board.grid[x][y].is_in_group(get_groups()[0]))
	
func get_has_focus():
	return has_focus

func move(target_position : Vector2):
	board.grid[grid_position.x][grid_position.y] = 0
	if(is_king):
		tween.interpolate_property(self, "translation",
		translation,Vector3(target_position.y*2,0,target_position.x*2), 1,
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		tween.start()
		tween_running = true
		var final_case = board.grid[target_position.x][target_position.y]
		if(not final_case is int):
			if(is_same_group(target_position.x,target_position.y)):
				final_case.call("move",grid_position)
			else:
				final_case.call("die")
		
		emit_signal("moved")

		board.grid[target_position.x][target_position.y] = self
		hud.get_node("debug_rect/label_last_move").text = "Move : from:"+str(grid_position)+" to:"+str(target_position)
		grid_position = target_position
	else:
		if(not tween_running):
			tween.interpolate_property(self, "translation",
			translation,Vector3(target_position.y*2,0,target_position.x*2), 1,
			Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
			tween.start()
			tween_running = true
			var final_case = board.grid[target_position.x][target_position.y]
			if(not final_case is int):
				if(not is_same_group(target_position.x,target_position.y)):
					final_case.call("die") 
			board.grid[target_position.x][target_position.y] = self
			hud.get_node("debug_rect/label_last_move").text = "Move : from:"+str(grid_position)+" to:"+str(target_position)
			grid_position = target_position
			emit_signal("moved")
			board.move_sfx.play()
			yield(tween,"tween_completed")
		tween_running = false
	
func check_possible_moves() -> Array :
	var possible_moves = []
	return possible_moves

func die():
	emit_signal("killed")
	board.grid[grid_position.x][grid_position.y] = 0
	get_parent().remove_child(self)
	tween.interpolate_property(self, "scale",scale,Vector3(0,0,0), 1,Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()
	tween_running = true
	tween.connect("tween_completed",tween,"queue_free")
	board.kill_sfx.play()
	yield(tween,"tween_completed")
	tween_running = false
	pass
	
func is_killing_move(move : Vector2):
	return not board.grid[move.x][move.y] is int and is_valid_move(move)
		
func is_valid_move(move : Vector2,is_king : bool = false):
	if(is_king):
		return (not is_same_group(move.x,move.y) or (board.grid[move.x][move.y].get_groups()[1]== "Rooks")) and (move.x >=0 and move.x <8 and move.y >=0 and move.y <8)
	else:
		return (not is_same_group(move.x,move.y)) and (move.x >=0 and move.x <8 and move.y >=0 and move.y <8)
