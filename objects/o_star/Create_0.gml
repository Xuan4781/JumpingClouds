if (sprite_get_number(sprite_index) > 1) {
    image_index = irandom(image_number - 1);
}

vspeed = random_range(-3, -6);
hspeed = random_range(-3, 3);

// fall
gravity = 0.2;
gravity_direction = 270;

// make the star bigger
image_xscale = random_range(1.5, 2.5);
image_yscale = image_xscale; 
