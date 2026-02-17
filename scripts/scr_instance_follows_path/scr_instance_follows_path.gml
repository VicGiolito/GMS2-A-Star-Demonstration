

function scr_instance_follows_path(inst_id){
	
	with(inst_id) {
	
		show_debug_message($"Entering scr_instance_follows_path: inst_id == {inst_id}, inst_id.x : {x}, inst_id.y : {y}, inst_id.next_path_point_index: {next_path_point_index}, inst_id.path_len: {path_len} "+
		$"inst_id.next_path_point_x: {next_path_point_x}, inst_id.next_path_point_y: {next_path_point_y} ");
	
		if next_path_point_index < path_len {
		
			//Adjust path speed so we don't over-shoot our target:
			//var dist_to_dest = point_distance(inst_id.x,inst_id.y,inst_id.path_ar[inst_id.path_len - 1].room_x,inst_id.path_ar[inst_id.path_len - 1].room_y);
			var x_dist = abs(x - next_path_point_x);
			var y_dist = abs(y - next_path_point_y);
		
			if x_dist < cur_path_spd_x {
				cur_path_spd_x = x_dist;	
			}
			if y_dist < cur_path_spd_y {
				cur_path_spd_y = y_dist;	
			}
		
			if x > next_path_point_x x -= cur_path_spd_x;
			else if x < next_path_point_x x += cur_path_spd_x;
	
			if y > next_path_point_y y -= cur_path_spd_y;
			else if y < next_path_point_y y += cur_path_spd_y;
		
			//We've reached our destination:
			if x == next_path_point_x && y == next_path_point_y {
		
				next_path_point_index++;
			
				//If we've reached our last path point, return false, we're done moving.
				if next_path_point_index >= path_len {
					show_debug_message($"!!!!!!!!!! Entering scr_instance_follows_path: our char object reached its DESTINATION! !!!!!!!!!!!!");
					return false;
				}
			
				//Otherwise, reset vars:
				cur_path_spd_x = base_path_spd;
				cur_path_spd_y = base_path_spd;
			
				next_path_point_x = path_ar[next_path_point_index].room_x;
				next_path_point_y = path_ar[next_path_point_index].room_y;
			}
		
			return true;
		}
		else {
			return false;	
		}
	}
}