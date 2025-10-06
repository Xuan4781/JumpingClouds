if (state == "dissolving") {
    // playing the sprite cloud animation
    if (image_index < image_number - 1) {
        image_index += image_speed;
    } else {
        instance_destroy();
    }

} else {
    transition_timer -= 1;
    if (transition_timer <= 0) {
        if (cloud_size < 4) {
            cloud_size += 1;
        }
        transition_timer = transition_delay;
    }

    switch (cloud_size) {
        case 1: sprite_index = s_cloud1; break;
        case 2: sprite_index = s_cloud2; break;
        case 3: sprite_index = s_cloud3; break;
        case 4: sprite_index = s_cloud4; break;
    }
    image_speed = 0;
}
