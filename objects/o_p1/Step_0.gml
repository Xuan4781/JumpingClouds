//the closer you are the slower you are
x_vel *= 0.9;	//take x vel and slowing it down
y_vel += grav;

r_x += x_vel;	//r_x is remainder x,taking remainder and adding it to our vel and rounding it and moving it
r_y += y_vel;

//round
var to_move_x = round(r_x);
var to_move_y = round(r_y);

//remove the rounded amount
r_x -= to_move_x;
r_y -= to_move_y;

var dir = sign(to_move_y);

//are we colliding yet, are we colliding yet
//do this also but for o_p2
while(to_move_y != 0){
	var colliding = false;
	var collidewith = noone;
	if (dir >= 0){
		//checking if we are falling
		//check if we will collide with floor (clouds)
		collidewith = instance_place(x, y + dir, o_cloud);
		if(collidewith != noone){
			//if we arent already overlapping with that instance
			instance_destroy(collidewith);
			if(place_meeting(x, y, collidewith) == false){
				//set colliding to true
				colliding = true;
			}
		}
		collidewith = instance_place(x, y + dir, o_p2);
		if(collidewith != noone){
			//if we arent already overlapping with that instance
			if(place_meeting(x, y, collidewith) == false){
				//set colliding to true
				// NEED TO MAKE OTHER PLAYER FALL
				
			}
		}
	}
	if(!colliding){
		y += dir;
		to_move_y -= dir;
	} else {
		y = y + dir;
		y_vel = bounce_vel;
		r_y = 0;
		break;
	}
}

if (active) {
    if (y >= room_height - sprite_height/2) {
        y = room_height - sprite_height/2;
        // disappear and set respawn countdown
        active = false;
        visible = false;
        respawn_timer = room_speed * 2; // 3 seconds
        y_vel = 0;
        r_y = 0;
    }
} else {
    // countdown until respawn
    if (respawn_timer > 0) {
        respawn_timer -= 1;
    } else {
        // respawn at bottom with bounce
        y = room_height - sprite_height/2;
        y_vel = initial_bounce;
        r_y = 0;
        active = true;
        visible = true;
    }
}





//find the dist between two walls w/some padding
var dist_to_r_wall = room_width - x - 8;
var dist_to_l_wall = x - 8;

if(to_move_x >= dist_to_r_wall){
	//push back the player
	//reverse the speed
	//remove all remaining x speed values
	x = room_width -9;
	x_vel = abs(x_vel) * -1;
	r_x = 0;
	//if we're past the left wall
} else if (to_move_x < -dist_to_l_wall){
	x = 9;
	x_vel = abs(x_vel);
	r_x = 0;
	//if no walls, just move normally
} else {
	x += to_move_x;
}


if(keyboard_check(ord(left_key))){
	x_vel -= accel; // we want our x to be all the way over here slowing down vel 
}
if(keyboard_check(ord(right_key))){
	x_vel += accel;
}

