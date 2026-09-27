extends Node2D
class_name Grid

const tile_size: Vector2i = Vector2i(32,32)

var floors: Dictionary[Vector2i, Tile] = {}
var walls: Dictionary[Vector2i, Tile] = {}

var floor_node: Node2D
var wall_node: Node2D

func _ready() -> void:
	floor_node = Node2D.new()
	add_child(floor_node)
	wall_node = Node2D.new()
	add_child(wall_node)

func get_tile(pos: Vector2i) -> Tile:
	if walls[pos]:
		return walls[pos]
	else:
		if floors[pos]:
			return floors[pos]
	return  null
func get_tile_xy(x: int, y: int) -> Tile:
	return get_tile(Vector2i(x,y))

func set_tile(pos: Vector2i, def: TileDefinition) -> void:
	if def.is_wall:
		if pos in walls.keys():
			walls[pos].set_definition(def)
		else:
			walls[pos] = Tile.new(pos, def)
			wall_node.add_child(walls[pos])
	else:
		if pos in floors.keys():
			floors[pos].set_definition(def)
		else:
			floors[pos] = Tile.new(pos, def)
			floor_node.add_child(floors[pos])
func set_tile_xy(x: int, y: int, def: TileDefinition) -> void:
	set_tile(Vector2i(x,y), def)

func check_collision(pos: Vector2i, mask: int) -> bool:
	if pos in floors.keys():
		if floors[pos].collides(mask):
			return true
	if walls[pos]:
		if walls[pos].collides(mask):
			return true
	return false
func check_collision_xy(x: int, y: int, mask: int) -> bool:
	return check_collision(Vector2i(x,y), mask)

func load_tiles(region: Rect2i, tiles: Dictionary[Vector2i,TileDefinition]) -> void:
	for x in range(region.position.x, region.end.x):
		for y in range(region.position.y, region.end.y):
			if Vector2i(x,y) in tiles.keys():
				if tiles[Vector2i(x,y)]:
					set_tile_xy(x, y, tiles[Vector2i(x,y)])

func unload_tiles(region: Rect2i) -> void:
	for x in range(region.position.x, region.end.x):
		for y in range(region.position.y, region.end.y):
			if Vector2i(x,y) in floors.keys():
				floors[Vector2i(x,y)].queue_free()
				floors.erase(Vector2i(x,y))
			if Vector2i(x,y) in walls.keys():
				walls[Vector2i(x,y)].queue_free()
				walls.erase(Vector2i(x,y))

static func map_to_world(pos: Vector2i) -> Vector2:
	return pos * tile_size
