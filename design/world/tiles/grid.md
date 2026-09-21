# Grid

Tiles are not nodes.
Tiles contained within and handled by a single Grid node.

The Grid node keeps multiple (e.g. floor, walls) dictionaries of tiles. grid_position -> tile_definition
Use of a dictionary allows for un-used tiles to be unloaded and new needed tiles to be loaded without risk of over writing needed tiles.
Basically to support chunk streaming

## Responsibilies
- Renders tiles
- Is Interface for collision checks with tiles
- Is Interface for changing and interacting with tiles

## Methods
- get_tile(pos: Vector2i)
- get_tile_xy(x: int, y: int)

- set_tile(pos: Vector2i, def: TileDefinition)
- set_tile_xy(x: int, y: int, def: TileDefinition)

- check_collision(pos: Vector2i, mask: int)
- check_collision(x: int, y: int, mask: int)

- load_tiles(region: Rect2i, tiles: Array\[TileDefinition\])
- unload_tiles(region: Rect2i)
