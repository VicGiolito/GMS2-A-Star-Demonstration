/// @description o_con step event

if keyboard_check_released(vk_f1) game_restart();
if keyboard_check_released(vk_f2) game_end();

var mouse_grid_x = mouse_x div global.cell_size;
var mouse_grid_y = mouse_y div global.cell_size;

if global.cur_game_state == game_state.browsing_cells {
	
	if mouse_check_button_released(mb_left) && scr_mouse_within_grid(mouse_grid_x,mouse_grid_y) 
	&& global.map_grid[# mouse_grid_x,mouse_grid_y] != grid_cell.wall {
		
		origin_x = mouse_grid_x;
		origin_y = mouse_grid_y;
		
		global.cur_game_state = game_state.plotting_path;
		
		prev_mouse_grid_x = mouse_grid_x;
		prev_mouse_grid_y = mouse_grid_y;
		
		scr_reset_wait();
	}
}

else if global.cur_game_state == game_state.plotting_path { 
	
	if !global.wait && !global.plotting_path && scr_mouse_within_grid(mouse_grid_x,mouse_grid_y) && global.map_grid[# mouse_grid_x,mouse_grid_y] != grid_cell.wall 
	&& (prev_mouse_grid_x != mouse_grid_x || prev_mouse_grid_y != mouse_grid_y) {
		
		if (mouse_grid_x != origin_x || mouse_grid_y != origin_y) {
		
			scr_reset_wait();
		
			if scr_return_chebyshev_dist(origin_x,origin_y,dest_x,dest_y) >= 1 {
			
				prev_mouse_grid_x = mouse_grid_x;
				prev_mouse_grid_y = mouse_grid_y;
			
				dest_x = mouse_grid_x;
				dest_y = mouse_grid_y;
			
				global.plotting_path = true;
			
				if scr_a_star_plot_path_to_dest(true) {
					scr_a_star_plot_path_to_start(true);	
				} 
		
				else { //Reset some vars:
					global.plotting_path = false;
					path_points_ar = -1;
					path_points_ar = [];
					failsafe_val = 0;
					global.cur_game_state = game_state.browsing_cells;
					ds_priority_clear(global.frontier_queue);
					ds_grid_clear(global.steps_grid,UNVISITED_STEP_VAL);
					ds_grid_clear(global.visited_grid, UNVISITED_CELL);
					global.path_successful = false;
					if instance_exists(o_char) instance_destroy(o_char);
				}
			}
		}
	}
	
	//Reset vars and game state to create a new path:
	if !global.wait && mouse_check_button_released(mb_right) {
		global.plotting_path = false;
		path_points_ar = -1;
		path_points_ar = [];
		failsafe_val = 0;
		global.cur_game_state = game_state.browsing_cells;
		ds_priority_clear(global.frontier_queue);
		ds_grid_clear(global.steps_grid,UNVISITED_STEP_VAL);
		ds_grid_clear(global.visited_grid, UNVISITED_CELL);
		global.path_successful = false;
		if instance_exists(o_char) instance_destroy(o_char);
	}
	
	//'launch' our char object to follow the path points we've created:
	if is_array(path_points_ar) && array_length(path_points_ar) > 1 && global.path_successful
	&& global.plotting_path == false && keyboard_check_released(vk_enter) && !global.wait {
		
		scr_reset_wait();
		
		show_debug_message($"CREATING FUCKING O__CHAR!");
		
		if instance_exists(o_char) instance_destroy(o_char);
		
		global.cur_char = instance_create_layer(origin_x*global.cell_size+global.half_c,
		origin_y*global.cell_size+global.half_c,"layer_main",o_char);
		
		var p = path_points_ar;
		
		with(global.cur_char) {
			path_ar = p;
			path_len = array_length(path_ar);
			next_path_point_x = path_ar[next_path_point_index].room_x;
			next_path_point_y = path_ar[next_path_point_index].room_y;	
		}
		
		global.cur_game_state = game_state.instance_following_path;
	}
}

else if global.cur_game_state == game_state.instance_following_path {
	
	if instance_exists(o_char) {
		
		if scr_instance_follows_path(global.cur_char) == false { //We've reached the end of our path:
		
			if instance_exists(o_char) instance_destroy(o_char);
			global.plotting_path = false;
			path_points_ar = -1;
			path_points_ar = [];
			failsafe_val = 0;
			global.cur_game_state = game_state.browsing_cells;
			ds_priority_clear(global.frontier_queue);
			ds_grid_clear(global.steps_grid,UNVISITED_STEP_VAL);
			ds_grid_clear(global.visited_grid, UNVISITED_CELL);
			global.path_successful = false;	
		}
	}
}


//Always update prev_mouse coords regardless of what state we're in:
prev_mouse_grid_x = mouse_grid_x;
prev_mouse_grid_y = mouse_grid_y;












