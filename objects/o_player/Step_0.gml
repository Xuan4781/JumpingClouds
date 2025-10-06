hit_this_frame = false;

x_vel *= 0.9;
y_vel += grav;
r_x += x_vel;
r_y += y_vel;
var to_move_x = round(r_x);
var to_move_y = round(r_y);
r_x -= to_move_x;
r_y -= to_move_y;
var dir = sign(to_move_y);

// collision
while (to_move_y != 0) {
	var colliding = false;
	var collidewith = noone;

	if (dir >= 0 && !was_hit_by_player) {
		// cloud
		collidewith = instance_place(x, y + dir, o_cloud);
		if (collidewith != noone) {
			with (collidewith) {
				if (state == "idle") {
					state = "dissolving";
					audio_play_sound(so_bounce, 1, false);
					image_speed = 0.3;
					solid = false;
				}
			}
			colliding = true;
		}

		// player 
		if (!colliding && !hit_this_frame) {
			collidewith = instance_place(x, y + dir, opponent_object);
			if (collidewith != noone) {
				if (y + sprite_height/2 <= collidewith.y) {
					hit_this_frame = true;
					with (collidewith) {
						was_hit_by_player = true;
						audio_play_sound(so_hit, 1, false);
						sprite_index = my_hit_sprite;
						y_vel = 5;
					}
					instance_create_layer(x, y, "Instances", o_star);
					
					// scoring
					if (playerIndex == 1) {
						global.p1_score += 1;
						global.p2_score -= 1;
					} else {
						global.p2_score += 1;
						global.p1_score -= 1;
					}
					colliding = true;
				}
			}
		}
	}

	if (!colliding) {
		y += dir;
		to_move_y -= dir;
	} else {
		y_vel = bounce_vel;
		r_y = 0;
		break;
	}
}

// horzontal and padding
x += to_move_x;
var half_w = sprite_width / 2;
if (x < half_w) { x = half_w; x_vel = abs(x_vel); r_x = 0; audio_play_sound(so_wall, 1, false); }
if (x > room_width - half_w - 100) { x = room_width - half_w - 100; x_vel = -abs(x_vel); r_x = 0; audio_play_sound(so_wall, 1, false); }

// player movement
if (!was_hit_by_player) {
	if (keyboard_check(left_key)) {
		x_vel -= accel;
		if (playerIndex == 1) sprite_index = s_p1left;
		else sprite_index = s_p2left;
	}
	if (keyboard_check(right_key)) {
		x_vel += accel;
		if (playerIndex == 1) sprite_index = s_p1right;
		else sprite_index = s_p2right;
	}
}

// respawn
if (active) {
	if (place_meeting(x, y, o_particles) && y_vel > 0) {
		if (!was_hit_by_player) {
			audio_play_sound(so_death, 1, false);
			instance_create_layer(x, y, "Instances", o_star);
			if (playerIndex == 1) global.p1_score -= 1;
			else global.p2_score -= 1;
		}
		active = false;
		visible = false;
		respawn_timer = room_speed * 2;
		y_vel = 0;
		r_y = 0;
	}
} else {
	if (respawn_timer > 0) respawn_timer -= 1;
	else {
		audio_play_sound(so_spawn, 1, false);
		y = room_height - sprite_height/2;
		y_vel = initial_bounce;
		r_y = 0;
		active = true;
		visible = true;
		was_hit_by_player = false;
		sprite_index = default_sprite; 
	}
}

// animating
image_speed = 0;
if (y_vel < 0) image_index = 0;
else if (y_vel > 0) image_index = 1;
