/// @description o_con Create event

randomize();

global.cell_size = 32;

global.half_c = global.cell_size / 2;

global.default_fnt = fnt_8;

draw_set_font(global.default_fnt);
	
global.map_grid = ds_grid_create(room_width div global.cell_size, room_height div global.cell_size);

global.grid_w = ds_grid_width(global.map_grid);
global.grid_h = ds_grid_height(global.map_grid);

show_debug_message($"grid_w: {global.grid_w}, grid_h: {global.grid_h}");

ds_grid_clear(global.map_grid,grid_cell.empty);

global.visited_grid = ds_grid_create(global.grid_w,global.grid_h);
ds_grid_clear(global.visited_grid, UNVISITED_CELL);

global.steps_grid = ds_grid_create(global.grid_w,global.grid_h);
ds_grid_clear(global.steps_grid, UNVISITED_STEP_VAL);

global.terrain_grid = ds_grid_create(global.grid_w,global.grid_h);
ds_grid_clear(global.terrain_grid, 0);

//scr_randomize_grid();

scr_define_grids_from_tilemap();

//a star pathing vars:
//Will contain priority values, and a 'frontier queue struct', which contains the x and y coordinates of that cell
global.frontier_queue = ds_priority_create(); 

origin_x = -1;
origin_y = -1;
dest_x = -1;
dest_y = -1;
pather_x = -1;
pather_y = -1;

failsafe_val = 0;
failsafe_max = global.grid_w*global.grid_h+1;

path_points_ar = [];

directional_ar = [];
for(var i = 0; i < 8; i++) {
	if i == 0 {
		array_push(directional_ar,{ check_dir_x : -1, check_dir_y : 0 }); //west	
	}
	else if i == 1 {
		array_push(directional_ar,{ check_dir_x : 0, check_dir_y : -1 }); //north	
	}
	else if i == 2 {
		array_push(directional_ar,{ check_dir_x : 1, check_dir_y : 0 }); //east	
	}
	else if i == 3 {
		array_push(directional_ar,{ check_dir_x : 0, check_dir_y : 1 }); //south	
	}
	else if i == 4 {
		array_push(directional_ar,{ check_dir_x : -1, check_dir_y : -1 }); //NW	
	}
	else if i == 5 {
		array_push(directional_ar,{ check_dir_x : 1, check_dir_y : -1 }); //NE	
	}
	else if i == 6 {
		array_push(directional_ar,{ check_dir_x : 1, check_dir_y : 1 }); //SE	
	}
	else if i == 7 {
		array_push(directional_ar,{ check_dir_x : -1, check_dir_y : 1 }); //SW	
	}
}

prev_mouse_grid_x = -1;
prev_mouse_grid_y = -1;

global.cur_game_state = game_state.browsing_cells;

global.wait = true;
global.wait_time = 2;
global.plotting_path = false;

alarm[0] = global.wait_time;

global.path_successful = false;

global.cur_char = -1;



