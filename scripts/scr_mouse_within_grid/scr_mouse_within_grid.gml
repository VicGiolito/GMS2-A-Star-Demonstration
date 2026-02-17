

function scr_mouse_within_grid(mouse_grid_x,mouse_grid_y){
	
	if mouse_grid_x >= 0 && mouse_grid_x < global.grid_w && mouse_grid_y >= 0 &&
	mouse_grid_y < global.grid_h { 
		return true; 
	}
	
	return false;
}