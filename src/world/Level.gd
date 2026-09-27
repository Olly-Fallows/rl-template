extends Node2D
class_name Level

@export 
var generator: Generator
@export
var grid: Grid

func _ready() -> void:
	var result = generator.generate()
	grid.load_tiles(result.region, result.tiles)
