extends Node2D

@onready var tilemap_solid: TileMapLayer = $TilemapSolid
@onready var tilemap_solid_shadow: TileMapLayer = $TilemapSolidShadow


func _ready() -> void:
	for cell in tilemap_solid.get_used_cells():
		var source_id := tilemap_solid.get_cell_source_id(cell)
		var atlas_coords := tilemap_solid.get_cell_atlas_coords(cell)
		
		tilemap_solid_shadow.set_cell(cell, source_id, atlas_coords)
