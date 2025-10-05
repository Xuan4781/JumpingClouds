var num_clouds = instance_number(o_cloud);  //keeping track of #clouds
//hey every frame in step, increase 
frames_since_cloud += 1;

//we want to have 5 clouds at the start of the clouds
if(frames_since_cloud > frames_between_cloud || num_clouds < 5){ //5 because at least 5 clouds first
	if(num_clouds < max_clouds){
		//make sure we are in the right layer
		var new_cloud = instance_create_layer(
			random_range(30, room_width -30), //wanna make sure 30 away from the left edge and 30 away from right edge
			random_range(80, room_height - 200), //80 from the bottom and 200 from the top
			"Instances",
			o_cloud
		);	
		
		with (new_cloud) {
            var tries = 0;
            while (tries < 3000 && collision_rectangle(x-8, y-8, x+16, y+16, o_cloud, false, true)) {
                x = random_range(30, room_width - 30);
                y = random_range(80, room_height - 200);
                tries += 1;
            }
        }

        frames_since_cloud = 0;
    }
}


