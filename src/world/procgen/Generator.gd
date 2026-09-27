@abstract
extends Resource
class_name Generator

@export
var full_region: Rect2i

@abstract
func generate(region: Rect2i = full_region) -> GenerateResult

class GenerateResult:
	var region: Rect2i
	var tiles: Dictionary[Vector2i, TileDefinition]
	var entities: Array
