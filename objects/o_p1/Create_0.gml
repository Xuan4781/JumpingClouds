active = true;
y = room_height - sprite_height/2;
respawn_timer = 0;
y_vel = initial_bounce;

default_sprite = s_p1right;
was_hit_by_player = false;



// Start as a static cloud
image_speed = 0;
state = "idle";

left_key = ord("A");
right_key = ord("D");
playerIndex = 1;
opponent_object = o_p2;
my_hit_sprite = s_p1fall;