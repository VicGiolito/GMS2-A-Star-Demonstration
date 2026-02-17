

function scr_return_chebyshev_dist(x1,y1,x2,y2){
	
	var dist_x = abs(x1-x2);
	var dist_y = abs(y1-y2);
	
	var chebyshev_dist = max(dist_x, dist_y);
	
	return chebyshev_dist;
}