extends Generator
class_name Tunnel

@export
var wall: TileDefinition
@export
var ground: TileDefinition

@export
var min_width: int  = 2
@export
var max_width: int  = 6

@export_range(0, 1.0)
var drift: float = 0.9

@export
var min_paths: int = 2
@export
var max_paths: int = 5

func generate(region: Rect2i = full_region) -> GenerateResult:
	var result: GenerateResult = GenerateResult.new()
	result.region = region
	for x in range(region.position.x, region.end.x):
		for y in range(region.position.y, region.end.y):
			result.tiles[Vector2i(x,y)] = wall
	@warning_ignore("integer_division")
	var start_pos: Vector2i  = Vector2i(max_width, region.position.y + (region.size.y/2))
	@warning_ignore("integer_division")
	var end_pos: Vector2i  = Vector2i(region.end.x - max_width, region.position.y + (region.size.y/2))
	_carve_bubble(result, start_pos, min_width)
	_carve_bubble(result, end_pos, min_width)
	
	for a in range(0, randi_range(min_paths, max_paths)):
		var pos: Vector2i = start_pos
		var width: int = min_width
		for x in range(start_pos.x, end_pos.x, 1):
			pos.x = x
			if abs(end_pos.x - pos.x) > abs(end_pos.y - pos.y):
				pos.y = clamp(pos.y+randi_range(-1,1), region.position.y + (region.size.y * (1-drift)), region.position.y + (region.size.y * drift))
			else:
				pos.y += sign(end_pos.y - pos.y)
			width = clamp(width+randi_range(-1,1), min_width, max_width)
			_carve_bubble(result, pos, width)
			
	return result

func _carve_bubble(result: GenerateResult, pos: Vector2i, width: int) -> void:
	@warning_ignore("integer_division")
	var radius: int = width/2
	for x in range(-radius, +radius):
		for y in range(-radius, +radius):
			if ceil(Vector2(x,y).length()) <= radius:
				result.tiles[pos+Vector2i(x,y)] = ground
