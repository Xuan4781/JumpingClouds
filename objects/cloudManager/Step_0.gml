var num_clouds = instance_number(o_cloud);
frames_since_cloud += 1;

// Ensure we have at least 5 clouds at start
if (frames_since_cloud > frames_between_cloud || num_clouds < 5) {
    if (num_clouds < max_clouds) {
        var new_x, new_y;
        var tries = 0;
        var valid_position = false;

        // try to make sure the clouds dont overlap
        while (!valid_position && tries < 100) {
            tries += 1;
            
            // random spot
            new_x = random_range(80, room_width - 80);
            new_y = random_range(80, room_height - 200);

            // dimension of smallest cloud
            var _w = sprite_get_width(s_cloud1);
            var _h = sprite_get_height(s_cloud1);

            if (collision_rectangle(new_x - _w/2, new_y - _h/2, new_x + _w/2, new_y + _h/2, o_cloud, false, true) == noone) {
                valid_position = true;
            }
        }

        if (valid_position) {
            instance_create_layer(new_x, new_y, "Instances", o_cloud);
        }

        frames_since_cloud = 0;
    }
}