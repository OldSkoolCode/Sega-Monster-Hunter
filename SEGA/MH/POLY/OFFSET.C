	if (gXtoY)
		{
#if ANGLE_MEASURE
		start_x = (float)-gwidth1 * cosYaw * .5;
		start_y = (float)gmy - (gwidth1 * sinYaw* .5);
		start_angle = atan2 (start_y,start_x);
		if (start_angle < 0)
			start_angle += PI * 2;
		tanYaw = sinYaw/cosYaw;
		end_x = gwidth1 * cosYaw * .5;
		end_y = gmy + (gwidth1 * sinYaw * .5);
		end_angle = atan2 (end_y,end_x);
		width_angle = start_angle - end_angle;
		width_slice = width_angle/(float)(gDestWidth/2);
		dist_width = gwidth1;
		
		temp_angle = start_angle;
		for (i = 0; i < gDestWidth/2; i++)
			{
			temp_angle -= width_slice;
			slope = tan(temp_angle);
			temp_x = (float)gmy / (slope - tanYaw);
			temp_y = slope * temp_x;
			dist = (start_x - temp_x) * (start_x - temp_x);
			dist += (start_y - temp_y) * (start_y - temp_y);
			dist = sqrt(dist);
			dist = dist/dist_width;
			offsets[i] = (int) (PANELWIDTH/2 * dist);
			}
