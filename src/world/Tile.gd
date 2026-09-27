extends Sprite2D
class_name Tile

var grid_pos: Vector2i:
	set(value):
		grid_pos = value
		global_position = Grid.map_to_world(grid_pos)

var _definition: TileDefinition

func _init(pos: Vector2i, def: TileDefinition) -> void:
	grid_pos = pos
	set_definition(def)

func set_definition(def: TileDefinition) -> void:
	_definition = def
	texture = def.texture

func _ready() -> void:
	y_sort_enabled = true

func collides(mask: int) -> bool:
	return (mask & _definition.collision_layer) > 0
