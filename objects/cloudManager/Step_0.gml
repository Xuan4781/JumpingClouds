// --- Step Event for o_cloudManager ---

var num_clouds = instance_number(o_cloud);
frames_since_cloud += 1;

// Settings
var padding_x = 80;     // horizontal padding from walls
var padding_y_top = 80; // top padding
var padding_y_bottom = 200; // bottom padding (avoid HUD/ground)
var max_tries = 100;

// Ensure we have at least 5 clouds or it's time to spawn new one
if (frames_since_cloud > frames_between_cloud || num_clouds < 5) {
    if (num_clouds < max_clouds) {
        var new_x, new_y;
        var tries = 0;
        var valid_position = false;

        while (!valid_position && tries < max_tries) {
            tries += 1;

            // pick random position *within padded boundaries*
            new_x = random_range(padding_x, room_width - padding_x);
            new_y = random_range(padding_y_top, room_height - padding_y_bottom);

            // size of smallest cloud
            var _w = sprite_get_width(s_cloud1);
            var _h = sprite_get_height(s_cloud1);

            // check that it doesn't overlap another cloud
            if (collision_rectangle(
                new_x - _w/2, new_y - _h/2,
                new_x + _w/2, new_y + _h/2,
                o_cloud, false, true
            ) == noone) {
                valid_position = true;
            }
        }

        // create the new cloud if position is valid
        if (valid_position) {
            instance_create_layer(new_x, new_y, "Instances", o_cloud);
        }

        frames_since_cloud = 0;
    }
}
