/// @description o_con draw event

var step_val, terrain_val, y_offset = 16;

for(var xx = 0; xx < global.grid_w; xx++) {
	
	for(var yy = 0; yy < global.grid_h; yy++) {
		
		step_val = global.steps_grid[# xx,yy];
		
		terrain_val = global.terrain_grid[# xx,yy];
		
		if step_val != UNVISITED_STEP_VAL {
			draw_text_color(xx*global.cell_size+4,yy*global.cell_size+4,string(step_val),c_purple,c_purple,c_purple,c_purple,1);
		}
		
		if terrain_val != UNVISITED_STEP_VAL {
			draw_text_color(xx*global.cell_size+4,yy*global.cell_size+y_offset,string(terrain_val),c_blue,c_blue,c_blue,c_blue,1);
		}
	}
}

//Draw icons:
if pather_x != -1 && pather_y != -1 {
	draw_sprite(spr_path_coord,0,pather_x*global.cell_size+global.half_c,pather_y*global.cell_size+global.half_c);
}
if origin_x != -1 && origin_y != -1 {
	draw_sprite(spr_start_icon,0,origin_x*global.cell_size+global.half_c,origin_y*global.cell_size+global.half_c);
}
if dest_x != -1 && dest_y != -1 {
	draw_sprite(spr_dest_icon,0,dest_x*global.cell_size+global.half_c,dest_y*global.cell_size+global.half_c);
}

if is_array(path_points_ar) && array_length(path_points_ar) > 0 {
	var ar_len = array_length(path_points_ar), ppx, ppy;
	for(var i = 0; i < ar_len; i++) {
		ppx = path_points_ar[i].room_x;
		ppy = path_points_ar[i].room_y;
		
		draw_sprite(spr_path_point,0,ppx,ppy);
	}
}





