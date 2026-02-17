
function scr_define_macros_and_enums(){
	
	//grid cell values:
	enum grid_cell {
		empty, //0
		wall,
		plains,
		forest,
		swamp,
		mountain,
		road
	}
	
	enum game_state {
		browsing_cells,
		plotting_path,
		instance_following_path
	}
	
	#macro UNVISITED_CELL 0
	#macro VISITED_CELL 1
	
	#macro UNVISITED_STEP_VAL 999999999
	
	#macro TERRAIN_VAL_PLAINS 2
	#macro TERRAIN_VAL_ROAD 1
	#macro TERRAIN_VAL_SWAMP 16
	#macro TERRAIN_VAL_MOUNTAIN 8
	#macro TERRAIN_VAL_FOREST 4
	
	#macro GRID_ENCODE 1000000  // must be larger than your max grid width; removes the need for creating structs to store separate grid_x and grid_y vars.
}



/*A note on 'heuristic tie-breaking'; ie: var dist_to_dest = scr_return_chebyshev_dist(checking_cell_x, checking_cell_y, dest_x, dest_y) * 1.001;
When two nodes have the same f(n) value, A* has no preference between them and may explore both. In open areas this happens a lot — many cells will have identical f values, so A* fans out and explores a bunch of nodes that are all equally scored.
Tie-breaking gives A* a slight preference so it picks one path and commits rather than exploring many equivalent options. The idea is to favor nodes with a higher g(n), because a higher g means you've traveled further from the start, which means you're closer to the goal. Between two nodes with the same f, the one that's closer to the goal is more likely to be on the final path.
The simplest way to implement it is to multiply your heuristic by a tiny factor just above 1: