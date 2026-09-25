extends Node2D
class_name Grid

var floor: Dictionary[Vector2i, TileDefinition] = {}
var walls: Dictionary[Vector2i, TileDefinition] = {}

func get_tile(pos: Vector2i) -> TileDefinition:
	if walls[pos]:
		return walls[pos]
	else:
		if walls[pos]:
			return walls[pos]
	return  null
func get_tile_xy(x: int, y: int) -> TileDefinition:
	return get_tile(Vector2i(x,y))

func set_tile(pos: Vector2i, def: TileDefinition) -> void:
	if def.is_wall:
		walls[pos] = def
	else:
		floor[pos] = def
func set_tile_xy(x: int, y: int, def: TileDefinition) -> void:
	set_tile(Vector2i(x,y), def)

func check_collision(pos: Vector2i, mask: int) -> bool:
	return false
func check_collision_xy(x: int, y: int, mask: int) -> bool:
	return false

func load_tiles(region: Rect2i, tiles: Array[TileDefinition]) -> void:
	pass
func unload_tiles(region: Rect2i) -> void:
	pass
