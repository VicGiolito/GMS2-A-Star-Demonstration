

function scr_randomize_grid(){
	
	var tile_lay_id = layer_tilemap_get_id(layer_get_id("tiles_32"));
	
	var grid_w = ds_grid_width(global.map_grid), grid_h = ds_grid_height(global.map_grid);
	
	var ran_val;
	for(var xx = 0; xx < grid_w; xx++) {
		for(var yy = 0; yy < grid_h; yy++) {
			
			ran_val = choose(grid_cell.wall,grid_cell.plains);
			
			global.map_grid[# xx,yy] = ran_val;
				
			if tilemap_set(tile_lay_id,ran_val,xx,yy) {
					
			} else {
				show_debug_message($"scr_randomize_grid: at grid cell xx {xx}, yy {yy}, failed to set tilemap layer.");	
			}
			
		}
	}
}