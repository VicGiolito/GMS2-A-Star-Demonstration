

function scr_define_grids_from_tilemap(){
	
	var tile_lay_id = layer_tilemap_get_id(layer_get_id("tiles_32"));
	
	var grid_w = ds_grid_width(global.map_grid), grid_h = ds_grid_height(global.map_grid);
	
	var tile_val;
	
	for(var xx = 0; xx < grid_w; xx++) {
		for(var yy = 0; yy < grid_h; yy++) {
			
			tile_val = tilemap_get(tile_lay_id,xx,yy);
			
			if tile_val == grid_cell.wall { global.map_grid[# xx,yy] = grid_cell.wall; global.terrain_grid[# xx,yy] = UNVISITED_STEP_VAL; } 
			
			else if tile_val == grid_cell.forest global.terrain_grid[# xx,yy] = TERRAIN_VAL_FOREST;
			else if tile_val == grid_cell.swamp global.terrain_grid[# xx,yy] = TERRAIN_VAL_SWAMP;
			else if tile_val == grid_cell.road global.terrain_grid[# xx,yy] = TERRAIN_VAL_ROAD;
			else if tile_val == grid_cell.plains global.terrain_grid[# xx,yy] = TERRAIN_VAL_PLAINS;
			else if tile_val == grid_cell.mountain global.terrain_grid[# xx,yy] = TERRAIN_VAL_MOUNTAIN;
		}
	}
}